// lib/features/ads/presentation/widgets/interstitial_ad.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/responsive.dart';
import '../../../../shared/theme/telugu_theme.dart';

class InterstitialAdView extends StatefulWidget {
  final int duration; // 20 seconds
  final VoidCallback onComplete;
  final VoidCallback? onSkip;
  final String? adTitle;
  final String? adDescription;

  const InterstitialAdView({
    super.key,
    required this.duration,
    required this.onComplete,
    this.onSkip,
    this.adTitle,
    this.adDescription,
  });

  @override
  State<InterstitialAdView> createState() => _InterstitialAdViewState();
}

class _InterstitialAdViewState extends State<InterstitialAdView>
    with TickerProviderStateMixin {
  late AnimationController _countdownController;
  late AnimationController _pulseController;
  int _remainingSeconds = 0;
  bool _canSkip = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.duration;
    
    _countdownController = AnimationController(
      duration: Duration(seconds: widget.duration),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _startCountdown();
  }

  @override
  void dispose() {
    _countdownController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    _countdownController.forward();
    
    // Update remaining seconds
    _countdownController.addListener(() {
      final remaining = widget.duration - (_countdownController.value * widget.duration).round();
      if (remaining != _remainingSeconds) {
        setState(() {
          _remainingSeconds = remaining;
          _canSkip = remaining <= 5; // Allow skip in last 5 seconds
        });
      }
    });

    // Complete when countdown finishes
    _countdownController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      final maxW = r.size == HSize.xl ? 800.0 : r.width * 0.9;
      final maxH = r.size == HSize.xl ? 600.0 : r.height * 0.8;

      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxW,
              maxHeight: maxH,
            ),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  // Ad content area
                  _buildAdContent(r),
                  
                  // Countdown badge
                  Positioned(
                    top: HTokens.md,
                    right: HTokens.md,
                    child: _CountdownBadge(
                      seconds: _remainingSeconds,
                      onDone: widget.onComplete,
                      canSkip: _canSkip,
                      onSkip: widget.onSkip,
                    ),
                  ),
                  
                  // Skip button (only in last 5 seconds)
                  if (_canSkip && widget.onSkip != null)
                    Positioned(
                      bottom: HTokens.md,
                      right: HTokens.md,
                      child: _SkipButton(onSkip: widget.onSkip!),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildAdContent(HResponsive r) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(HTokens.cardRadius),
      ),
      child: Stack(
        children: [
          // Video/image placeholder
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.play_circle_outline,
                  size: HSpacing.responsive(r,
                    xs: 80,
                    sm: 100,
                    md: 120,
                    lg: 140,
                    xl: 160,
                  ),
                  color: Colors.white,
                ),
                SizedBox(height: HTokens.lg),
                if (widget.adTitle != null)
                  Text(
                    widget.adTitle!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: HFontSize.responsive(r, base: 24),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                SizedBox(height: HTokens.sm),
                if (widget.adDescription != null)
                  Text(
                    widget.adDescription!,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: HFontSize.responsive(r, base: 16),
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
          
          // Progress indicator
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(
              value: 1.0 - (_countdownController.value),
              backgroundColor: Colors.white24,
              valueColor: AlwaysStoppedAnimation<Color>(HTokens.primary),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }
}

class _CountdownBadge extends StatelessWidget {
  final int seconds;
  final VoidCallback onDone;
  final bool canSkip;
  final VoidCallback? onSkip;

  const _CountdownBadge({
    required this.seconds,
    required this.onDone,
    required this.canSkip,
    this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: HTokens.md,
          vertical: HTokens.sm,
        ),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.timer,
              color: Colors.white,
              size: HFontSize.responsive(r, base: 16),
            ),
            SizedBox(width: HTokens.xs),
            Text(
              '$seconds',
              style: TextStyle(
                color: Colors.white,
                fontSize: HFontSize.responsive(r, base: 16),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _SkipButton extends StatelessWidget {
  final VoidCallback onSkip;

  const _SkipButton({required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      return ElevatedButton(
        onPressed: onSkip,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white24,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: HTokens.lg,
            vertical: HTokens.md,
          ),
          minimumSize: Size(44, 44), // Accessibility
        ),
        child: Text(
          'Skip',
          style: TextStyle(
            fontSize: HFontSize.responsive(r, base: 14),
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    });
  }
}

// Banner ad widget
class HBannerAd extends StatelessWidget {
  final String title;
  final String? description;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;

  const HBannerAd({
    super.key,
    required this.title,
    this.description,
    this.onTap,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      final height = HSpacing.responsive(r,
        xs: 56,
        sm: 60,
        md: 64,
        lg: 68,
        xl: 72,
      );

      return Container(
        height: height,
        margin: EdgeInsets.symmetric(horizontal: HTokens.sm),
        decoration: BoxDecoration(
          color: HTokens.surface,
          borderRadius: BorderRadius.circular(HTokens.cardRadius),
          boxShadow: HTokens.cardShadow,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(HTokens.cardRadius),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: HTokens.md),
              child: Row(
                children: [
                  Icon(
                    Icons.ads_click,
                    color: HTokens.primary,
                    size: HFontSize.responsive(r, base: 20),
                  ),
                  SizedBox(width: HTokens.sm),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: HFontSize.responsive(r, base: 14),
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (description != null)
                          Text(
                            description!,
                            style: TextStyle(
                              fontSize: HFontSize.responsive(r, base: 12),
                              color: HTokens.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                  if (onDismiss != null)
                    IconButton(
                      onPressed: onDismiss,
                      icon: Icon(Icons.close),
                      iconSize: HFontSize.responsive(r, base: 18),
                      constraints: BoxConstraints(minWidth: 44, minHeight: 44),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
