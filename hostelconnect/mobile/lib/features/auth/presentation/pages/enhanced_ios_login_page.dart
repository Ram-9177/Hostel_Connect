// lib/features/auth/presentation/pages/enhanced_ios_login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../core/auth/auth_service.dart';

class EnhancedIOSLoginPage extends ConsumerStatefulWidget {
  const EnhancedIOSLoginPage({super.key});

  @override
  ConsumerState<EnhancedIOSLoginPage> createState() => _EnhancedIOSLoginPageState();
}

class _EnhancedIOSLoginPageState extends ConsumerState<EnhancedIOSLoginPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Start animations with delays
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _slideController.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _scaleController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: Listenable.merge([_fadeAnimation, _slideAnimation, _scaleAnimation]),
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(IOSGradeTheme.spacing6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: IOSGradeTheme.spacing8),
                        _buildHeader(),
                        const SizedBox(height: IOSGradeTheme.spacing8),
                        _buildLoginForm(),
                        const SizedBox(height: IOSGradeTheme.spacing6),
                        _buildDemoCredentials(),
                        const SizedBox(height: IOSGradeTheme.spacing8),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                IOSGradeTheme.primary,
                IOSGradeTheme.primaryDark,
              ],
            ),
            borderRadius: BorderRadius.circular(IOSGradeTheme.radiusLarge),
            boxShadow: [
              BoxShadow(
                color: IOSGradeTheme.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.home_outlined,
            color: Colors.white,
            size: 50,
          ),
        ),
        const SizedBox(height: IOSGradeTheme.spacing4),
        Text(
          'HostelConnect',
          style: IOSGradeTheme.largeTitle.copyWith(
            fontWeight: FontWeight.w800,
            color: IOSGradeTheme.textPrimary,
          ),
        ),
        const SizedBox(height: IOSGradeTheme.spacing2),
        Text(
          'Your digital hostel companion',
          style: IOSGradeTheme.body.copyWith(
            color: IOSGradeTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return IOSGradeCard(
      padding: const EdgeInsets.all(IOSGradeTheme.spacing6),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome Back',
              style: IOSGradeTheme.title1.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: IOSGradeTheme.spacing2),
            Text(
              'Sign in to continue',
              style: IOSGradeTheme.body.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: IOSGradeTheme.spacing6),
            
            IOSGradeInputField(
              label: 'Email',
              hintText: 'Enter your email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: IOSGradeTheme.textSecondary,
              ),
            ),
            
            const SizedBox(height: IOSGradeTheme.spacing4),
            
            IOSGradeInputField(
              label: 'Password',
              hintText: 'Enter your password',
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: IOSGradeTheme.textSecondary,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  color: IOSGradeTheme.textSecondary,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                  HapticFeedback.lightImpact();
                },
              ),
            ),
            
            const SizedBox(height: IOSGradeTheme.spacing6),
            
            IOSGradeButton(
              text: _isLoading ? 'Signing In...' : 'Sign In',
              isLoading: _isLoading,
              onPressed: _isLoading ? null : _handleLogin,
            ),
            
            const SizedBox(height: IOSGradeTheme.spacing4),
            
            TextButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                _showForgotPassword();
              },
              child: Text(
                'Forgot Password?',
                style: IOSGradeTheme.body.copyWith(
                  color: IOSGradeTheme.primary,
                  fontWeight: FontWeight.w600,
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
      backgroundColor: IOSGradeTheme.info.withOpacity(0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: IOSGradeTheme.info,
                size: 20,
              ),
              const SizedBox(width: IOSGradeTheme.spacing2),
              Text(
                'Demo Credentials',
                style: IOSGradeTheme.headline.copyWith(
                  fontWeight: FontWeight.w600,
                  color: IOSGradeTheme.info,
                ),
              ),
            ],
          ),
          const SizedBox(height: IOSGradeTheme.spacing3),
          _buildCredentialItem('Student', 'student@demo.com', 'password123'),
          _buildCredentialItem('Warden', 'warden@demo.com', 'password123'),
          _buildCredentialItem('Super Admin', 'admin@demo.com', 'password123'),
          _buildCredentialItem('Chef', 'chef@demo.com', 'password123'),
        ],
      ),
    );
  }

  Widget _buildCredentialItem(String role, String email, String password) {
    return Padding(
      padding: const EdgeInsets.only(bottom: IOSGradeTheme.spacing2),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: IOSGradeTheme.info,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: IOSGradeTheme.spacing2),
          Expanded(
            child: Text(
              '$role: $email',
              style: IOSGradeTheme.footnote.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              _emailController.text = email;
              _passwordController.text = password;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: IOSGradeTheme.spacing2,
                vertical: IOSGradeTheme.spacing1,
              ),
              decoration: BoxDecoration(
                color: IOSGradeTheme.info.withOpacity(0.1),
                borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
              ),
              child: Text(
                'Use',
                style: IOSGradeTheme.caption1.copyWith(
                  color: IOSGradeTheme.info,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      HapticFeedback.heavyImpact();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      HapticFeedback.mediumImpact();
      
      final authNotifier = ref.read(AuthService.authStateProvider.notifier);
      await authNotifier.login(
        _emailController.text.trim(),
        _passwordController.text,
      );
      
      // Success - navigation will be handled by AuthWrapper
    } catch (e) {
      HapticFeedback.heavyImpact();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${e.toString()}'),
            backgroundColor: IOSGradeTheme.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showForgotPassword() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: IOSGradeTheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
        ),
        title: Text(
          'Forgot Password?',
          style: IOSGradeTheme.title2.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Please contact your hostel administrator to reset your password.',
          style: IOSGradeTheme.body,
        ),
        actions: [
          TextButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
              style: IOSGradeTheme.body.copyWith(
                color: IOSGradeTheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
