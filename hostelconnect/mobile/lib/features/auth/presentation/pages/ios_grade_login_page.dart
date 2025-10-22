// lib/features/auth/presentation/pages/ios_grade_login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/auth/auth_service.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_card.dart';

class IOSGradeLoginPage extends ConsumerStatefulWidget {
  const IOSGradeLoginPage({super.key});

  @override
  ConsumerState<IOSGradeLoginPage> createState() => _IOSGradeLoginPageState();
}

class _IOSGradeLoginPageState extends ConsumerState<IOSGradeLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(AuthService.authStateProvider);
    
    // Show loading screen during initial auth check
    if (authState.isLoading) {
      return const Scaffold(
        backgroundColor: IOSGradeTheme.background,
        body: Center(
          child: CircularProgressIndicator(
            color: IOSGradeTheme.primary,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(IOSGradeTheme.spacing6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: IOSGradeTheme.spacing9),
              _buildHeader(),
              const SizedBox(height: IOSGradeTheme.spacing9),
              _buildLoginForm(),
              const SizedBox(height: IOSGradeTheme.spacing6),
              _buildDemoCredentials(),
              const SizedBox(height: IOSGradeTheme.spacing7),
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
          padding: const EdgeInsets.all(IOSGradeTheme.spacing6),
          decoration: BoxDecoration(
            color: IOSGradeTheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(IOSGradeTheme.radiusXLarge),
          ),
          child: const Icon(
            Icons.home_work_outlined,
            size: 64,
            color: IOSGradeTheme.primary,
          ),
        ),
        const SizedBox(height: IOSGradeTheme.spacing6),
        Text(
          'HostelConnect',
          style: IOSGradeTheme.largeTitle.copyWith(
            color: IOSGradeTheme.primary,
          ),
        ),
        const SizedBox(height: IOSGradeTheme.spacing2),
        Text(
          'Your Complete Hostel Management Solution',
          style: IOSGradeTheme.body.copyWith(
            color: IOSGradeTheme.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return IOSGradeCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome Back',
              style: IOSGradeTheme.title1.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: IOSGradeTheme.spacing2),
            Text(
              'Sign in to your account',
              style: IOSGradeTheme.callout.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: IOSGradeTheme.spacing7),
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
            const SizedBox(height: IOSGradeTheme.spacing4),
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
            const SizedBox(height: IOSGradeTheme.spacing2),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => _showForgotPassword(),
                child: const Text('Forgot Password?'),
              ),
            ),
            const SizedBox(height: IOSGradeTheme.spacing6),
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: _handleLogin,
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 17,
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
    return IOSGradeCard(
      backgroundColor: IOSGradeTheme.primary.withOpacity(0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: IOSGradeTheme.primary,
                size: 20,
              ),
              const SizedBox(width: IOSGradeTheme.spacing2),
              Text(
                'Demo Credentials',
                style: IOSGradeTheme.headline.copyWith(
                  color: IOSGradeTheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: IOSGradeTheme.spacing3),
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
      padding: const EdgeInsets.symmetric(vertical: IOSGradeTheme.spacing1),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              role,
              style: IOSGradeTheme.callout.copyWith(
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
                style: IOSGradeTheme.callout.copyWith(
                  color: IOSGradeTheme.primary,
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
          style: IOSGradeTheme.body.copyWith(
            color: IOSGradeTheme.textSecondary,
          ),
        ),
        const SizedBox(height: IOSGradeTheme.spacing2),
        TextButton(
          onPressed: () => _showRegister(),
          child: const Text('Create Account'),
        ),
        const SizedBox(height: IOSGradeTheme.spacing6),
        Text(
          '© 2024 HostelConnect. All rights reserved.',
          style: IOSGradeTheme.caption1.copyWith(
            color: IOSGradeTheme.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final authNotifier = ref.read(AuthService.authStateProvider.notifier);
      await authNotifier.login(_emailController.text, _passwordController.text);
      
      final authState = ref.read(AuthService.authStateProvider);
      if (authState.isAuthenticated) {
        // Navigation will be handled by the main app
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Welcome back, ${authState.user?.firstName}!'),
            backgroundColor: IOSGradeTheme.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else if (authState.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authState.error!),
            backgroundColor: IOSGradeTheme.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
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
