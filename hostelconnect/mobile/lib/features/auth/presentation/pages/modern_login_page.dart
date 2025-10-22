// lib/features/auth/presentation/pages/modern_login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/theme/modern_theme.dart';
import '../../../../shared/widgets/ui/modern_card.dart';

class ModernLoginPage extends ConsumerStatefulWidget {
  const ModernLoginPage({super.key});

  @override
  ConsumerState<ModernLoginPage> createState() => _ModernLoginPageState();
}

class _ModernLoginPageState extends ConsumerState<ModernLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ModernTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(ModernTheme.spacing24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: ModernTheme.spacing48),
              _buildHeader(),
              const SizedBox(height: ModernTheme.spacing48),
              _buildLoginForm(),
              const SizedBox(height: ModernTheme.spacing24),
              _buildDemoCredentials(),
              const SizedBox(height: ModernTheme.spacing32),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(ModernTheme.spacing24),
          decoration: BoxDecoration(
            color: ModernTheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(ModernTheme.radius24),
          ),
          child: const Icon(
            Icons.home_work_outlined,
            size: 64,
            color: ModernTheme.primary,
          ),
        ),
        const SizedBox(height: ModernTheme.spacing24),
        Text(
          'HostelConnect',
          style: ModernTheme.displayMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: ModernTheme.primary,
          ),
        ),
        const SizedBox(height: ModernTheme.spacing8),
        Text(
          'Your Complete Hostel Management Solution',
          style: ModernTheme.bodyLarge.copyWith(
            color: ModernTheme.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return ModernCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome Back',
              style: ModernTheme.headlineMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: ModernTheme.spacing8),
            Text(
              'Sign in to your account',
              style: ModernTheme.bodyMedium.copyWith(
                color: ModernTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: ModernTheme.spacing32),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: ModernTheme.spacing16),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock_outlined),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: ModernTheme.spacing8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => _showForgotPassword(),
                child: const Text('Forgot Password?'),
              ),
            ),
            const SizedBox(height: ModernTheme.spacing24),
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoCredentials() {
    return ModernCard(
      backgroundColor: ModernTheme.info.withOpacity(0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: ModernTheme.info,
                size: 20,
              ),
              const SizedBox(width: ModernTheme.spacing8),
              Text(
                'Demo Credentials',
                style: ModernTheme.titleMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ModernTheme.info,
                ),
              ),
            ],
          ),
          const SizedBox(height: ModernTheme.spacing12),
          _buildDemoCredential('Super Admin', 'admin@demo.com', 'password123'),
          _buildDemoCredential('Warden', 'warden@demo.com', 'password123'),
          _buildDemoCredential('Student', 'student@demo.com', 'password123'),
          _buildDemoCredential('Chef', 'chef@demo.com', 'password123'),
        ],
      ),
    );
  }

  Widget _buildDemoCredential(String role, String email, String password) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: ModernTheme.spacing4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              role,
              style: ModernTheme.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                _emailController.text = email;
                _passwordController.text = password;
              },
              child: Text(
                email,
                style: ModernTheme.bodySmall.copyWith(
                  color: ModernTheme.info,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Text(
          'New to HostelConnect?',
          style: ModernTheme.bodyMedium.copyWith(
            color: ModernTheme.textSecondary,
          ),
        ),
        const SizedBox(height: ModernTheme.spacing8),
        TextButton(
          onPressed: () => _showRegister(),
          child: const Text('Create Account'),
        ),
        const SizedBox(height: ModernTheme.spacing24),
        Text(
          '© 2024 HostelConnect. All rights reserved.',
          style: ModernTheme.bodySmall.copyWith(
            color: ModernTheme.textTertiary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate login process
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // TODO: Implement actual login logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login successful! Welcome ${_emailController.text}'),
          backgroundColor: ModernTheme.success,
        ),
      );
    }
  }

  void _showForgotPassword() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Forgot Password'),
        content: const Text('Password reset functionality will be implemented soon.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showRegister() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Account'),
        content: const Text('Account creation functionality will be implemented soon.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
