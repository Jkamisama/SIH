import 'dart:convert';
import 'package:http/http.dart' as http;
import 'local_storage_service.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _baseUrl = 'http://10.53.141.191:3001'; // Your API URL
  final LocalStorageService _localStorage = LocalStorageService();
  
  // Admin credentials for user registration
  static const String _adminUsername = 'SIH';
  static const String _adminPassword = '1234';
  String? _adminToken;

  // Real user login API call
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final requestData = {
        'username': username,
        'password': password,
      };

      print('Sending user login request to: $_baseUrl/api/auth/login');
      print('Request data: ${jsonEncode(requestData)}');
      
      final response = await http.post(
        Uri.parse('$_baseUrl/api/auth/login'), // User login endpoint
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );
      
      print('User login response status: ${response.statusCode}');
      print('User login response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        
        // Create user object from response
        final user = User(
          id: responseData['user']['id'] ?? responseData['userId'] ?? responseData['user']['_id'] ?? '',
          username: responseData['user']['username'] ?? username,
          fullName: responseData['user']['fullName'] ?? '',
          email: responseData['user']['email'] ?? '$username@example.com',
          mobileNumber: responseData['user']['mobile']?.replaceAll('+91', '') ?? '',
          aadhaarPassport: responseData['user']['aadhaarPassport'],
          dateOfBirth: responseData['user']['dob'],
          departingDate: responseData['user']['departingDate'],
          token: responseData['token'] ?? responseData['accessToken'] ?? '',
        );

        // Save user data locally
        await _localStorage.saveUser(user);
        await _localStorage.saveToken(user.token);

        return {
          'success': true,
          'message': 'Login successful',
          'user': user.toJson(),
        };
      } else {
        final responseData = jsonDecode(response.body);
        return {
          'success': false,
          'message': responseData['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      print('User login error: $e');
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
      };
    }
  }

  // Get admin token for user registration
  Future<String?> _getAdminToken() async {
    try {
      if (_adminToken != null) {
        return _adminToken; // Return cached token
      }

      print('Getting admin token...');
      final response = await http.post(
        Uri.parse('$_baseUrl/api/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': _adminUsername,
          'password': _adminPassword,
        }),
      );

      print('Admin login response status: ${response.statusCode}');
      print('Admin login response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _adminToken = responseData['token'] ?? responseData['accessToken'];
        print('Admin token obtained: ${_adminToken?.substring(0, 20)}...');
        return _adminToken;
      } else {
        print('Failed to get admin token');
        return null;
      }
    } catch (e) {
      print('Error getting admin token: $e');
      return null;
    }
  }

  // Real signup API call
  Future<Map<String, dynamic>> signup(Map<String, dynamic> userData) async {
    try {
      // First, get admin token
      final adminToken = await _getAdminToken();
      if (adminToken == null) {
        return {
          'success': false,
          'message': 'Failed to authenticate with server. Please try again.',
        };
      }

      // Format data according to your API requirements
      final requestData = {
        'fullName': userData['fullName'],
        'aadhaarPassport': userData['aadhaarPassport'],
        'mobile': '+91${userData['mobileNumber']}', // Add +91 prefix
        'dob': userData['dateOfBirth'],
        'departingDate': userData['departingDate'],
        'password': userData['password'],
      };

      print('Sending signup request to: $_baseUrl/api/admin/users/register');
      print('Request data: ${jsonEncode(requestData)}');
      
      final response = await http.post(
        Uri.parse('$_baseUrl/api/admin/users/register'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $adminToken',
        },
        body: jsonEncode(requestData),
      );
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        
        // Registration successful, now login the user automatically
        final loginResult = await login(userData['username'], userData['password']);
        
        if (loginResult['success'] == true) {
          return {
            'success': true,
            'message': 'Registration successful! You are now logged in.',
            'userId': responseData['userId'] ?? responseData['id'] ?? responseData['_id'],
            'user': loginResult['user'],
          };
        } else {
          // Registration successful but login failed
          return {
            'success': true,
            'message': 'Registration successful! Please login manually.',
            'userId': responseData['userId'] ?? responseData['id'] ?? responseData['_id'],
            'requiresLogin': true,
          };
        }
      } else {
        final responseData = jsonDecode(response.body);
        return {
          'success': false,
          'message': responseData['message'] ?? 'Registration failed',
          'errors': responseData['errors'],
        };
      }
    } catch (e) {
      print('Signup error: $e');
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
      };
    }
  }



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