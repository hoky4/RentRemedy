# Mobile app


Set up Flutter https://flutter.dev/docs/get-started/install
1. Download flutter SDK
2. Update path
3. Run "flutter doctor" in terminal
4. Download IDE
  4a. Download flutter plugin in IDE
  4b. Configure dart and flutter path in IDE
  4c. Set up android emulator in IDE


Note: One package doesn't have support for null safety, so a configuration must be done which can be done in two ways before running the app:
Option 1. In the project repo, run `flutter run --no-sound-null-safety`
Option 2a. In Visual Studio Code: search for "Flutter run additional args" in your user settings.
        2b. Add --no-sound-null-safety.
