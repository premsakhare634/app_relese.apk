# Smart Daily Notebook
Offline-first Android personal notebook.

Features:
- Today-first home
- Tasks, notes, reminders
- Local SQLite persistence
- Calendar
- Search
- Priorities
- Local Android notifications
- Basic offline Marathi/English date/time parsing

No Firebase, Supabase, backend, cloud sync or analytics.

Run:
flutter pub get
flutter run

Build APK locally:
flutter pub get
flutter build apk --release

Build APK in Cloud (GitHub Actions):
1. Push this repository to GitHub.
2. Go to the "Actions" tab -> "Build Android APK".
3. Download the generated release APK from the "Artifacts" section.
