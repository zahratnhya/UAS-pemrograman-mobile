import '../services/auth_service.dart';

/// Repository layer untuk mengelola business logic authentication
class AuthRepository {
  final AuthService _service = AuthService();

  /// Login user
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    // Validasi input
    if (email.trim().isEmpty) {
      return {
        'success': false,
        'message': 'Email is required',
        'userId': null,
      };
    }

    if (password.trim().isEmpty) {
      return {
        'success': false,
        'message': 'Password is required',
        'userId': null,
      };
    }

    // Validasi format email
    if (!_isValidEmail(email.trim())) {
      return {
        'success': false,
        'message': 'Invalid email format',
        'userId': null,
      };
    }

    // Call service
    final result = await _service.login(
      email: email.trim(),
      password: password.trim(),
    );

    // Process result
    if (result['success'] == true && result['user'] != null) {
      final userId = int.parse(result['user']['id'].toString());
      return {
        'success': true,
        'message': 'Login successful',
        'userId': userId,
      };
    }

    return {
      'success': false,
      'message': result['message'] ?? 'Login failed',
      'userId': null,
    };
  }

  /// Register user baru
  Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    String? campus,
    String? major,
    int? semester,
    String? profileImageBase64,
  }) async {
    // Validasi input wajib
    if (name.trim().isEmpty) {
      return {
        'success': false,
        'message': 'Nama tidak boleh kosong',
      };
    }

    if (email.trim().isEmpty) {
      return {
        'success': false,
        'message': 'Email tidak boleh kosong',
      };
    }

    if (password.trim().isEmpty) {
      return {
        'success': false,
        'message': 'Password tidak boleh kosong',
      };
    }

    if (confirmPassword.trim().isEmpty) {
      return {
        'success': false,
        'message': 'Konfirmasi password tidak boleh kosong',
      };
    }

    // Validasi format email
    if (!_isValidEmail(email.trim())) {
      return {
        'success': false,
        'message': 'Format email tidak valid',
      };
    }

    // Validasi panjang password
    if (password.length < 6) {
      return {
        'success': false,
        'message': 'Password minimal 6 karakter',
      };
    }

    // Validasi password match
    if (password != confirmPassword) {
      return {
        'success': false,
        'message': 'Password tidak cocok',
      };
    }

    // Call service
    final result = await _service.register(
      name: name.trim(),
      email: email.trim(),
      password: password.trim(),
      campus: campus?.trim(),
      major: major?.trim(),
      semester: semester,
      profileImageBase64: profileImageBase64,
    );

    return {
      'success': result['success'] ?? false,
      'message': result['message'] ?? 'Register failed',
    };
  }

  /// Validasi format email
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}