import 'package:flutter/material.dart';
import '../../../core/responsive.dart';
import '../../theme/telugu_theme.dart';

class QuickAccessRow extends StatelessWidget {
  const QuickAccessRow({super.key});

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: HTokens.md,
          vertical: HTokens.sm,
        ),
        decoration: BoxDecoration(
          color: HTeluguTheme.primary.withOpacity(0.1),
          border: Border(
            bottom: BorderSide(
              color: HTeluguTheme.primary.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.flash_on,
              color: HTeluguTheme.primary,
              size: r.isXS ? 16 : 18,
            ),
            SizedBox(width: HTokens.sm),
            Text(
              'Quick Access',
              style: TextStyle(
                fontSize: r.isXS ? 14 : 16,
                fontWeight: FontWeight.w600,
                color: HTeluguTheme.primary,
              ),
            ),
            const Spacer(),
            Text(
              'Tap to navigate',
              style: TextStyle(
                fontSize: r.isXS ? 12 : 14,
                color: HTeluguTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    });
  }
}
