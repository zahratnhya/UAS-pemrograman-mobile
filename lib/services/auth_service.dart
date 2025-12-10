import 'dart:convert';
import 'package:http/http.dart' as http;

/// Service layer untuk mengelola operasi authentication
class AuthService {
  static const String _baseUrl = "https://zahraapi.xyz/campus_api/index.php";

  /// Login user dengan email dan password
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$_baseUrl?path=users&action=login");

    try {
      print('===== LOGIN REQUEST =====');
      print('URL: $url');
      print('Email: $email');

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
      print('========================');

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        return {
          'success': decoded['success'] ?? false,
          'message': decoded['message'] ?? 'Unknown error',
          'user': decoded['user'],
        };
      }

      return {
        'success': false,
        'message': 'HTTP Error ${response.statusCode}',
        'user': null,
      };
    } catch (e) {
      print('Error during login: $e');
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
        'user': null,
      };
    }
  }

  /// Register user baru
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    String? campus,
    String? major,
    int? semester,
    String? profileImageBase64,
  }) async {
    final url = Uri.parse("$_baseUrl?path=users&action=register");

    try {
      print('===== REGISTER REQUEST =====');
      print('URL: $url');
      print('Name: $name');
      print('Email: $email');
      print('Campus: $campus');
      print('Major: $major');
      print('Semester: $semester');

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "campus": campus,
          "major": major,
          "semester": semester,
          "profile_image": profileImageBase64,
        }),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
      print('============================');

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        return {
          'success': decoded['success'] ?? false,
          'message': decoded['message'] ?? 'Unknown error',
        };
      }

      return {
        'success': false,
        'message': 'HTTP Error ${response.statusCode}',
      };
    } catch (e) {
      print('Error during register: $e');
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }
}