# flutter_device_features

A Flutter app that demonstrates native device features, one phase at a time: device information, gallery access, Google Maps, biometric authentication, and audio recording.

## Features

- **Device Information** – shows the device model and OS version.
- **Multiple Image Picker** – pick several images from the gallery and list them.
- **Google Maps + Cairo Marker** – full-screen map with a red marker on Cairo Governorate, Egypt.
- **Biometric Authentication** – the profile screen opens only after a successful fingerprint check.
- **Audio Recording & Playback** – record your voice and play it back.

## Packages

| Package | Purpose |
| --- | --- |
| `device_info_plus` | Device model and OS version |
| `image_picker` | Multi-image gallery selection |
| `google_maps_flutter` | Map and marker |
| `local_auth` | Fingerprint authentication |
| `record` | Audio recording |
| `audioplayers` | Audio playback |
| `path_provider` | Temporary folder for recordings |

## Permissions

### Android (`android/app/src/main/AndroidManifest.xml`)

| Permission / setting | Why |
| --- | --- |
| `INTERNET` | Download Google Maps tiles (also needed in release builds) |
| `RECORD_AUDIO` | Record voice |
| `USE_BIOMETRIC` | Fingerprint authentication |
| `MainActivity` extends `FlutterFragmentActivity` | Required by `local_auth` |
| `Theme.AppCompat` based `LaunchTheme` / `NormalTheme` | Required by `local_auth` on Android 8 and below |

No permission is needed for the device info page or for picking images (the system photo picker is used).

### iOS (`ios/Runner/Info.plist`)

| Key | Why |
| --- | --- |
| `NSPhotoLibraryUsageDescription` | Read the photos selected in the gallery |
| `NSMicrophoneUsageDescription` | Record voice |
| `NSFaceIDUsageDescription` | Biometric authentication |
| `MAPS_API_KEY` | Holds the Google Maps key read by `AppDelegate.swift` |

## Google Maps API Setup

1. Create an API key in the Google Cloud Console and enable **Maps SDK for Android** and **Maps SDK for iOS**.
2. **Android:** copy `android/secrets.properties.example` to `android/secrets.properties` and set `MAPS_API_KEY`. The key is injected into the manifest by `android/app/build.gradle.kts`.
3. **iOS:** copy `ios/Flutter/Secrets.xcconfig.example` to `ios/Flutter/Secrets.xcconfig` and set `MAPS_API_KEY`. The key is passed through `Info.plist` to `AppDelegate.swift`.

Both secret files are listed in `.gitignore`. Never commit a real key.

## Running the Project

```bash
flutter pub get
flutter run
```

Biometrics and audio recording work best on a real device with an enrolled fingerprint.
