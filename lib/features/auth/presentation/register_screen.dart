import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../data/auth_dto.dart';
import '../domain/auth_state.dart';
import '../providers/auth_notifier.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _agreedToTOS = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _errorMessage;
  Map<String, String>? _fieldErrors;

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authNotifierProvider).isLoading;

    ref.listen<AsyncValue<AuthState>>(authNotifierProvider, (_, next) {
      next.whenOrNull(
        data: (authState) {
          if (authState is Authenticated && mounted) {
            // TODO(M3): go to /qr-scan if no active table session
            context.go(AppRoutes.home);
          }
        },
        error: (err, _) {
          if (!mounted) return;
          setState(() {
            if (err is ApiException) {
              _errorMessage = err.message;
              _fieldErrors = err.fieldErrors;
            } else {
              _errorMessage = 'An unexpected error occurred.';
              _fieldErrors = null;
            }
          });
        },
        loading: () => setState(() {
          _errorMessage = null;
          _fieldErrors = null;
        }),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFFFFFF), Color(0xFFFFF7F0)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Text(
                  'FEAST',
                  style: GoogleFonts.inter(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: FeastColors.primary,
                    letterSpacing: 4.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'FOOD ECOSYSTEM ALLIANCE & SMART',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFE5B581),
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 40),
                _buildTextField(
                  controller: _fullNameController,
                  hintText: 'Full Name',
                  icon: Icons.person_outline,
                  fieldKey: 'full_name',
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _phoneController,
                  hintText: 'Phone Number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  fieldKey: 'phone',
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _emailController,
                  hintText: 'Email (optional)',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  fieldKey: 'email',
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                  obscure: _obscurePassword,
                  onToggleObscure: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  fieldKey: 'password',
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  icon: Icons.security_outlined,
                  isPassword: true,
                  obscure: _obscureConfirmPassword,
                  onToggleObscure: () => setState(
                      () => _obscureConfirmPassword = !_obscureConfirmPassword),
                  fieldKey: 'confirm_password',
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: FeastColors.error.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: GoogleFonts.inter(
                          fontSize: 13, color: FeastColors.error),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _agreedToTOS,
                        onChanged: isLoading
                            ? null
                            : (value) =>
                                setState(() => _agreedToTOS = value ?? false),
                        activeColor: FeastColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        side: const BorderSide(color: Color(0xFFBDBDBD)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: const Color(0xFF888888),
                            height: 1.5,
                          ),
                          children: [
                            const TextSpan(text: 'Saya menyetujui '),
                            TextSpan(
                              text: 'Syarat & Ketentuan',
                              style: TextStyle(color: FeastColors.primary),
                            ),
                            const TextSpan(text: ' serta\n'),
                            TextSpan(
                              text: 'Kebijakan Privasi',
                              style: TextStyle(color: FeastColors.primary),
                            ),
                            const TextSpan(text: ' FEAST'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _onRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: FeastColors.primary,
                      disabledBackgroundColor:
                          FeastColors.primary.withValues(alpha: 0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Create Account',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF888888),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Text(
                        'LOGIN',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: FeastColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onRegister() {
    final fullName = _fullNameController.text.trim();
    final phone = _phoneController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // Client-side validation
    if (fullName.isEmpty || phone.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all required fields.';
        _fieldErrors = null;
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _errorMessage = null;
        _fieldErrors = {'confirm_password': 'Passwords do not match.'};
      });
      return;
    }

    if (!_agreedToTOS) {
      setState(() {
        _errorMessage = 'Please agree to the Terms & Conditions.';
        _fieldErrors = null;
      });
      return;
    }

    final request = RegisterRequest(
      phone: phone,
      fullName: fullName,
      password: password,
      email: email.isEmpty ? null : email,
    );

    ref.read(authNotifierProvider.notifier).register(request);
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    bool obscure = false,
    VoidCallback? onToggleObscure,
    TextInputType? keyboardType,
    String? fieldKey,
  }) {
    final fieldError = (fieldKey != null && _fieldErrors != null)
        ? _fieldErrors![fieldKey]
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: fieldError != null
                  ? FeastColors.error
                  : const Color(0xFFE0E0E0),
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword ? obscure : false,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFFBDBDBD),
                fontSize: 14,
              ),
              icon: Icon(icon, color: const Color(0xFFBDBDBD), size: 20),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: const Color(0xFFBDBDBD),
                        size: 20,
                      ),
                      onPressed: onToggleObscure,
                    )
                  : null,
            ),
          ),
        ),
        if (fieldError != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 20),
            child: Text(
              fieldError,
              style:
                  GoogleFonts.inter(fontSize: 11, color: FeastColors.error),
            ),
          ),
      ],
    );
  }
}
