# Harsh Side App - Flutter UI Part 1

A modern Flutter app with glassmorphism design, featuring authentication screens with smooth animations and dark theme.

## Features

### UI Design
- **Dark theme** with modern glassmorphism effects
- **Background image** stretched to full screen
- **Glassmorphism card** with blur effects and rounded corners
- **Smooth tab transitions** between Login and Signup
- **Responsive design** for all screen sizes

### Authentication
- **Login Tab**: Username and Password with validation
- **Signup Tab**: Complete registration form with multiple fields
- **Form Validation**: Comprehensive validation for all fields
- **Mock API Integration**: Simulated backend calls with local storage

### Validation Rules
- All fields are required
- Password: minimum 8 characters, 1 uppercase, 1 number, 1 special character
- Confirm Password must match
- Aadhaar: 12 digits OR Passport: 6-10 alphanumeric characters
- Mobile: 10 digits starting with 6-9
- Date of Birth: must be ≤ today, minimum age 13
- Departing Date: must be ≥ today

## Project Structure

```
lib/
├── main.dart                 # App entry point with dark theme
├── models/
│   └── user_model.dart      # User data model
├── services/
│   ├── auth_service.dart    # Authentication service with mock API
│   └── local_storage_service.dart # Local data persistence
├── ui/
│   ├── auth_screen.dart     # Main authentication screen
│   └── home_screen.dart     # User dashboard after login
├── utils/
│   └── validators.dart      # Form validation utilities
└── widgets/
    ├── glassmorphism_card.dart   # Reusable glassmorphism container
    ├── custom_text_field.dart   # Custom input field with validation
    └── inline_calendar.dart     # Expandable date picker widget
```

## Setup Instructions

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd harsh-side-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## Dependencies

- `flutter`: SDK
- `cupertino_icons`: iOS-style icons
- `shared_preferences`: Local data storage
- `http`: HTTP client for API calls
- `intl`: Internationalization and date formatting

## Usage

1. **Login**: Use any username and password (mock authentication)
2. **Signup**: Fill all required fields with valid data
3. **Navigation**: Successful authentication redirects to home screen
4. **Logout**: Use logout button on home screen to return to auth

## Mock API Responses

The app uses mock API responses for demonstration:

### Login Response
```json
{
  "success": true,
  "message": "Login successful",
  "user": {
    "id": "12345",
    "username": "entered_username",
    "fullName": "John Doe",
    "email": "username@example.com",
    "token": "mock_jwt_token"
  }
}
```

### Signup Response
```json
{
  "success": true,
  "message": "Registration successful",
  "userId": "user_timestamp",
  "user": { /* complete user data */ }
}
```

## Design Features

- **Glassmorphism Effects**: Blur backdrop with semi-transparent containers
- **Smooth Animations**: Tab transitions and loading states
- **Modern Typography**: Clean, readable text hierarchy
- **Color Scheme**: Purple primary (#6C63FF) with dark background
- **Interactive Elements**: Hover effects and visual feedback

## Next Steps (Future Parts)

- Backend API integration
- Advanced user features
- Data synchronization
- Push notifications
- Enhanced security

## Platform Support

- ✅ iOS
- ✅ Android
- ✅ macOS (tested on MacBook Pro M1)
- ✅ Web
- ✅ Windows
- ✅ Linux

## Development Environment

- **Flutter SDK**: 3.10.0+
- **Dart SDK**: 3.0.0+
- **IDE**: Compatible with VS Code, Android Studio, IntelliJ
- **Tested on**: macOS with Kiro Cloud Sonic 4