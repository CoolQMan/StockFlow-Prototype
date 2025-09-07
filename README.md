# StockFlow AI 📱🤖

**Modern inventory insights with role-based dashboards and an AI-powered Conversational Analytics assistant.** 🚀

StockFlow AI is a cutting-edge Flutter prototype designed to revolutionize inventory management! 🎨✨ It combines stunning dark-themed UI with gradients, role-specific dashboards, and intelligent AI chat powered by Google Gemini. Dive into actionable insights, visualize data with charts, and get real-time answers to your inventory questions—all in a sleek, mobile-first app.

### What makes StockFlow AI special? 🌟
- **Aesthetic Dark Theme**: Gorgeous gradients and polished cards that make data pop! 🎨
- **Role-Based Navigation**: Tailored experiences for Owners, Planners, Associates, Dropshippers, and Retailers. 👥
- **AI-Powered Chat**: Ask natural-language questions about your inventory and get markdown-formatted tables in responses! 🤖📊
- **Comprehensive Insights**: Metrics, aging analysis, alerts, playbooks, and more. 📈
- **Utility Tools**: AR/Camera scan for quick SKU lookups. 📷

If you’re about to push to GitHub, check the `.gitignore` below to keep secrets safe! 🔐

---

## Features 🚀

### 🎭 Role-Based Login & Dashboards
- **Friendly Role Selection**: Choose your role (Owner, Planner, etc.) with eye-catching gradient tiles that match your persona. Each role unlocks customized dashboards for relevant insights.
- **Personalized Screens**: Access metrics, aging inventory breakdowns, actionable playbooks, and alerts tailored to your role—keeping you focused on what matters! 📱

### 🤖 Conversational Analytics (Powered by Gemini)
- **Natural-Language Queries**: Chat with your inventory data! Ask questions like "Show me top products by blocked cash" or "When should I reorder Gaming GPUs?" and get instant, actionable answers. 💬
- **Smart Responses**: AI responses include markdown tables for easy reading, grounded in your inventory snapshot. No more sifting through raw data—get insights that feel like they're from a live database! 📊
- **Example Queries**:
  - "What's the sell-through rate for SSDs?" → Gets you rates, recommendations, and next steps.
  - "Which products are aging over 90 days?" → Tables with SKUs, days in stock, and clearance suggestions.
- **Auto-Scroll & Markdown Rendering**: Chat scrolls smoothly to new messages, and tables render beautifully inside bubbles. Perfect for on-the-go analysis! 🔄

### 🎨 Theming & UX Polish
- **Centralized Dark Theme**: Consistent gradients, colors, and shadows across the app for a premium feel. Switch seamlessly between light and dark modes if needed.
- **Polished Cards**: Every metric, alert, and playbook card uses gradients and shadows to highlight key data—making dashboards visually stunning and easy to scan. ✨

### 📷 AR/Scanner Utility
- **Camera Integration**: Scan SKUs with your camera for instant lookups. (Placeholder ready for full AR implementation—perfect for warehouse workflows!) 🔍
- **Quick Access**: Tap to scan, get product details, and integrate with your inventory data.

---

## Tech Stack 🛠️

- **Flutter (Material 3)**: Cross-platform magic for iOS, Android, and more. 📱
- **Dart**: SDK ^3.9.0 for robust, fast development.
- **State Management**: Provider for clean, scalable app state.
- **AI Integration**: `google_generative_ai` (Gemini 1.5) for conversational smarts. 🤖
- **Markdown Rendering**: `flutter_markdown` to display tables and formatted responses in chat.
- **Charts & UX**: `fl_chart` for data visualizations, `lottie` for animations, `camera` for scanning, `intl` for localization.

---

## Project Structure (High Level) 📂

```
lib/
  main.dart                      # 🚀 App entry point
  theme/app_theme.dart           # 🎨 Dark theme & gradient definitions
  models/sample_inventory_database.dart  # 📊 Sample data for AI seeding
  services/gemini_analytics_service.dart # 🤖 Gemini setup & chat logic
  screens/
    login_screen.dart            # 🔑 Role selection
    dashboard_screen.dart        # 📱 Role-based navigation
    conversational_analytics_screen.dart # 💬 AI chat with markdown
    alerts_screen.dart           # 🚨 Inventory alerts
    actionable_playbooks_screen.dart # 📋 Step-by-step guides
    aging_inventory_screen.dart  # ⏳ Aging breakdowns
    ar_scanner_screen.dart       # 📷 Camera scan utility
  widgets/role_card.dart         # 🃏 Gradient role tiles
android/                         # 🤖 Android configs (manifest, ProGuard)
ios/, macos/, linux/, windows/, web/ # 🌐 Platform-specific folders
assets/                          # 🎭 Lottie animations & media
```

**Key Files Spotlight**:
- `lib/services/gemini_analytics_service.dart`: Where the AI magic happens—set up your API key here! 🔑
- `lib/models/sample_inventory_database.dart`: Sample inventory data that seeds the AI for demo responses.
- `lib/screens/conversational_analytics_screen.dart`: The chat interface with auto-scroll and markdown tables.
- `lib/theme/app_theme.dart`: Your go-to for consistent styling and gradients.

---

## Prerequisites 📋

- **Flutter SDK**: Install the stable version supporting Dart >= 3.9.0. (Check with `flutter doctor`!) 🛠️
- **IDE**: Android Studio or VS Code for development.
- **Device/Emulator**: Android/iOS simulator or physical device.
- **Google Gemini API Key**: Free from Google AI Studio—essential for AI features! 🤖

---

## Configure Your Gemini API Key (Required!) 🔑

**Don't skip this—your AI chat won't work without it!** 🚨

1. Get your free API key from [Google AI Studio](https://makersuite.google.com/app/apikey). 📝
2. Open `lib/services/gemini_analytics_service.dart`.
3. Replace the placeholder:

   ```dart
   static const String _apiKey = 'YOUR_GEMINI_API_KEY';  // 👈 Paste your real key here!
   ```

**Security Tip**: Never commit keys to Git! Our `.gitignore` ignores `.env` files. For production, use `flutter_dotenv` or secure platform storage. 🔐

---

## Getting Started 🚀

1. **Install Dependencies**:
   ```powershell
   flutter pub get
   ```

2. **Run in Debug Mode** (Emulator/Device):
   ```powershell
   flutter run
   ```
   - Select a role, explore dashboards, and chat with the AI! 💬

3. **Build Release APK** (Android):
   ```powershell
   flutter build apk --release
   ```
   - Find your APK at `build/app/outputs/flutter-apk/app-release.apk`. Ready to install! 📦

---

## Release Build Notes (Android) 📱

We've got you covered for smooth releases! This project includes:
- **Permissions**: `INTERNET` and `ACCESS_NETWORK_STATE` in `AndroidManifest.xml` for AI calls. 🌐
- **Network Security**: Config to allow Gemini endpoints in release builds (no more debug-only issues!).
- **ProGuard Rules**: Keeps AI and HTTP classes intact during minification in `android/app/proguard-rules.pro`.

**Troubleshooting**:
- If AI works in debug but fails on device, run `adb logcat` to check logs. 📋
- Use `GeminiAnalyticsService.testConnection()` in the app to verify API connectivity. 🔍

---

## How Conversational Analytics Works 🤖

- **AI Seeding**: We feed Gemini a formatted snapshot of your inventory (from `SampleInventoryDatabase`) as context. This makes responses feel like they're pulling from a real database! 📊
- **Smart Constraints**: The system instruction ensures answers stay on-topic (inventory only) and are concise, actionable, with markdown tables for data.
- **Chat Magic**: Your queries trigger AI responses rendered as markdown in the chat bubbles—tables, lists, and insights all in one! 💬✨

**Future Ideas**:
- Connect to live inventory APIs for real-time data. 🔄
- Secure key management with environment variables. 🔐

---

**Ready to transform your inventory management?** Download, set your API key, and start chatting with your data! 🚀📊