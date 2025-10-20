import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/network_config.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/state/app_state.dart';
import '../../../../shared/widgets/ui/professional_components.dart';
import '../../../../shared/widgets/error_handling/network_error_widget.dart';
import '../../../../core/responsive.dart';
import '../../../../shared/theme/telugu_theme.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  late AnimationController _logoController;
  late AnimationController _formController;
  late AnimationController _backgroundController;
  
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoRotationAnimation;
  late Animation<Offset> _formSlideAnimation;
  late Animation<double> _formFadeAnimation;
  late Animation<double> _backgroundOpacityAnimation;

  @override
  void initState() {
    super.initState();
    
    // Logo animations
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _logoScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));
    
    _logoRotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeInOut,
    ));
    
    // Form animations
    _formController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _formSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _formController,
      curve: Curves.easeOutCubic,
    ));
    
    _formFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _formController,
      curve: Curves.easeOut,
    ));
    
    // Background animation
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _backgroundOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeInOut,
    ));
    
    // Start animations
    _backgroundController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _logoController.forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      _formController.forward();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _logoController.dispose();
    _formController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);
    final appStateNotifier = ref.read(appStateProvider.notifier);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              HTokens.primary.withOpacity(0.1),
              HTokens.secondary.withOpacity(0.05),
              Colors.white,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: HResponsive.builder(builder: (ctx, r) {
            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(HTokens.xl),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 420),
                  child: AnimatedBuilder(
                    animation: Listenable.merge([
                      _backgroundController,
                      _logoController,
                      _formController,
                    ]),
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _backgroundOpacityAnimation,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Animated Logo Section
                            ScaleTransition(
                              scale: _logoScaleAnimation,
                              child: RotationTransition(
                                turns: _logoRotationAnimation,
                                child: Container(
                                  padding: EdgeInsets.all(HTokens.xl),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        HTokens.primary.withOpacity(0.1),
                                        HTokens.primary.withOpacity(0.05),
                                      ],
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.home_work_rounded,
                                    size: r.isXS ? 80 : 100,
                                    color: HTokens.primary,
                                  ),
                                ),
                              ),
                            ),
                            
                            SizedBox(height: HTokens.xl),
                            
                            // Animated Form Section
                            SlideTransition(
                              position: _formSlideAnimation,
                              child: FadeTransition(
                                opacity: _formFadeAnimation,
                                child: HProfessionalCard(
                                  backgroundColor: Colors.white.withOpacity(0.95),
                                  borderRadius: BorderRadius.circular(24),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Header
                                        Container(
                                          padding: const EdgeInsets.all(24),
                                          child: Column(
                                            children: [
                                              Text(
                                                AppConstants.appName,
                                                style: TextStyle(
                                                  fontSize: r.isXS ? 24 : 28,
                                                  fontWeight: FontWeight.bold,
                                                  color: HTokens.primary,
                                                ),
                                              ),
                                              SizedBox(height: HTokens.sm),
                                              Text(
                                                'Welcome back! Sign in to continue',
                                                style: TextStyle(
                                                  fontSize: r.isXS ? 14 : 16,
                                                  color: HTokens.onSurfaceVariant,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        
                                        SizedBox(height: HTokens.xl),
                                        
                                        // Form Fields
                                        Container(
                                          padding: const EdgeInsets.all(24),
                                          child: Column(
                                            children: [
                                              HProfessionalInput(
                                                label: 'Email Address',
                                                hint: 'Enter your email',
                                                controller: _emailController,
                                                keyboardType: TextInputType.emailAddress,
                                                prefixIcon: Icons.email_outlined,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter your email';
                                                  }
                                                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                                      .hasMatch(value)) {
                                                    return 'Please enter a valid email';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              
                                              SizedBox(height: HTokens.lg),

                                              HProfessionalInput(
                                                label: 'Password',
                                                hint: 'Enter your password',
                                                controller: _passwordController,
                                                obscureText: true,
                                                prefixIcon: Icons.lock_outline,
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
                                              
                                              SizedBox(height: HTokens.sm),
                                              
                                              // Forgot Password
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: TextButton(
                                                  onPressed: () {
                                                    // Implement forgot password functionality
                                                    _showForgotPasswordDialog();
                                                  },
                                                  child: Text(
                                                    'Forgot Password?',
                                                    style: TextStyle(
                                                      color: HTokens.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                                                ),
                                              ),
                                              
                                              SizedBox(height: HTokens.xl),
                                              
                                              // Login Button
                                              HProfessionalButton(
                                                text: 'Sign In',
                                                onPressed: appState.isLoading 
                                                    ? null 
                                                    : () => _handleLogin(appStateNotifier),
                                                isLoading: appState.isLoading,
                                                isFullWidth: true,
                                                size: HProfessionalButtonSize.large,
                                                icon: Icons.login_rounded,
                                              ),
                                              
                                              SizedBox(height: HTokens.lg),
                                              
                                              // Register Link
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: TextStyle(
                        color: HTokens.onSurfaceVariant,
                      ),
                    ),
                    TextButton(
                      onPressed: () => _showRegisterDialog(context, appStateNotifier),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: HTokens.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
                                        
                                        // Error Message
                                        if (appState.error != null) ...[
                                          SizedBox(height: HTokens.md),
                                          Container(
                                            padding: EdgeInsets.all(HTokens.md),
                                            decoration: BoxDecoration(
                                              color: HTokens.error.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(HTokens.cardRadius),
                                              border: Border.all(
                                                color: HTokens.error.withOpacity(0.3),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.error_outline,
                                                  color: HTokens.error,
                                                  size: 20,
                                                ),
                                                SizedBox(width: HTokens.sm),
                                                Expanded(
                                                  child: Text(
                                                    appState.error!,
                                                    style: TextStyle(
                                                      color: HTokens.error,
                                                      fontSize: r.isXS ? 12 : 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Future<void> _handleLogin(AppStateNotifier appStateNotifier) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Check network connectivity first
        final hasInternet = await NetworkConfig.hasInternetConnection();
        if (!hasInternet) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No internet connection available'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }

        // Test API connectivity
        final apiConnectivity = await NetworkConfig.testApiConnectivity();
        if (!apiConnectivity) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Unable to connect to server'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }

        await appStateNotifier.login(
          _emailController.text.trim(),
          _passwordController.text,
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login failed: ${e.toString()}'),
              backgroundColor: Colors.red,
              action: SnackBarAction(
                label: 'Diagnostics',
                textColor: Colors.white,
                onPressed: () => _showNetworkDiagnostics(),
              ),
            ),
          );
        }
      }
    }
  }

  void _showNetworkDiagnostics() async {
    final diagnostics = await NetworkConfig.getNetworkDiagnostics();
    
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Network Diagnostics'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDiagnosticItem('Internet Connection', diagnostics['hasInternet'] ? 'Connected' : 'Disconnected'),
                _buildDiagnosticItem('Connection Type', diagnostics['connectivityType']),
                _buildDiagnosticItem('API Connectivity', diagnostics['apiConnectivity'] ? 'Connected' : 'Failed'),
                _buildDiagnosticItem('API URL', diagnostics['apiUrl']),
                _buildDiagnosticItem('Platform', diagnostics['deviceInfo']['platform']),
                _buildDiagnosticItem('Model', diagnostics['deviceInfo']['model']),
                _buildDiagnosticItem('Version', diagnostics['deviceInfo']['version']),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleLogin(ref.read(appStateProvider.notifier));
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildDiagnosticItem(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value?.toString() ?? 'Unknown',
              style: TextStyle(
                color: value == true ? Colors.green : 
                       value == false ? Colors.red : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRegisterDialog(BuildContext context, AppStateNotifier appStateNotifier) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => RegisterDialog(appStateNotifier: appStateNotifier),
    );
  }

  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reset Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Enter your email address to receive password reset instructions.'),
            SizedBox(height: HTokens.md),
            HProfessionalInput(
              controller: TextEditingController(),
              label: 'Email Address',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email address';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          HProfessionalButton(
            onPressed: () {
              // TODO: Implement password reset
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password reset instructions sent to your email!'),
                ),
              );
              Navigator.pop(context);
            },
            text: 'Send Reset Link',
            variant: HProfessionalButtonVariant.primary,
          ),
        ],
      ),
    );
  }
}

class RegisterDialog extends ConsumerStatefulWidget {
  final AppStateNotifier appStateNotifier;

  const RegisterDialog({
    super.key,
    required this.appStateNotifier,
  });

  @override
  ConsumerState<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends ConsumerState<RegisterDialog>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _studentIdController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _studentIdController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);
    
    return Dialog(
      backgroundColor: Colors.transparent,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 500,
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                child: HProfessionalCard(
                  margin: EdgeInsets.all(HTokens.lg),
                  backgroundColor: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                        // Header
                        Container(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.person_add_rounded,
                                    color: HTokens.primary,
                                    size: 28,
                                  ),
                                  SizedBox(width: HTokens.sm),
                                  Expanded(
                                    child: Text(
                                      'Create Account',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: HTokens.primary,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: Icon(
                                      Icons.close_rounded,
                                      color: HTokens.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: HTokens.sm),
                              Text(
                                'Join HostelConnect to manage your hostel life',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: HTokens.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: HTokens.lg),
                        
                        // Form Content
                        Container(
                          padding: const EdgeInsets.all(24),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // Student ID
                                HProfessionalInput(
                                  label: 'Student ID',
                                  hint: 'Enter your student ID',
                                  controller: _studentIdController,
                                  prefixIcon: Icons.badge_outlined,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your student ID';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: HTokens.md),
                                
                                // Name Fields
                                Column(
                                  children: [
                                    HProfessionalInput(
                                      label: 'First Name',
                                      hint: 'Enter first name',
                                      controller: _firstNameController,
                                      prefixIcon: Icons.person_outline,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: HTokens.md),
                                    HProfessionalInput(
                                      label: 'Last Name',
                                      hint: 'Enter last name',
                                      controller: _lastNameController,
                                      prefixIcon: Icons.person_outline,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: HTokens.md),
                                
                                // Email
                                HProfessionalInput(
                                  label: 'Email Address',
                                  hint: 'Enter your email',
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon: Icons.email_outlined,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value)) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: HTokens.md),
                                
                                // Phone
                                HProfessionalInput(
                                  label: 'Phone Number',
                                  hint: 'Enter your phone number',
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  prefixIcon: Icons.phone_outlined,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your phone number';
                                    }
                                    if (value.length < 10) {
                                      return 'Please enter a valid phone number';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: HTokens.md),
                                
                                // Password
                                HProfessionalInput(
                                  label: 'Password',
                                  hint: 'Enter your password',
                                  controller: _passwordController,
                                  obscureText: true,
                                  prefixIcon: Icons.lock_outline,
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
                                SizedBox(height: HTokens.md),
                                
                                // Confirm Password
                                HProfessionalInput(
                                  label: 'Confirm Password',
                                  hint: 'Confirm your password',
                                  controller: _confirmPasswordController,
                                  obscureText: true,
                                  prefixIcon: Icons.lock_outline,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please confirm your password';
                                    }
                                    if (value != _passwordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        SizedBox(height: HTokens.xl),
                        
                        // Action Buttons
                        Container(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: HProfessionalButton(
                                      text: 'Cancel',
                                      variant: HProfessionalButtonVariant.outline,
                                      onPressed: () => Navigator.pop(context),
                                      size: HProfessionalButtonSize.lg,
                                    ),
                                  ),
                                  SizedBox(width: HTokens.md),
                                  Expanded(
                                    child: HProfessionalButton(
                                      text: 'Create Account',
                                      onPressed: appState.isLoading ? null : _handleRegister,
                                      isLoading: appState.isLoading,
                                      size: HProfessionalButtonSize.lg,
                                      icon: Icons.person_add_rounded,
                                    ),
                                  ),
                                ],
                              ),
                              
                              // Error Message
                              if (appState.error != null) ...[
                                SizedBox(height: HTokens.md),
                                Container(
                                  padding: EdgeInsets.all(HTokens.md),
                                  decoration: BoxDecoration(
                                    color: HTokens.error.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(HTokens.cardRadius),
                                    border: Border.all(
                                      color: HTokens.error.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.error_outline,
                                        color: HTokens.error,
                                        size: 20,
                                      ),
                                      SizedBox(width: HTokens.sm),
                                      Expanded(
                                        child: Text(
                                          appState.error!,
                                          style: TextStyle(
                                            color: HTokens.error,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
          );
        },
      ),
    );
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState?.validate() ?? false) {
      await widget.appStateNotifier.register(
        studentId: _studentIdController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        password: _passwordController.text,
        roomId: '550e8400-e29b-41d4-a716-446655440000', // Default room assignment
        hostelId: '550e8400-e29b-41d4-a716-446655440001', // Default hostel assignment
      );

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }
}