class Validators {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Username validation
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    if (value.length > 20) {
      return 'Username must be less than 20 characters';
    }
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!usernameRegex.hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }
    return null;
  }

  // Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    
    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    
    // Check for at least one number
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    
    // Check for at least one special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    
    return null;
  }

  // Confirm password validation
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Full name validation
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.length < 2) {
      return 'Full name must be at least 2 characters';
    }
    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Full name can only contain letters and spaces';
    }
    return null;
  }

  // Aadhaar/Passport validation
  static String? validateAadhaarPassport(String? value) {
    if (value == null || value.isEmpty) {
      return 'Aadhaar/Passport number is required';
    }
    
    // Check if it's Aadhaar (12 digits)
    if (RegExp(r'^\d{12}$').hasMatch(value)) {
      return null; // Valid Aadhaar
    }
    
    // Check if it's Passport (alphanumeric, 6-10 characters)
    if (RegExp(r'^[A-Z0-9]{6,10}$').hasMatch(value.toUpperCase())) {
      return null; // Valid Passport
    }
    
    return 'Enter valid Aadhaar (12 digits) or Passport number';
  }

  // Mobile number validation
  static String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }
    final mobileRegex = RegExp(r'^[6-9]\d{9}$');
    if (!mobileRegex.hasMatch(value)) {
      return 'Enter a valid 10-digit mobile number';
    }
    return null;
  }

  // Date of birth validation
  static String? validateDateOfBirth(DateTime? value) {
    if (value == null) {
      return 'Date of birth is required';
    }
    final today = DateTime.now();
    if (value.isAfter(today)) {
      return 'Date of birth cannot be in the future';
    }
    final age = today.difference(value).inDays / 365;
    if (age < 13) {
      return 'You must be at least 13 years old';
    }
    return null;
  }

  // Departing date validation
  static String? validateDepartingDate(DateTime? value) {
    if (value == null) {
      return 'Departing date is required';
    }
    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);
    final valueOnly = DateTime(value.year, value.month, value.day);
    
    if (valueOnly.isBefore(todayOnly)) {
      return 'Departing date cannot be in the past';
    }
    return null;
  }

  // Required field validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }
}