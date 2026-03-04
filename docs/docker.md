# 🐳 Flutter + Docker — Step-by-Step Guide

This guide sets up a Docker environment for:

* 🔥 Development with hot reload
* 📦 Production APK builds
* ⚡ Fast and reproducible workflow

---

# 🚀 First Run

## 1️⃣ Build the image

From the project root:

```bash
docker compose build
```

---

## 2️⃣ Enter the container

```bash
docker compose run flutter bash
```

You are now inside the isolated Flutter environment.

---

## 3️⃣ Install project dependencies

Inside the container:

```bash
flutter pub get
```

---

# 🔥 HOT RELOAD (Development Mode)

> ⚠️ The Android device/emulator must run on the HOST machine, not inside the container.

---

## ✅ Step 1 — On the host (outside Docker)

Connect your device or start an emulator:

```bash
adb devices
```

You should see your device listed.

---

## ✅ Step 2 — Inside the container

Verify that Flutter can see the device:

```bash
flutter devices
```

If it appears → success 🎯

---

## ▶️ Run the app with hot reload

```bash
flutter run
```

Hot reload will now work normally.

---

# 📦 Build APK (Production)

When you want to generate the APK:

---

## 1️⃣ Install full Android SDK (inside the container)

```bash
sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"
yes | sdkmanager --licenses
```

> This only needs to be done the first time.

---

## 2️⃣ Generate release APK

```bash
flutter build apk --release
```

---

## 📍 APK location

The file will be generated at:

```
build/app/outputs/flutter-apk/app-release.apk
```

---

# 🚀 PRO Tip — speed up builds

Create a **.dockerignore** file in the project root:

```
build/
.dart_tool/
.git/
```

This significantly reduces image build time.

---

# 🧠 Quick Troubleshooting

## Device does not appear in the container

On the host:

```bash
adb kill-server
adb start-server
adb devices
```

Then try again inside the container.

---

## Flutter cannot find Android SDK

Inside the container:

```bash
flutter doctor
```

Follow the recommended fixes.

---

# 🏁 Recommended daily workflow

1. `docker compose run flutter bash`
2. `flutter run`
3. Develop normally with hot reload
4. When needed: `flutter build apk --release`

---

**Done. Your Flutter Docker environment is ready.** 🚀
