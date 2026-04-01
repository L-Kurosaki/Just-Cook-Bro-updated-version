# Just Cook Bro (Flutter Edition) v1.0.1

Just Cook Bro is a smart cooking assistant rebuilt with Flutter.

## 🔑 Custom Keys & Multiple AI Models

To optimize token usage and prevent rate limiting, the app now uses different AI models (Pro vs Flash) for different tasks. You must set the following secrets in **Settings > Secrets and variables > Actions** in your GitHub repository:

- `GEMINI_API_KEY_RECIPE` (Used for complex recipe generation - gemini-1.5-pro)
- `GEMINI_API_KEY_VISION` (Used for image analysis - gemini-1.5-flash)
- `GEMINI_API_KEY_LOCATION` (Used for finding nearby shops - gemini-1.5-flash)
- `GEMINI_API_KEY_CHAT` (Used for cooking assistant chat - gemini-1.5-flash)
- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`
- `RC_GOOGLE_KEY` (RevenueCat Google Play API Key)

*(Note: If a specific key is missing, it will fallback to `GEMINI_API_KEY` if available).*

---

## 🚀 Google Play Deployment (AAB)

The app now includes a GitHub Actions workflow (`.github/workflows/google_play_release.yml`) that automatically builds an Android App Bundle (`.aab`) ready for the Google Play Console whenever you push a version tag (e.g., `v1.0.0`).

To use this, add the following Keystore secrets to your GitHub repository:
- `KEYSTORE_BASE64` (Your `upload-keystore.jks` file converted to base64)
- `KEYSTORE_PASSWORD`
- `KEY_PASSWORD`
- `KEY_ALIAS`

Then, create a new release tag:
```bash
git tag v1.0.0
git push origin v1.0.0
```
The `.aab` file will be available in the GitHub Actions artifacts!

---

## 💳 Subscriptions (RevenueCat)

The app has been updated to strictly enforce **recurring subscriptions** (Monthly/Annual). Lifetime subscriptions have been removed from the UI. Ensure your RevenueCat Offerings only contain Monthly or Annual packages.