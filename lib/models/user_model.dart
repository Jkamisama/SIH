class User {
  final String id;
  final String username;
  final String fullName;
  final String email;
  final String mobileNumber;
  final String? aadhaarPassport;
  final String? dateOfBirth;
  final String? departingDate;
  final String token;

  User({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    this.aadhaarPassport,
    this.dateOfBirth,
    this.departingDate,
    required this.token,
  });

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'fullName': fullName,
      'email': email,
      'mobileNumber': mobileNumber,
      'aadhaarPassport': aadhaarPassport,
      'dateOfBirth': dateOfBirth,
      'departingDate': departingDate,
      'token': token,
    };
  }

  // Create User object from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      aadhaarPassport: json['aadhaarPassport'],
      dateOfBirth: json['dateOfBirth'],
      departingDate: json['departingDate'],
      token: json['token'] ?? '',
    );
  }

  // Create a copy of User with updated fields
  User copyWith({
    String? id,
    String? username,
    String? fullName,
    String? email,
    String? mobileNumber,
    String? aadhaarPassport,
    String? dateOfBirth,
    String? departingDate,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      aadhaarPassport: aadhaarPassport ?? this.aadhaarPassport,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      departingDate: departingDate ?? this.departingDate,
      token: token ?? this.token,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, username: $username, fullName: $fullName, email: $email)';
  }
}