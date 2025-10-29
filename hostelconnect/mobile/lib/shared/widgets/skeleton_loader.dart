import 'package:flutter/material.dart';

/// Lightweight skeleton loader widgets for better UX
class SkeletonLoader extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const SkeletonLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
    );
  }
}

class SkeletonListTile extends StatelessWidget {
  final bool hasLeading;
  final bool hasSubtitle;

  const SkeletonListTile({
    super.key,
    this.hasLeading = true,
    this.hasSubtitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: hasLeading
          ? const SkeletonLoader(width: 48, height: 48, borderRadius: BorderRadius.all(Radius.circular(24)))
          : null,
      title: const SkeletonLoader(width: double.infinity, height: 16),
      subtitle: hasSubtitle
          ? const Padding(
              padding: EdgeInsets.only(top: 8),
              child: SkeletonLoader(width: double.infinity, height: 12),
            )
          : null,
    );
  }
}

class SkeletonCard extends StatelessWidget {
  final double height;

  const SkeletonCard({super.key, this.height = 120});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SkeletonLoader(width: double.infinity, height: 20),
            const SizedBox(height: 12),
            const SkeletonLoader(width: 150, height: 16),
            const SizedBox(height: 8),
            const SkeletonLoader(width: 100, height: 14),
          ],
        ),
      ),
    );
  }
}

/// Shimmer effect wrapper
class Shimmer extends StatefulWidget {
  final Widget child;
  final Duration period;

  const Shimmer({
    super.key,
    required this.child,
    this.period = const Duration(milliseconds: 1500),
  });

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.period,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: 0.5 + (_controller.value * 0.5),
          child: widget.child,
        );
      },
    );
  }
}

