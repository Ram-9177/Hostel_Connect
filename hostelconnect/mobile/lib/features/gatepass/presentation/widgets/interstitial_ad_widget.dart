// lib/features/gatepass/presentation/widgets/interstitial_ad_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/gatepass_models.dart';
import '../../../../core/providers/gatepass_providers.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';

class InterstitialAdWidget extends ConsumerStatefulWidget {
  final String gatePassId;
  final VoidCallback? onAdCompleted;
  final VoidCallback? onEmergencyBypass;
  final bool allowEmergencyBypass;

  const InterstitialAdWidget({
    super.key,
    required this.gatePassId,
    this.onAdCompleted,
    this.onEmergencyBypass,
    this.allowEmergencyBypass = true,
  });

  @override
  ConsumerState<InterstitialAdWidget> createState() => _InterstitialAdWidgetState();
}

class _InterstitialAdWidgetState extends ConsumerState<InterstitialAdWidget>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _pulseController;
  late Animation<double> _progressAnimation;
  late Animation<double> _pulseAnimation;
  
  int _remainingSeconds = 20;
  bool _isAdPlaying = false;
  bool _isAdCompleted = false;
  bool _isEmergencyBypass = false;
  String? _emergencyReason;
  
  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAd();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _progressController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.linear,
    ));
    
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    _pulseController.repeat(reverse: true);
  }

  Future<void> _startAd() async {
    setState(() {
      _isAdPlaying = true;
      _remainingSeconds = 20;
    });

    // Start progress animation
    _progressController.forward();
    
    // Start countdown timer
    _startCountdown();
    
    // Start ad integration
    try {
      final adIntegration = ref.read(adIntegrationProvider(widget.gatePassId).notifier);
      await adIntegration.startAd('interstitial');
    } catch (e) {
      // Handle ad start error
      Toast.showError(context, 'Failed to start ad: $e');
    }
  }

  void _startCountdown() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted && _isAdPlaying && !_isAdCompleted && !_isEmergencyBypass) {
        setState(() {
          _remainingSeconds--;
        });
        
        if (_remainingSeconds <= 0) {
          await _completeAd();
          return false;
        }
        return true;
      }
      return false;
    });
  }

  Future<void> _completeAd() async {
    setState(() {
      _isAdCompleted = true;
      _isAdPlaying = false;
    });

    _progressController.stop();
    _pulseController.stop();

    try {
      final adIntegration = ref.read(adIntegrationProvider(widget.gatePassId).notifier);
      await adIntegration.completeAd('ad_${widget.gatePassId}');
      
      Toast.showSuccess(context, 'Ad completed! QR code is now available.');
      widget.onAdCompleted?.call();
    } catch (e) {
      Toast.showError(context, 'Failed to complete ad: $e');
    }
  }

  Future<void> _emergencyBypass() async {
    if (!widget.allowEmergencyBypass) {
      Toast.showError(context, 'Emergency bypass is not allowed for this gate pass.');
      return;
    }

    final reason = await _showEmergencyBypassDialog();
    if (reason == null) return;

    setState(() {
      _isEmergencyBypass = true;
      _isAdPlaying = false;
      _emergencyReason = reason;
    });

    _progressController.stop();
    _pulseController.stop();

    try {
      final emergencyRequest = EmergencyBypassRequest(
        gatePassId: widget.gatePassId,
        reason: reason,
        bypassedBy: 'warden', // TODO: Get from auth context
        bypassedByName: 'Warden', // TODO: Get from auth context
        bypassedAt: DateTime.now(),
        notes: 'Emergency bypass used during ad display',
      );

      final gatepassService = ref.read(gatepassServiceProvider);
      final result = await gatepassService.emergencyBypassAd(emergencyRequest);

      if (result.state == LoadState.success) {
        Toast.showWarning(context, 'Emergency bypass logged. QR code is now available.');
        widget.onEmergencyBypass?.call();
      } else {
        Toast.showError(context, result.error ?? 'Failed to process emergency bypass');
      }
    } catch (e) {
      Toast.showError(context, 'Error processing emergency bypass: $e');
    }
  }

  Future<String?> _showEmergencyBypassDialog() async {
    final reasonController = TextEditingController();
    
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Emergency Bypass'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'This action will be logged and requires a valid emergency reason.',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Emergency Reason',
                hintText: 'Enter the emergency reason',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (reasonController.text.trim().isNotEmpty) {
                Navigator.pop(context, reasonController.text.trim());
              } else {
                Toast.showError(context, 'Please enter an emergency reason');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: IOSGradeTheme.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Bypass'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      'Advertisement',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (widget.allowEmergencyBypass && !_isAdCompleted && !_isEmergencyBypass)
                    IconButton(
                      icon: const Icon(Icons.warning, color: Colors.red),
                      onPressed: _emergencyBypass,
                      tooltip: 'Emergency Bypass',
                    ),
                ],
              ),
            ),
            
            // Ad Content Area
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[700]!),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Ad Placeholder
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedBuilder(
                              animation: _pulseAnimation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _pulseAnimation.value,
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: IOSGradeTheme.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(60),
                                      border: Border.all(
                                        color: IOSGradeTheme.primary,
                                        width: 2,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.play_circle_filled,
                                      color: IOSGradeTheme.primary,
                                      size: 60,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 24),
                            Text(
                              _isAdCompleted 
                                  ? 'Ad Completed Successfully!'
                                  : _isEmergencyBypass
                                      ? 'Emergency Bypass Used'
                                      : 'Advertisement Playing',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _isAdCompleted
                                  ? 'You can now access your QR code'
                                  : _isEmergencyBypass
                                      ? 'Reason: $_emergencyReason'
                                      : 'Please wait for the ad to complete',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Progress Bar
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          AnimatedBuilder(
                            animation: _progressAnimation,
                            builder: (context, child) {
                              return LinearProgressIndicator(
                                value: _progressAnimation.value,
                                backgroundColor: Colors.grey[700],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  _isAdCompleted 
                                      ? IOSGradeTheme.success
                                      : _isEmergencyBypass
                                          ? IOSGradeTheme.warning
                                          : IOSGradeTheme.primary,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _isAdCompleted
                                ? 'Ad completed!'
                                : _isEmergencyBypass
                                    ? 'Emergency bypass used'
                                    : 'Time remaining: $_remainingSeconds seconds',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Action Buttons
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (_isAdCompleted || _isEmergencyBypass) ...[
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.check),
                        label: const Text('Continue to QR Code'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: IOSGradeTheme.success,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close),
                            label: const Text('Cancel'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[700],
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        if (widget.allowEmergencyBypass)
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _emergencyBypass,
                              icon: const Icon(Icons.warning),
                              label: const Text('Emergency'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: IOSGradeTheme.error,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    _isAdCompleted
                        ? 'Thank you for watching the advertisement'
                        : _isEmergencyBypass
                            ? 'Emergency bypass has been logged for audit purposes'
                            : 'Advertisement must complete before QR code access',
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Ad Completion Check Widget
class AdCompletionCheckWidget extends ConsumerWidget {
  final String gatePassId;
  final Widget child;
  final Widget? blockedWidget;

  const AdCompletionCheckWidget({
    super.key,
    required this.gatePassId,
    required this.child,
    this.blockedWidget,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adIntegration = ref.watch(adIntegrationProvider(gatePassId));

    if (adIntegration.state == LoadState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (adIntegration.state == LoadState.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: IOSGradeTheme.error,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to check ad status',
              style: IOSGradeTheme.titleLarge.copyWith(
                color: IOSGradeTheme.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              adIntegration.error ?? 'Unknown error',
              style: IOSGradeTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(adIntegrationProvider(gatePassId));
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final adData = adIntegration.data;
    final isAdCompleted = adData?.isCompleted ?? false;

    if (isAdCompleted) {
      return child;
    } else {
      return blockedWidget ?? _buildBlockedWidget(context);
    }
  }

  Widget _buildBlockedWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline,
              color: IOSGradeTheme.warning,
              size: 80,
            ),
            const SizedBox(height: 24),
            Text(
              'Advertisement Required',
              style: IOSGradeTheme.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'You must watch a 20-second advertisement before accessing your QR code.',
              style: IOSGradeTheme.bodyLarge.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InterstitialAdWidget(
                      gatePassId: gatePassId,
                      onAdCompleted: () {
                        Navigator.pop(context);
                        // Refresh the ad integration state
                        ref.invalidate(adIntegrationProvider(gatePassId));
                      },
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.play_circle_filled),
              label: const Text('Watch Advertisement'),
              style: ElevatedButton.styleFrom(
                backgroundColor: IOSGradeTheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'This helps support the hostel management system',
              style: IOSGradeTheme.bodySmall.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
