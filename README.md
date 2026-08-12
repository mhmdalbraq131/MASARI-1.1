# MASARI (مساري) - Luxury Travel, Tourism, Hajj & Umrah Platform

MASARI is an official **Flutter & Dart** application engineered for high-end Travel, Tourism, Hajj & Umrah services across mobile, desktop, and web platforms.

---

## 📱 Verified Development Environment & Technology Stack
- **Framework**: Flutter 3.38.7 & Dart 3.10.7
- **SDK Constraint**: `>=3.10.0 <4.0.0` (in `pubspec.yaml`)
- **Android SDK**: 35.0.0
- **Primary Entry Point**: `lib/main.dart`
- **Source Directory**: `lib/`
- **Target Platforms**: Android, iOS, Windows, Web
- **State Management**: Flutter Riverpod (`flutter_riverpod: ^2.6.1`)
- **Routing & Navigation**: GoRouter (`go_router: ^14.8.1`)
- **Architecture**: Clean Architecture + Feature-First Domain-Driven Design
- **Design System**: MASARI Royal Theme (Deep Blue `#050914`, Royal Gold `#D4AF37`, Sky Cyan `#00D4FF`, Coral Orange `#FF7F50`)
- **Localization**: Native Arabic (RTL) first-class support with English (LTR) language switching

---

## ⚙️ SDK Compatibility Decision
An inspection of the codebase confirmed that all Flutter/Dart APIs and feature structures in `lib/` rely on standard Dart 3 features (Records, Pattern Matching, Sealed Classes, Null Safety) available since Dart 3.0.0. No language features or APIs require Dart >= 3.12.2. The SDK constraint in `pubspec.yaml` was set to `>=3.10.0 <4.0.0` to ensure full compatibility with local Dart 3.10.7 / Flutter 3.38.7 toolchains without requiring an SDK upgrade.

---

## 📐 Project Structure (`lib/`)

```
lib/
├── app/
│   ├── app.dart              # MasariApp Root MaterialApp.router setup
│   └── app_router.dart       # Central GoRouter setup (18 distinct routes)
├── core/
│   ├── config/               # Environment & Firebase configuration
│   ├── constants/            # Constants, colors, and asset paths
│   ├── errors/               # Failures & Exception handling
│   ├── network/              # API Client & Network inspection
│   ├── security/             # ProtectedRouteGuard & Audit logging
│   ├── theme/                # MasariTheme, MasariColors, Typography & Spacing
│   └── utils/                # Responsive layout & RTL helpers
├── features/
│   └── foundation/           # Core Foundation Feature (Domain, Data, Presentation)
│       ├── data/             # Repositories implementation
│       ├── domain/           # UserSession entities & Repository contracts
│       └── presentation/     # Riverpod providers, Splash, Home, Services views
└── shared/
    ├── components/           # Reusable UI widgets (Cards, Buttons, Dialogs, Chips)
    └── widgets/              # MasariAppShell, TopBar, Sidebar, BottomNav
```

---

## ℹ️ Platform Environment Notice

- **Official Application**: MASARI is strictly built in **Flutter/Dart** located inside `lib/`.
- **Environment Execution**: The AI Studio sandbox container environment executes a Node.js 22 runtime serving port 3000 via Vite.
- **Role of `/src`**: Any code under `/src` serves solely as a web preview wrapper for the browser iframe environment. It is **NOT** the official MASARI application codebase.
- **Official Code Base**: All business logic, routing, views, theme tokens, and data layers reside in `lib/`.

---

## 📊 Foundation & Verification Status

1. **Flutter Source Code Integrity**: COMPLETE (`lib/main.dart` entry point, `MasariApp`, Riverpod providers, GoRouter setup, Clean Architecture structure).
2. **SDK Compatibility & Design Tokens**: VERIFIED for Flutter 3.38.7 / Dart 3.10.7 with `sdk: '>=3.10.0 <4.0.0'` in `pubspec.yaml`. Added missing `card` BoxShadow token to `MasariShadows` design tokens used by `MasariCard` in `masari_cards.dart`. Aligned `MasariSidebar` constructor API (`isCollapsed` parameter) with `MasariAppShell` call-sites for type-safe multi-platform compilation. Regenerated `windows/runner/resources/app_icon.ico` into a clean 32-bit BGRA ICO container (16x16, 32x32, 48x48, 256x256 frames) preserving MASARI branding and resolving Windows Resource Compiler `RC2176` old DIB format errors.
3. **Design System & RTL Support**: COMPLETE (`MasariTheme` dark/light modes, Cairo Arabic font, RTL layout directionality).
4. **Route System**: COMPLETE (18 distinct shell routes configured under `AppRouter`).

