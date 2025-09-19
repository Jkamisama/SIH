import 'dart:convert';
import 'package:http/http.dart' as http;
import 'local_storage_service.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _baseUrl = 'https://api.example.com'; // Replace with actual API URL
  final LocalStorageService _localStorage = LocalStorageService();

  // Mock login API call
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock successful response
      final mockResponse = {
        'success': true,
        'message': 'Login successful',
        'user': {
          'id': '12345',
          'username': username,
          'fullName': 'John Doe',
          'email': '$username@example.com',
          'mobileNumber': '9876543210',
          'token': 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
        }
      };

      if (mockResponse['success'] == true) {
        // Save user data locally
        final user = User.fromJson(mockResponse['user'] as Map<String, dynamic>);
        await _localStorage.saveUser(user);
        await _localStorage.saveToken(user.token);
      }

      return mockResponse;
    } catch (e) {
      return {
        'success': false,
        'message': 'Login failed: ${e.toString()}',
      };
    }
  }

  // Mock signup API call
  Future<Map<String, dynamic>> signup(Map<String, dynamic> userData) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 3));
      
      // Mock successful response
      final mockResponse = {
        'success': true,
        'message': 'Registration successful',
        'userId': 'user_${DateTime.now().millisecondsSinceEpoch}',
        'user': {
          'id': 'user_${DateTime.now().millisecondsSinceEpoch}',
          'username': userData['username'],
          'fullName': userData['fullName'],
          'email': '${userData['username']}@example.com',
          'mobileNumber': userData['mobileNumber'],
          'aadhaarPassport': userData['aadhaarPassport'],
          'dateOfBirth': userData['dateOfBirth'],
          'departingDate': userData['departingDate'],
          'token': 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
        }
      };

      if (mockResponse['success'] == true) {
        // Save user data locally
        final user = User.fromJson(mockResponse['user'] as Map<String, dynamic>);
        await _localStorage.saveUser(user);
        await _localStorage.saveToken(user.token);
      }

      return mockResponse;
    } catch (e) {
      return {
        'success': false,
        'message': 'Registration failed: ${e.toString()}',
      };
    }
  }

  // Real API implementation (commented out for now)
  /*
  Future<Map<String, dynamic>> _makeApiCall(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
      };
    }
  }
  */

  // Get current user
  Future<User?> getCurrentUser() async {
    return await _localStorage.getUser();
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await _localStorage.getToken();
    return token != null && token.isNotEmpty;
  }

  // Logout
  Future<void> logout() async {
    await _localStorage.clearUser();
    await _localStorage.clearToken();
  }
}