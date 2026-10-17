#!/data/data/com.termux/files/usr/bin/bash
set -e
cd "$(dirname "$0")"
export JAVA_HOME="${JAVA_HOME:-$PREFIX/lib/jvm/java-17-openjdk}"
if [ -x ./gradlew ]; then ./gradlew assembleDebug --no-daemon; else gradle assembleDebug --no-daemon; fi
APK=app/build/outputs/apk/debug/app-debug.apk
echo "APK: $APK"
cp "$APK" ~/storage/downloads/yesmin-ai.apk 2>/dev/null && echo "Copied to Downloads/yesmin-ai.apk" || echo "(run termux-setup-storage once to copy APK to Downloads)"
command -v termux-open >/dev/null && termux-open "$APK" || true
