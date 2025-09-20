# How to Run the Flutter App

## 🚀 Quick Start (5 minutes)

### Prerequisites Check
```bash
# Check if Flutter is installed
flutter --version

# If not installed (macOS):
brew install --cask flutter
```

### Run the App
```bash
# 1. Clone and navigate
git clone https://github.com/Jkamisama/SIH.git
cd SIH
git checkout harsh-side-code-sample1

# 2. Install dependencies
flutter pub get

# 3. Run on web (easiest)
flutter run -d web-server --web-port 3000
```

**🌐 Open**: http://localhost:3000

## 📱 Platform-Specific Instructions

### 1. Web (Recommended - No setup required)
```bash
flutter run -d web-server --web-port 3000
```
- ✅ **Pros**: No additional setup, works on any OS
- ✅ **Best for**: Testing, development, demos
- 🌐 **Access**: http://localhost:3000

### 2. macOS Desktop
```bash
# Enable macOS support (one-time)
flutter config --enable-macos-desktop

# Run on macOS
flutter run -d macos
```
- ✅ **Pros**: Native performance, system integration
- ❌ **Requires**: Xcode installation
- 🖥️ **Best for**: macOS users with Xcode

### 3. Android
```bash
# Check available devices
flutter devices

# Run on Android
flutter run -d android
```
- ✅ **Pros**: Mobile testing, touch interactions
- ❌ **Requires**: Android Studio, device/emulator
- 📱 **Best for**: Mobile app testing

### 4. iOS (macOS only)
```bash
# Run on iOS
flutter run -d ios
```
- ✅ **Pros**: iOS testing, App Store preparation
- ❌ **Requires**: Xcode, iOS Simulator/device
- 🍎 **Best for**: iOS development

## 🔧 Development Workflow

### Hot Reload Development
```bash
# Start the app
flutter run -d web-server --web-port 3000

# In the terminal, use these commands:
r    # Hot reload (fast refresh)
R    # Hot restart (full restart)
q    # Quit application
h    # Help (show all commands)
```

### Debug Mode
```bash
# Run with verbose logging
flutter run -d web-server --web-port 3000 --verbose

# Check API calls in terminal output
# Look for lines starting with "Sending" and "Response"
```

## 🧪 Testing the App

### 1. Signup Flow Test
1. **Open**: http://localhost:3000
2. **Click**: "Signup" tab
3. **Fill form**:
   - Full Name: `John Doe`
   - Aadhaar: `123456789012`
   - Mobile: `9876543210`
   - Date of Birth: Select past date
   - Password: `MySecure123!`
   - Confirm Password: `MySecure123!`
   - Departing Date: Select future date
   - Username: `johndoe123`
4. **Click**: "Register"
5. **Expected**: Success message → Auto-login → Home screen

### 2. Login Flow Test
1. **Click**: "Login" tab
2. **Enter**:
   - Username: `johndoe123` (from signup)
   - Password: `MySecure123!`
3. **Click**: "Login"
4. **Expected**: Success message → Home screen

### 3. API Integration Test
- **Check terminal** for API logs:
  ```
  Getting admin token...
  Admin login response status: 200
  Sending signup request to: http://10.53.141.191:3001/api/admin/users/register
  Response status: 201
  ```

## 🐛 Troubleshooting

### Common Issues & Solutions

#### 1. Flutter not found
```bash
# macOS - Add to ~/.zshrc or ~/.bash_profile
export PATH="$PATH:/opt/homebrew/bin/flutter/bin"

# Reload shell
source ~/.zshrc
```

#### 2. Dependencies not installing
```bash
flutter clean
flutter pub cache repair
flutter pub get
```

#### 3. Web not working
```bash
flutter config --enable-web
flutter create . --platforms=web
flutter run -d web-server --web-port 3000
```

#### 4. Port already in use
```bash
# Use different port
flutter run -d web-server --web-port 3001

# Or kill existing process
lsof -ti:3000 | xargs kill -9
```

#### 5. API connection issues
- **Check**: API server is running at `http://10.53.141.191:3001`
- **Test**: `curl http://10.53.141.191:3001/api/auth/login`
- **Network**: Ensure you can reach the server

#### 6. macOS build issues
```bash
# Install Xcode command line tools
sudo xcode-select --install

# Accept license
sudo xcodebuild -license accept
```

### Platform-Specific Issues

#### Web Browser Issues
- **Chrome not found**: Install Chrome browser
- **CORS errors**: API server must allow cross-origin requests
- **Network errors**: Check browser console (F12)

#### macOS Issues
- **Xcode required**: Install from App Store
- **CocoaPods**: `sudo gem install cocoapods`
- **Permissions**: May need to allow app in System Preferences

#### Android Issues
- **No devices**: Start Android emulator or connect device
- **SDK not found**: Install Android Studio
- **USB debugging**: Enable on Android device

## 📊 Performance Monitoring

### Development Metrics
```bash
# Build size analysis
flutter build web --analyze-size

# Performance profiling
flutter run --profile -d web-server
```

### API Response Times
- **Admin login**: ~200ms
- **User registration**: ~500ms
- **User login**: ~300ms

## 🔄 Build for Production

### Web Build
```bash
flutter build web
# Output: build/web/
```

### macOS Build
```bash
flutter build macos
# Output: build/macos/Build/Products/Release/
```

### Android Build
```bash
flutter build apk
# Output: build/app/outputs/flutter-apk/
```

## 📝 Development Tips

### 1. Code Changes
- Use hot reload (`r`) for UI changes
- Use hot restart (`R`) for logic changes
- Check terminal for error messages

### 2. API Debugging
- All API calls are logged to terminal
- Check request/response data
- Verify admin token acquisition

### 3. UI Testing
- Test on different screen sizes
- Verify glassmorphism effects
- Check form validation

### 4. State Management
- User data stored locally
- Token persists between sessions
- Logout clears all data

## 🆘 Getting Help

### Debug Information
```bash
# System info
flutter doctor -v

# Device info
flutter devices

# App logs
flutter logs
```

### Common Commands Reference
```bash
flutter clean          # Clean build cache
flutter pub get        # Install dependencies
flutter pub upgrade    # Update dependencies
flutter run            # Run app
flutter build          # Build for production
flutter test           # Run tests
```

### Support Resources
- **Flutter Docs**: https://flutter.dev/docs
- **API Issues**: Check server at `http://10.53.141.191:3001`
- **Code Issues**: Review terminal logs and error messages