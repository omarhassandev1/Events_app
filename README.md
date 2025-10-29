# 🗓️ Evently Application

Evently is a modern Flutter application for managing and exploring public events.  
Users can **browse**, **add**, **edit**, **remove**, and **favorite** events — all with real-time synchronization through **Firebase**.  
The app also includes **Google Maps integration**, **multi-language support (English & Arabic)**, and **dark/light themes**.

---

## 🚀 Features

### 🧭 General
- View a list of public events with details (title, description, location, date, etc.)
- Add new events with form validation
- Edit or delete existing events
- Add or remove events from favorites
- Responsive and clean UI design (Material 3)

### 📍 Location & Maps
- Google Maps integration to display event locations
- Tap markers to view event info
- Select events from a horizontal scroll list to focus on their map location
- Floating button to jump to user’s current location

### 🔐 Authentication
- Firebase Authentication (Email & Password)
- Persistent user sessions
- Secure login/logout flow

### 💾 Database
- Firebase Firestore for real-time event storage
- Cloud-based data sync across devices

### 🌙 Themes
- Light and Dark mode support
- Automatically adapts to system theme

### 🌐 Localization
- Full support for **English 🇬🇧** and **Arabic 🇪🇬**
- Dynamic language switching

---

## 🧩 Tech Stack

| Category | Technology |
|-----------|-------------|
| Framework | [Flutter](https://flutter.dev/) |
| State Management | Provider |
| Backend | Firebase (Auth, Firestore) |
| Maps | Google Maps Flutter |
| Location Services | [location](https://pub.dev/packages/location) |
| UI Design | [https://www.figma.com/design/YmDiRILnGg2sAoVcll7ZEb/Event-Planning-App?node-id=139-1933&p=f&t=RoRZ0BzgKQGLeP3l-0] |
| Localization | Flutter Localization |

---

## 🗂️ Folder Structure

```

lib/
├── common/
│   ├── theme/
│   └── widgets/
├── models/
│   └── event_model.dart
├── network/
│   └── auth_service.dart
├── provider/
│   └── events_provider.dart
├── screens/
│   ├── auth/
│   ├── home/
│   │   └── location_tab/
│   │       └── widgets/
│   └── ...
└── main.dart

````

---

## ⚙️ Setup & Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/evently_application.git
   cd evently_application
````

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Setup Firebase**

    * Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
    * Add Android and iOS apps
    * Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
    * Place them under:

      ```
      android/app/google-services.json
      ios/Runner/GoogleService-Info.plist
      ```

4. **Add required permissions** in `android/app/src/main/AndroidManifest.xml`

   ```xml
   <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
   <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
   ```

5. **Run the app**

   ```bash
   flutter run
   ```

---

## 📸 Screenshots (Optional)

---
