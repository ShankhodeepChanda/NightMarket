# Night Market

> Your campus, connected.

Night Market is a mobile app for college students that combines a **Marketplace**, **College Community**, and **Student Skills Marketplace** into one unified campus ecosystem.

## What It Does

- **🛒 Marketplace** — Buy and sell textbooks, electronics, furniture, and more within your college.
- **🎓 Community** — Discover clubs, events, and announcements across campus.
- **💼 Skills** — Offer services, find freelancers, post jobs, and build your reputation.

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | Flutter + Dart |
| Backend | Firebase (Auth, Firestore, Storage, FCM) |
| Platform | Android (primary), iOS (future) |

## Getting Started

### Prerequisites

- Flutter SDK 3.13.4+
- Android SDK 36+
- Git

### Setup

```bash
git clone https://github.com/<your-username>/night-market.git
cd night-market
flutter pub get
flutter run
```

### Running Tests

```bash
flutter test
```

### Code Analysis

```bash
flutter analyze
```

## Project Structure

```
lib/
├── app/              # App configuration, theme, routing
│   ├── theme/        # Material 3 light/dark themes
│   └── router/       # Route constants
├── core/             # Shared infrastructure
│   ├── constants/    # App-wide constants
│   └── widgets/      # Reusable widgets
└── features/         # Business features
    ├── home/
    ├── marketplace/
    ├── community/
    ├── skills/
    └── profile/
```


## Documentation

Detailed docs live in the [`docs/`](docs/) directory:

- [Project Overview](docs/PROJECT.md)
- [Architecture](docs/ARCHITECTURE.md)
- [Database Schema](docs/DATABASE.md)
- [Features](docs/FEATURES.md)
- [Design System](docs/DESIGN_SYSTEM.md)
- [Security](docs/SECURITY.md)
- [Development Log](docs/DEVELOPMENT_LOG.md)
- [Decisions (ADRs)](docs/DECISIONS.md)
- [Known Issues](docs/KNOWN_ISSUES.md)
- [Roadmap](docs/ROADMAP.md)

## License

Private — not open source.
