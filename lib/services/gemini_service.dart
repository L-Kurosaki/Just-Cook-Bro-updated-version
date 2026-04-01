import 'dart:convert';
import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import '../models.dart';

// Helper to clean quotes if they get stuck in the build process
String _cleanKey(String value) {
  if ((value.startsWith('"') && value.endsWith('"')) || (value.startsWith("'") && value.endsWith("'"))) {
    return value.substring(1, value.length - 1);
  }
  return value;
}

// Fetch specific keys for different functionalities to prevent rate limiting and token abuse
String _getKey(String envVar) {
  final key = String.fromEnvironment(envVar);
  if (key.isNotEmpty && !key.startsWith('\$')) return _cleanKey(key);
  
  // Fallback to a default key if specific one isn't provided
  final fallback = String.fromEnvironment('GEMINI_API_KEY');
  if (fallback.isNotEmpty && !fallback.startsWith('\$')) return _cleanKey(fallback);
  
  return ''; 
}

class GeminiService {
  // Separate models for different tasks to optimize cost and performance
  late final GenerativeModel _recipeModel; // Uses Pro for complex JSON schema
  late final GenerativeModel _visionModel; // Uses Flash for fast image processing
  late final GenerativeModel _locationModel; // Uses Flash for fast text
  late final GenerativeModel _chatModel; // Uses Flash for fast text

  late final String _recipeKey;
  late final String _visionKey;
  late final String _locationKey;
  late final String _chatKey;

  GeminiService() {
    // 1. Recipe Generation (Complex Reasoning -> gemini-1.5-pro)
    _recipeKey = _getKey('GEMINI_API_KEY_RECIPE');
    _recipeModel = GenerativeModel(
      model: 'gemini-1.5-pro', 
      apiKey: _recipeKey,
    );
    
    // 2. Vision/Image Analysis (Fast Multimodal -> gemini-1.5-flash)
    _visionKey = _getKey('GEMINI_API_KEY_VISION');
    _visionModel = GenerativeModel(
      model: 'gemini-1.5-flash', 
      apiKey: _visionKey,
    );

    // 3. Location/Shop Finding (Fast Text -> gemini-1.5-flash)
    _locationKey = _getKey('GEMINI_API_KEY_LOCATION');
    _locationModel = GenerativeModel(
      model: 'gemini-1.5-flash', 
      apiKey: _locationKey,
    );

    // 4. Chat/Cooking Help (Fast Text -> gemini-1.5-flash)
    _chatKey = _getKey('GEMINI_API_KEY_CHAT');
    _chatModel = GenerativeModel(
      model: 'gemini-1.5-flash', 
      apiKey: _chatKey,
    );
  }

  String _cleanJson(String text) {
    try {
      final startIndex = text.indexOf('{');
      final endIndex = text.lastIndexOf('}');
      if (startIndex != -1 && endIndex != -1) {
        return text.substring(startIndex, endIndex + 1);
      }
    } catch (e) {
      // Fallback
    }
    return text.replaceAll('```json', '').replaceAll('```', '').trim();
  }

  String _buildPreferencePrompt(UserProfile? profile) {
    if (profile == null) return "";
    String p = "";
    if (profile.dietaryPreferences.isNotEmpty) {
      p += " CRITICAL REQUIREMENT: The user strictly follows these diets: ${profile.dietaryPreferences.join(', ')}. The recipe MUST adhere to this.";
    }
    if (profile.allergies.isNotEmpty) {
      p += " CRITICAL WARNING: The user is ALLERGIC to: ${profile.allergies.join(', ')}. Do NOT include these ingredients under any circumstances. LIST POTENTIAL ALLERGENS EXPLICITLY.";
    }
    return p;
  }

  final _recipeSchema = jsonEncode({
    "title": "String",
    "description": "String",
    "prepTime": "String",
    "cookTime": "String",
    "servings": "Number",
    "author": "String",
    "sourceUrl": "String (optional, if from link)",
    "ingredients": [{"name": "String", "amount": "String", "category": "String"}],
    "steps": [{"instruction": "String", "timeInSeconds": "Number", "tip": "String", "warning": "String"}],
    "tags": ["String (e.g. Vegan, Keto, Spicy)"],
    "allergens": ["String - CRITICAL: List any allergens found like Nuts, Dairy, Gluten, Shellfish"]
  });

  // --- Recipe Generation ---

  Future<Recipe> generateRecipeFromText(String prompt, {UserProfile? profile}) async {
    if (_recipeKey.isEmpty) {
      throw Exception("Recipe API Key is missing. Check 'GEMINI_API_KEY_RECIPE' environment.");
    }

    String fullPrompt = "";
    String sourceUrl = "";

    // Specific logic for Links
    if (prompt.toLowerCase().contains('http') || prompt.toLowerCase().contains('www.')) {
      fullPrompt = 'Use your knowledge to extract the recipe details for this video or link: "$prompt". '
          'Extract the ingredients and cooking steps accurately. '
          'Credit the source domain in sourceUrl. ';
      sourceUrl = prompt;
    } else {
      fullPrompt = 'Create a detailed cooking recipe for: "$prompt". ';
    }

    fullPrompt += _buildPreferencePrompt(profile);
    fullPrompt += ' Return strict JSON: $_recipeSchema. ';
    
    if (sourceUrl.isNotEmpty) {
      fullPrompt += 'Set "author" to the original creator if known, otherwise "Web Source". Set "sourceUrl" to "$sourceUrl". ';
    } else {
      fullPrompt += 'Set "author" to "AI Chef". ';
    }

    try {
      final content = [Content.text(fullPrompt)];
      final response = await _recipeModel.generateContent(content);
      
      final text = response.text;
      if (text == null) throw Exception("Empty AI response");
      
      final cleanText = _cleanJson(text);
      final data = jsonDecode(cleanText);
      return _processRecipeResponse(data);
    } catch (e) {
      print('Gemini failed: $e');
      if (e.toString().contains('API_KEY_INVALID')) {
        throw Exception("Invalid API Key. Please check the key in GitHub Secrets.");
      }
      if (e.toString().contains('429')) {
        throw Exception("Quota exceeded. The API key has reached its limit.");
      }
      throw Exception("AI Error: ${e.toString().replaceAll('Exception:', '').trim()}");
    }
  }

  // --- SAFETY CHECK & VISION ---

  Future<void> _validateImageIsFood(Uint8List imageBytes) async {
    if (_visionKey.isEmpty) throw Exception("Vision API Key is missing.");

    final prompt = "Is this image a food item, a dish, or a cooking ingredient? Answer only YES or NO.";
    final content = [
      Content.multi([
        TextPart(prompt),
        DataPart('image/jpeg', imageBytes),
      ])
    ];

    try {
      final response = await _visionModel.generateContent(content);
      final text = response.text?.trim().toUpperCase() ?? "NO";

      if (!text.contains("YES")) {
        throw Exception("Image does not appear to be food. Please upload a valid cooking ingredient or dish.");
      }
    } catch (e) {
      print("Vision validation failed: $e");
      throw Exception("Could not validate image: ${e.toString()}");
    }
  }

  Future<List<String>> generateOptionsFromImage(Uint8List imageBytes) async {
    await _validateImageIsFood(imageBytes);

    final prompt = 'Look at this food image. Suggest exactly 6 specific, distinct recipe names that could represent this dish. Return ONLY a JSON array of strings.';
    
    final content = [
      Content.multi([
        TextPart(prompt),
        DataPart('image/jpeg', imageBytes),
      ])
    ];

    try {
      final response = await _visionModel.generateContent(content);
      final text = response.text ?? '[]';
      final cleanText = _cleanJson(text);
      final List<dynamic> list = jsonDecode(cleanText);
      return list.map((e) => e.toString()).toList();
    } catch (e) {
      print("Vision failed: $e");
      throw Exception("Failed to analyze image: $e");
    }
  }

  Future<Recipe> generateRecipeFromOption(String selectedOption, Uint8List imageBytes, {UserProfile? profile}) async {
    String prompt = 'Generate a detailed recipe for "$selectedOption" based on the provided image. '
        'Ensure the "author" field references "Visual AI".';
    
    prompt += _buildPreferencePrompt(profile);
    prompt += ' Return strict JSON: $_recipeSchema';

    final content = [
      Content.multi([
        TextPart(prompt),
        DataPart('image/jpeg', imageBytes),
      ])
    ];

    final response = await _visionModel.generateContent(content);
    final text = response.text;
    if (text == null) throw Exception("Empty AI response");

    final cleanText = _cleanJson(text);
    final data = jsonDecode(cleanText);
    
    return _processRecipeResponse(data, imageUrlOverride: _generateAiImageUrl(selectedOption));
  }

  Recipe _processRecipeResponse(Map<String, dynamic> data, {String? imageUrlOverride}) {
      List<dynamic> ingredients = data['ingredients'] ?? [];
      for (var ing in ingredients) {
        ing['imageUrl'] = _generateAiImageUrl(ing['name'] + " ingredient white background");
      }
      
      String title = data['title'] ?? 'Food';
      data['imageUrl'] = imageUrlOverride ?? _generateAiImageUrl(title + " food photography");
      
      return Recipe.fromJson(data);
  }

  String _generateAiImageUrl(String prompt) {
    final encoded = Uri.encodeComponent(prompt);
    return 'https://image.pollinations.ai/prompt/$encoded?width=800&height=600&model=flux&seed=${DateTime.now().millisecondsSinceEpoch}';
  }

  // --- Real Location Services (In-App) ---

  Future<List<Map<String, String>>> findShopsNearby(String ingredient) async {
    if (_locationKey.isEmpty) return [];
    
    // 1. Get Coordinates
    try {
      Position position = await _determinePosition();
      
      final prompt = "I am at Latitude: ${position.latitude}, Longitude: ${position.longitude}. "
          "Recommend 3 real supermarket chains or grocery store names that are likely to exist near this location and would sell '$ingredient'. "
          "Return JSON array: [{'name': 'Store Name', 'vicinity': 'Approx distance 1.2km'}]";

      final response = await _locationModel.generateContent([Content.text(prompt)]);
      final text = response.text ?? '[]';
      final cleanText = _cleanJson(text);
      final List<dynamic> list = jsonDecode(cleanText);
      
      return list.map((e) => {
        'name': e['name'].toString(),
        'vicinity': e['vicinity'].toString()
      }).toList();

    } catch (e) {
      // Fallback
      return [
        {'name': 'Local Supermarket', 'vicinity': 'Nearby'},
        {'name': 'Grocery Store', 'vicinity': 'Nearby'},
        {'name': 'Market', 'vicinity': 'Nearby'},
      ];
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> getCookingHelp(String instruction) async {
    if (_chatKey.isEmpty) return 'Cooking assistant offline.';
    try {
      final response = await _chatModel.generateContent([
        Content.text('Cooking step: "$instruction". Give a short, funny or encouraging tip (max 15 words).')
      ]);
      return response.text ?? 'You got this!';
    } catch (e) {
      return 'Keep going, chef!';
    }
  }
}