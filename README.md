# DailyUp App
[![CI](https://github.com/yourorg/dailyup-app/actions/workflows/flutter.yml/badge.svg)](https://github.com/yourorg/dailyup-app/actions/workflows/flutter.yml)

A skeleton mobile app demonstrating consuming paginated topics from a backend.

## Getting Started

Ensure you have Flutter installed. Then run:

```bash
flutter pub get
flutter run
```

Create a `.env` file:

```
API_URL=https://example.com
FCM_KEY=<firebase-key>
```

### Testing

```
flutter test
```

### CI

GitHub Actions runs tests and builds on pull requests.

## Features

- Soft pastel colors based on Material 3
- Google Fonts **Fredoka** for all text
- Add new habits from the floating action button
- Swipe a habit card to delete it
- Supports English and Japanese languages
- State is kept only in memory (no persistence yet)

