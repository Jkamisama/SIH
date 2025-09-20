# Flutter App Setup Guide

## 📋 Prerequisites

### System Requirements
- **Operating System**: macOS, Windows, or Linux
- **RAM**: Minimum 4GB (8GB recommended)
- **Storage**: At least 3GB free space
- **Internet**: Required for downloading dependencies

### Required Software

#### 1. Flutter SDK
- **Version**: 3.10.0 or higher
- **Installation**: 
  - **macOS**: `brew install --cask flutter`
  - **Windows**: Download from [flutter.dev](https://flutter.dev/docs/get-started/install)
  - **Linux**: Follow [Linux installation guide](https://flutter.dev/docs/get-started/install/linux)

#### 2. Dart SDK
- **Version**: 3.0.0 or higher
- **Note**: Included with Flutter SDK

#### 3. Git
- **Version**: Any recent version
- **Installation**: 
  - **macOS**: `brew install git`
  - **Windows**: Download from [git-scm.com](https://git-scm.com/)
  - **Linux**: `sudo apt install git` (Ubuntu/Debian)

### Optional (for specific platforms)

#### For iOS Development (macOS only)
- **Xcode**: Latest version from App Store
- **CocoaPods**: `sudo gem install cocoapods`

#### For Android Development
- **Android Studio**: Download from [developer.android.com](https://developer.android.com/studio)
- **Android SDK**: Installed via Android Studio

#### For Web Development
- **Chrome Browser**: For testing and debugging

## 🚀 Quick Setup

### 1. Install Flutter (macOS)
```bash
# Install Flutter using Homebrew
brew install --cask flutter

# Verify installation
flutter --version
flutter doctor
```

### 2. Clone Repository
```bash
git clone https://github.com/Jkamisama/SIH.git
cd SIH
git checkout harsh-side-code-sample1
```

### 3. Install Dependencies
```bash
flutter pub get
```

### 4. Run the App
```bash
# For web (recommended for testing)
flutter run -d web-server --web-port 3000

# For macOS desktop (requires Xcode)
flutter run -d macos

# For Android (requires Android Studio setup)
flutter run -d android

# For iOS (requires Xcode, macOS only)
flutter run -d ios
```

## 🔧 Detailed Setup Instructions

### Step 1: Verify Flutter Installation
```bash
flutter doctor -v
```

Expected output should show:
- ✅ Flutter (Channel stable, 3.35.4+)
- ✅ Connected device (at least 1 available)

### Step 2: Enable Platform Support
```bash
# Enable web support
flutter config --enable-web

# Enable desktop support (optional)
flutter config --enable-macos-desktop
flutter config --enable-windows-desktop
flutter config --enable-linux-desktop
```

### Step 3: Project Setup
```bash
# Navigate to project directory
cd SIH

# Switch to the Flutter app branch
git checkout harsh-side-code-sample1

# Clean and get dependencies
flutter clean
flutter pub get
```

### Step 4: Run on Different Platforms

#### Web (Easiest - No additional setup required)
```bash
flutter run -d web-server --web-port 3000
# Access at: http://localhost:3000
```

#### macOS Desktop
```bash
# Requires Xcode installation
flutter run -d macos
```

#### Android
```bash
# Requires Android Studio and connected device/emulator
flutter devices  # Check available devices
flutter run -d android
```

## 🐛 Troubleshooting

### Common Issues

#### 1. Flutter not found
```bash
# Add Flutter to PATH (macOS/Linux)
export PATH="$PATH:/opt/homebrew/bin/flutter/bin"

# Or for manual installation
export PATH="$PATH:[PATH_TO_FLUTTER_GIT_DIRECTORY]/flutter/bin"
```

#### 2. Dependencies not resolving
```bash
flutter clean
flutter pub cache repair
flutter pub get
```

#### 3. Web not working
```bash
flutter config --enable-web
flutter create . --platforms=web
flutter run -d web-server
```

#### 4. macOS build issues
```bash
# Install Xcode command line tools
sudo xcode-select --install

# Accept Xcode license
sudo xcodebuild -license accept
```

### Platform-Specific Issues

#### macOS
- **Issue**: "Xcode installation incomplete"
- **Solution**: Install Xcode from App Store and run `sudo xcodebuild -runFirstLaunch`

#### Web
- **Issue**: "Chrome not found"
- **Solution**: Install Chrome browser or set `CHROME_EXECUTABLE` environment variable

#### Android
- **Issue**: "Android SDK not found"
- **Solution**: Install Android Studio and set up Android SDK

## 📱 Testing the App

### 1. Web Testing (Recommended)
```bash
flutter run -d web-server --web-port 3000
```
- Open http://localhost:3000 in browser
- Test login/signup functionality
- Check browser console for API logs

### 2. Hot Reload
- Press `r` in terminal for hot reload
- Press `R` for hot restart
- Press `q` to quit

### 3. Debug Mode
- App runs in debug mode by default
- Check terminal for API request/response logs
- Use browser developer tools for web debugging

## 🔗 API Configuration

The app connects to:
- **Base URL**: `http://10.53.141.191:3001`
- **Admin Login**: `/api/auth/login`
- **User Registration**: `/api/admin/users/register`
- **User Login**: `/api/auth/login`

### Admin Credentials (Built-in)
- **Username**: `SIH`
- **Password**: `1234`

## 📚 Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Web](https://flutter.dev/web)
- [Flutter Desktop](https://flutter.dev/desktop)

## 🆘 Getting Help

If you encounter issues:
1. Check `flutter doctor` output
2. Review terminal logs for error messages
3. Ensure API server is running at `http://10.53.141.191:3001`
4. Verify network connectivity to API server