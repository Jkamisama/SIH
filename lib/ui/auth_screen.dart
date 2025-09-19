import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/glassmorphism_card.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/inline_calendar.dart';
import '../utils/validators.dart';
import '../services/auth_service.dart';
import 'package:intl/intl.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final AuthService _authService = AuthService();
  
  // Form keys
  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();
  
  // Loading states
  bool _isLoginLoading = false;
  bool _isSignupLoading = false;
  
  // Login controllers
  final _loginUsernameController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  
  // Signup controllers
  final _signupFullNameController = TextEditingController();
  final _signupAadhaarPassportController = TextEditingController();
  final _signupMobileController = TextEditingController();
  final _signupPasswordController = TextEditingController();
  final _signupConfirmPasswordController = TextEditingController();
  final _signupUsernameController = TextEditingController();
  
  // Date selections
  DateTime? _selectedDateOfBirth;
  DateTime? _selectedDepartingDate;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginUsernameController.dispose();
    _loginPasswordController.dispose();
    _signupFullNameController.dispose();
    _signupAadhaarPassportController.dispose();
    _signupMobileController.dispose();
    _signupPasswordController.dispose();
    _signupConfirmPasswordController.dispose();
    _signupUsernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wallpaperflare.com_wallpaper.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: GlassmorphismCard(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // App Title
                      const Text(
                        'Harsh Side App',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // Tab Bar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            color: const Color(0xFF6C63FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white.withOpacity(0.7),
                          tabs: const [
                            Tab(text: 'Login'),
                            Tab(text: 'Signup'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // Tab Views
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildLoginTab(),
                            _buildSignupTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  } 
 Widget _buildLoginTab() {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          CustomTextField(
            label: 'Username',
            controller: _loginUsernameController,
            validator: Validators.validateUsername,
          ),
          const SizedBox(height: 20),
          
          CustomTextField(
            label: 'Password',
            controller: _loginPasswordController,
            isPassword: true,
            validator: Validators.validatePassword,
          ),
          const SizedBox(height: 32),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoginLoading ? null : _handleLogin,
              child: _isLoginLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Login',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupTab() {
    return Form(
      key: _signupFormKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              label: 'Full Name',
              controller: _signupFullNameController,
              validator: Validators.validateFullName,
            ),
            const SizedBox(height: 20),
            
            CustomTextField(
              label: 'Aadhaar/Passport Number',
              controller: _signupAadhaarPassportController,
              validator: Validators.validateAadhaarPassport,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            
            CustomTextField(
              label: 'Mobile Number',
              controller: _signupMobileController,
              validator: Validators.validateMobileNumber,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
            const SizedBox(height: 20),
            
            InlineCalendar(
              label: 'Date of Birth',
              selectedDate: _selectedDateOfBirth,
              onDateSelected: (date) {
                setState(() {
                  _selectedDateOfBirth = date;
                });
              },
              lastDate: DateTime.now(),
              validator: Validators.validateDateOfBirth,
            ),
            const SizedBox(height: 20),
            
            CustomTextField(
              label: 'Password',
              controller: _signupPasswordController,
              isPassword: true,
              validator: Validators.validatePassword,
            ),
            const SizedBox(height: 20),
            
            CustomTextField(
              label: 'Confirm Password',
              controller: _signupConfirmPasswordController,
              isPassword: true,
              validator: (value) => Validators.validateConfirmPassword(
                value,
                _signupPasswordController.text,
              ),
            ),
            const SizedBox(height: 20),
            
            InlineCalendar(
              label: 'Departing Date',
              selectedDate: _selectedDepartingDate,
              onDateSelected: (date) {
                setState(() {
                  _selectedDepartingDate = date;
                });
              },
              firstDate: DateTime.now(),
              validator: Validators.validateDepartingDate,
            ),
            const SizedBox(height: 20),
            
            CustomTextField(
              label: 'Username',
              controller: _signupUsernameController,
              validator: Validators.validateUsername,
            ),
            const SizedBox(height: 32),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSignupLoading ? null : _handleSignup,
                child: _isSignupLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Register',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (!_loginFormKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoginLoading = true;
    });

    try {
      final result = await _authService.login(
        _loginUsernameController.text.trim(),
        _loginPasswordController.text,
      );

      if (result['success'] == true) {
        _showSuccessSnackBar('Login successful! Welcome back.');
        // Navigate to home screen
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        _showErrorSnackBar(result['message'] ?? 'Login failed');
      }
    } catch (e) {
      _showErrorSnackBar('An error occurred during login');
    } finally {
      setState(() {
        _isLoginLoading = false;
      });
    }
  }

  Future<void> _handleSignup() async {
    if (!_signupFormKey.currentState!.validate()) {
      return;
    }

    // Validate dates
    if (_selectedDateOfBirth == null) {
      _showErrorSnackBar('Please select your date of birth');
      return;
    }

    if (_selectedDepartingDate == null) {
      _showErrorSnackBar('Please select your departing date');
      return;
    }

    final dobError = Validators.validateDateOfBirth(_selectedDateOfBirth);
    if (dobError != null) {
      _showErrorSnackBar(dobError);
      return;
    }

    final departingError = Validators.validateDepartingDate(_selectedDepartingDate);
    if (departingError != null) {
      _showErrorSnackBar(departingError);
      return;
    }

    setState(() {
      _isSignupLoading = true;
    });

    try {
      final userData = {
        'fullName': _signupFullNameController.text.trim(),
        'aadhaarPassport': _signupAadhaarPassportController.text.trim(),
        'mobileNumber': _signupMobileController.text.trim(),
        'dateOfBirth': DateFormat('yyyy-MM-dd').format(_selectedDateOfBirth!),
        'password': _signupPasswordController.text,
        'departingDate': DateFormat('yyyy-MM-dd').format(_selectedDepartingDate!),
        'username': _signupUsernameController.text.trim(),
      };

      final result = await _authService.signup(userData);

      if (result['success'] == true) {
        _showSuccessSnackBar('Registration successful! User ID: ${result['userId']}');
        // Navigate to home screen
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        _showErrorSnackBar(result['message'] ?? 'Registration failed');
      }
    } catch (e) {
      _showErrorSnackBar('An error occurred during registration');
    } finally {
      setState(() {
        _isSignupLoading = false;
      });
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}