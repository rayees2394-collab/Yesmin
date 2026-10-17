#!/data/data/com.termux/files/usr/bin/bash
# One-time Termux setup for building YESMIN AI. UNVERIFIED on real devices: if a step fails,
# use Android Studio on a PC instead (see README).
set -e
pkg update -y
pkg install -y openjdk-17 gradle aapt2 unzip wget zip

SDK="$HOME/android-sdk"
mkdir -p "$SDK/cmdline-tools"
if [ ! -d "$SDK/cmdline-tools/latest" ]; then
  wget -O /tmp/cmdline-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
  unzip -q /tmp/cmdline-tools.zip -d "$SDK/cmdline-tools"
  mv "$SDK/cmdline-tools/cmdline-tools" "$SDK/cmdline-tools/latest"
fi
export JAVA_HOME="$PREFIX/lib/jvm/java-17-openjdk"
yes | "$SDK/cmdline-tools/latest/bin/sdkmanager" --sdk_root="$SDK" --licenses >/dev/null || true
"$SDK/cmdline-tools/latest/bin/sdkmanager" --sdk_root="$SDK" "platforms;android-34" "build-tools;34.0.0"

cd "$(dirname "$0")"
echo "sdk.dir=$SDK" > local.properties
# SDK build-tools binaries are x86; use Termux's own aapt2 instead.
grep -q aapt2FromMavenOverride gradle.properties || echo "android.aapt2FromMavenOverride=$PREFIX/bin/aapt2" >> gradle.properties
# Create Gradle wrapper (needs internet once)
[ -f gradlew ] || gradle wrapper --gradle-version 8.7
echo "Setup done. Now run: ./build.sh"
