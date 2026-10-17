# YESMIN AI (v0.1.0)

Kotlin + Jetpack Compose Android app: Gemini chat, voice in/out, app launcher, YouTube search,
coding assistant, notes, to-do, reminders, calculator, unit converter, settings.

**Status: source only. NOT compiled or tested.** Expect to fix small compile errors on first build.

## Features by requirement
- Needs internet + Gemini API key: chat, action routing, coding assistant (and speech recognition on many phones)
- Works offline: notes, snippets, to-do, reminders (local alarms), calculator, unit converter, app launcher
- Not implemented: wake word / background listening, weather, web search

## Build in Termux (unverified path)
1. Install Termux from F-Droid. Unzip this project, `cd yesmin-ai`.
2. `bash termux-setup.sh`  (JDK 17, gradle, aapt2, Android SDK platform 34; creates local.properties and gradlew)
3. `bash build.sh`  -> app/build/outputs/apk/debug/app-debug.apk
4. Install: tap the APK (build.sh runs termux-open), or `adb install -r app/build/outputs/apk/debug/app-debug.apk`

Termux caveat: Google's SDK build-tools are x86 binaries; the setup script points Gradle at Termux's own
aapt2 (`android.aapt2FromMavenOverride`). If the build still fails there, build the same project in
Android Studio on a PC (Open project -> Build -> Build APK) and copy the APK to the phone.

## First run
Settings -> paste Gemini API key (https://aistudio.google.com) -> Test Connection -> Save.

## Layout
- ai/: GeminiService (REST), Persona
- actions/: AppAction + ActionRouter (allowlist), ActionExecutor (intents)
- voice/: VoiceManager
- data/: SettingsStore (DataStore + encrypted key), Room DB (v2, destructive migration)
- tools/: reminders, calculator, units, ToolsViewModel
- ui/: screens, ViewModel, theme, orb
Requirements: JDK 17, Gradle 8.7+, Android SDK 34. Reminders are inexact and are lost on reboot.
