# PriceRadar 📡 — Flutter App

Live price comparison across Amazon, Flipkart, Meesho, Snapdeal & Myntra.
Built with Flutter/Dart — compiles directly to APK with a single command.

---

## 🚀 Build APK in 4 Steps

```bash
# 1. Install Flutter SDK (if not installed)
# https://docs.flutter.dev/get-started/install/windows/mobile

# 2. Enter project folder
cd price_radar

# 3. Get dependencies
flutter pub get

# 4. Build APK
flutter build apk --release
```

✅ Your APK will be at:
`build/app/outputs/flutter-apk/app-release.apk`

---

## ☁️ Build on Codemagic (No Setup Needed)

1. Push this folder to GitHub
2. Go to https://codemagic.io
3. Connect your repo → select Flutter → click **Start Build**
4. Download APK from the build output

Free tier available — no credit card needed.

---

## Features

| Feature | Description |
|---|---|
| 🔍 Search & Filter | By name, brand, category |
| 💰 User Margin | Fixed ₹ or % slider with presets |
| 📊 Platform Compare | Price + Rating + Delivery + Score |
| 🏷️ Smart Tags | Best / In Range / Worth It / Low Rating |
| 📈 Price History | Line chart with all-time low/high |
| ♥ Watchlist | Save products across sessions |
| 🔄 Live Refresh | Pull-to-refresh with price simulation |

---

## App Structure

```
lib/
├── main.dart                    ← Entry + Bottom Nav
├── utils/theme.dart             ← Colors, typography
├── models/product.dart          ← Data models
├── services/
│   ├── mock_data.dart           ← 6 products, 5 platforms
│   └── app_state.dart           ← Provider state manager
├── widgets/
│   ├── common_widgets.dart      ← PlatformBadge, DealTag, ScoreRing...
│   └── product_card.dart        ← Product list card
└── screens/
    ├── home_screen.dart         ← Search, filter, product list
    ├── product_detail_screen.dart ← Compare / History / Details tabs
    ├── watchlist_screen.dart    ← Saved products
    └── settings_screen.dart     ← Margin controls + preferences
```

---

## Connect Real APIs

Replace `lib/services/mock_data.dart` with real API calls:

```dart
// Amazon PAAPI 5.0
import 'package:http/http.dart' as http;

Future<List<Product>> searchAmazon(String keyword) async {
  final response = await http.post(
    Uri.parse('https://webservices.amazon.in/paapi5/searchitems'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'Keywords': keyword,
      'Resources': ['ItemInfo.Title', 'Offers.Listings.Price'],
      'PartnerTag': 'YOUR_TAG',
      'PartnerType': 'Associates',
    }),
  );
  // Parse and return List<Product>
}
```

---

## Deal Score Formula

```
Score = Rating/5 × 40% + (In margin? 40% : 10%) + Delivery × 20%
```

Score ≥ 80 → Green ring (Excellent)
Score 60–79 → Amber ring (Good)
Score < 60 → Red ring (Risky)
