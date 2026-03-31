import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/auth_screen.dart';
import 'screens/main_screen.dart';
import 'screens/splash_screen.dart';
import 'services/revenue_cat_service.dart';

// ==========================================
// CONFIGURATION
// ==========================================

String _cleanKey(String value) {
  if ((value.startsWith('"') && value.endsWith('"')) || (value.startsWith("'") && value.endsWith("'"))) {
    return value.substring(1, value.length - 1);
  }
  return value;
}

String _getUrl() {
  const url = String.fromEnvironment('SUPABASE_URL');
  const urlAlt = String.fromEnvironment('super_base_url');
  
  if (url.isNotEmpty && !url.startsWith('\$')) return _cleanKey(url);
  if (urlAlt.isNotEmpty && !urlAlt.startsWith('\$')) return _cleanKey(urlAlt);
  return 'https://ltkfrfsowjgrdnqzewah.supabase.co'; // Fallback
}

String _getAnonKey() {
  const key = String.fromEnvironment('SUPABASE_ANON_KEY');
  const keyAlt = String.fromEnvironment('super_base_key');
  
  if (key.isNotEmpty && !key.startsWith('\$')) return _cleanKey(key);
  if (keyAlt.isNotEmpty && !keyAlt.startsWith('\$')) return _cleanKey(keyAlt);
  return ''; // Removed hardcoded key to pass GitHub secret scanning
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Initialize Supabase
  try {
    await Supabase.initialize(url: _getUrl(), anonKey: _getAnonKey());
  } catch (e) {
    print("Supabase Init Error: $e");
  }

  // 2. Initialize RevenueCat
  await RevenueCatService().init();

  runApp(const JustCookBroApp());
}

class JustCookBroApp extends StatefulWidget {
  const JustCookBroApp({super.key});

  @override
  State<JustCookBroApp> createState() => _JustCookBroAppState();
}

class _JustCookBroAppState extends State<JustCookBroApp> {
  bool _showSplash = true;

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(onFinish: () => setState(() => _showSplash = false)),
      );
    }

    final client = Supabase.instance.client;
    final session = client.auth.currentSession;
    
    // Listen to Premium Status to change the whole app Theme
    return ValueListenableBuilder<bool>(
      valueListenable: RevenueCatService().premiumNotifier,
      builder: (context, isPremium, child) {
        
        // Define Colors based on status
        final primaryColor = isPremium ? const Color(0xFFFFD700) : const Color(0xFFC9A24D); // Gold vs Bronze
        final surfaceTint = isPremium ? const Color(0xFFFFF8E1) : Colors.white;

        return MaterialApp(
          title: 'Just Cook Bro',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: primaryColor,
              primary: primaryColor,
              background: surfaceTint,
              surface: Colors.white,
            ),
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'Inter',
            // Customizing icons globally for premium feel
            iconTheme: IconThemeData(
              color: isPremium ? const Color(0xFFDAA520) : const Color(0xFF2E2E2E),
            ),
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: isPremium ? const Color(0xFFDAA520) : Colors.black),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: isPremium ? const Color(0xFFDAA520) : const Color(0xFFC9A24D),
              unselectedItemColor: Colors.grey,
            )
          ),
          home: session != null ? const MainScreen() : const AuthScreen(),
        );
      }
    );
  }
}