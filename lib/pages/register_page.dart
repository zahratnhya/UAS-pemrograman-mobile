import 'package:flutter/material.dart';
import '../repositories/auth_repository.dart';
import '../utils/network_wrrapper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthRepository _repository = AuthRepository();
  
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final confirmPassC = TextEditingController();
  final campusC = TextEditingController();
  final majorC = TextEditingController();
  final semesterC = TextEditingController();

  bool loading = false;
  bool showPassword = false;
  bool showConfirmPassword = false;
  String? errorMessage;
  String? successMessage;

  @override
  void dispose() {
    nameC.dispose();
    emailC.dispose();
    passC.dispose();
    confirmPassC.dispose();
    campusC.dispose();
    majorC.dispose();
    semesterC.dispose();
    super.dispose();
  }

  Future<void> register() async {
    setState(() {
      loading = true;
      errorMessage = null;
      successMessage = null;
    });

    try {
      final result = await _repository.registerUser(
        name: nameC.text,
        email: emailC.text,
        password: passC.text,
        confirmPassword: confirmPassC.text,
        campus: campusC.text.isEmpty ? null : campusC.text,
        major: majorC.text.isEmpty ? null : majorC.text,
        semester: semesterC.text.isEmpty ? null : int.tryParse(semesterC.text),
      );

      if (!mounted) return;

      if (result['success'] == true) {
        setState(() {
          successMessage = "Registrasi berhasil! Silakan login.";
        });

        // Delay sebelum kembali ke halaman login
        await Future.delayed(const Duration(seconds: 2));
        
        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        setState(() {
          errorMessage = result['message'] ?? "Registrasi gagal";
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = "Terjadi kesalahan saat registrasi";
        });
      }
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return NetworkWrapper(
      showSnackbar: true,
      showOverlay: true,
      child: _buildPage(),
    );
  }

  Widget _buildPage() {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                _buildBackButton(),
                const SizedBox(height: 20),
                _buildHeader(),
                const SizedBox(height: 30),
                _buildRegisterForm(),
                const SizedBox(height: 24),
                _buildLoginLink(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Icons.arrow_back_rounded,
        color: Colors.indigo.shade600,
        size: 28,
      ),
      style: IconButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade600, Colors.indigo.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(Icons.person_add_rounded, color: Colors.white, size: 40),
        ),
        const SizedBox(height: 24),
        const Text(
          "Create Account",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1F36),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Sign up to get started with CampusPlanner",
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterForm() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            label: "Nama Lengkap",
            controller: nameC,
            hint: "Masukkan nama lengkap",
            icon: Icons.person_rounded,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            label: "Email Address",
            controller: emailC,
            hint: "yourmail@example.com",
            icon: Icons.email_rounded,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          _buildPasswordField(
            label: "Password",
            controller: passC,
            hint: "Minimal 6 karakter",
            showPassword: showPassword,
            onToggle: () => setState(() => showPassword = !showPassword),
          ),
          const SizedBox(height: 20),
          _buildPasswordField(
            label: "Konfirmasi Password",
            controller: confirmPassC,
            hint: "Ulangi password",
            showPassword: showConfirmPassword,
            onToggle: () => setState(() => showConfirmPassword = !showConfirmPassword),
          ),
          const SizedBox(height: 24),
          _buildDivider(),
          const SizedBox(height: 24),
          _buildTextField(
            label: "Kampus (Opsional)",
            controller: campusC,
            hint: "Nama kampus",
            icon: Icons.school_rounded,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            label: "Jurusan (Opsional)",
            controller: majorC,
            hint: "Nama jurusan",
            icon: Icons.book_rounded,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            label: "Semester (Opsional)",
            controller: semesterC,
            hint: "Contoh: 5",
            icon: Icons.calendar_today_rounded,
            keyboardType: TextInputType.number,
          ),
          
          if (errorMessage != null) ...[
            const SizedBox(height: 20),
            _buildErrorMessage(),
          ],
          
          if (successMessage != null) ...[
            const SizedBox(height: 20),
            _buildSuccessMessage(),
          ],
          
          const SizedBox(height: 32),
          _buildRegisterButton(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FE),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.indigo.shade100,
              width: 1.5,
            ),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1A1F36),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 15,
              ),
              prefixIcon: Container(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  icon,
                  color: Colors.indigo.shade600,
                  size: 22,
                ),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required bool showPassword,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FE),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.indigo.shade100,
              width: 1.5,
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: !showPassword,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1A1F36),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 15,
              ),
              prefixIcon: Container(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.lock_rounded,
                  color: Colors.indigo.shade600,
                  size: 22,
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  showPassword
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  color: Colors.grey.shade600,
                  size: 22,
                ),
                onPressed: onToggle,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Informasi Tambahan",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade300)),
      ],
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.red.shade200,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: Colors.red.shade700,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              errorMessage!,
              style: TextStyle(
                color: Colors.red.shade700,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.green.shade200,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            color: Colors.green.shade700,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              successMessage!,
              style: TextStyle(
                color: Colors.green.shade700,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: loading ? null : register,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo.shade600,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: Colors.indigo.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          disabledBackgroundColor: Colors.indigo.shade300,
        ),
        child: loading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 20,
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sudah punya akun? ",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.indigo.shade600,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
            child: const Text(
              "Login",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}