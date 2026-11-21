# ⚽ UZPFL
### Uzbekistan Professional League — football league companion app (Demo)

UZPFL is a responsive Flutter application concept for following Uzbekistan's professional football: live scores, fixtures, league tables, player statistics, club news, and detailed match centers, all in one place.

> **⚠️ Demo version.** This project is a UI/UX demo. All matches, standings, players, statistics, and news are **sample data** bundled inside the app. No real-time API or backend is connected yet.

## ✨ Features

- **Home dashboard**: Club stories, latest matches, a top-5 league table preview, and the newest headlines on one screen.
- **Matches**: Browse fixtures by status (**Live / Upcoming / Finished**) and filter by competition.
- **Multiple competitions**: Superliga, Proliga, First League, U21 and U19 Championships, Uzbekistan Cup, Super Cup, and playoff stages.
- **League tables**: Full standings (played, won, drawn, lost, goal difference, points) with color-coded zones for continental qualification, medals, and relegation.
- **Player statistics**: Top scorers, top assist providers, and clean sheets, with a season selector going back 11 seasons.
- **Match center**: A dedicated page for every match with four tabs:
  - **Overview**: Timeline of goals, assists, cards, and substitutions.
  - **Statistics**: Possession, shots, corners, offsides, fouls, passes, and pass accuracy as comparison bars.
  - **Lineups**: Starting XI drawn on a custom-painted pitch (formation, coach, substitutes, and substitution minutes).
  - **Info**: Stadium, city, referees, attendance, and stadium occupancy.
- **Smart empty states**: Upcoming matches show friendly placeholders until events, stats, and lineups are available.
- **News**: News feed and article pages with image carousel, tags, view counts, share-title copy, and related articles.
- **Personalization**: Editable profile, a favorite clubs list (14 clubs), and settings for notifications, language, and help.
- **Floating navigation bar**: A custom animated bottom bar that collapses to icons while scrolling down and expands when scrolling up.

## 🛠️ Tech Stack

| Technology | Purpose |
| --- | --- |
| Flutter | Cross-platform UI framework |
| Dart (SDK ^3.5) | Programming language |
| Material 3 widgets | Core UI components |
| `CustomPainter` | Football pitch rendering in lineups |
| `ValueNotifier` / `ChangeNotifier` | Lightweight state management |
| `google_fonts` | Typography (Inter) |
| `font_awesome_flutter` | Icons |
| `flutter_launcher_icons` | App icon generation |

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (Dart 3.5 or newer)
- Chrome, an Android device/emulator, or an iOS simulator
- Android Studio or Visual Studio Code (recommended)

### Installation

```bash
git clone https://github.com/jaloliddinegamberdiyevvv/uzpfl-app.git
cd uzpfl-app
flutter pub get
flutter run -d chrome
```

To run on another device:

```bash
flutter devices
flutter run -d <device-id>
```

## 🗺️ Roadmap

- [ ] Connect a real data source (REST API) for live scores, standings, and statistics
- [ ] Persist favorite clubs and profile data locally
- [ ] Dark mode
- [ ] Multi-language support (Uzbek, Russian, English)
- [ ] Push notifications for goals and match starts
- [ ] Automated tests

## 📂 Project Structure

```text
lib/
├── main.dart
├── navigation/
│   └── main_navigation.dart      # Floating, collapsing bottom navigation
├── screens/
│   ├── home/                     # Dashboard, top-5 table, top news
│   ├── matches/                  # Fixtures with status and competition filters
│   ├── match_detail/             # Overview, statistics, lineups, info tabs
│   ├── standings/                # League tables with zone legend
│   ├── statistics/               # Scorers, assists, clean sheets
│   ├── news/                     # News list, detail, and sample data
│   └── more/                     # Profile, favorite clubs, settings
└── widgets/                      # Shared widgets (match card, stories, headers)

assets/
└── images/
```

## 📌 Notes

- The app interface is currently in **Uzbek**.
- Club logos use a placeholder image in this demo.
- Platform folders for **Android, iOS, and Web** are included.

## 👨‍💻 Developer

**Jaloliddin Egamberdiyev**

- GitHub: [@jaloliddinegamberdiyevvv](https://github.com/jaloliddinegamberdiyevvv)
- Repository: [uzpfl-app](https://github.com/jaloliddinegamberdiyevvv/uzpfl-app)

---

<p align="center">Built with Flutter for Uzbek football fans. Demo version.</p>
