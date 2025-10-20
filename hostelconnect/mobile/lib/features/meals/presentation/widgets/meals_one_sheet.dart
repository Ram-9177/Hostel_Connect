// lib/features/meals/presentation/widgets/meals_one_sheet.dart
import 'package:flutter/material.dart';
import '../../../../core/responsive.dart';
import '../../../../shared/theme/telugu_theme.dart';

class MealsOneSheet extends StatefulWidget {
  final DateTime date;
  final Map<String, bool> mealIntents;
  final Function(String, bool) onMealToggle;
  final VoidCallback? onAllYes;
  final VoidCallback? onAllNo;
  final VoidCallback? onSameAsYesterday;

  const MealsOneSheet({
    super.key,
    required this.date,
    required this.mealIntents,
    required this.onMealToggle,
    this.onAllYes,
    this.onAllNo,
    this.onSameAsYesterday,
  });

  @override
  State<MealsOneSheet> createState() => _MealsOneSheetState();
}

class _MealsOneSheetState extends State<MealsOneSheet> {
  final List<MealOption> _meals = [
    MealOption('Breakfast', '07:00 - 09:00', Icons.wb_sunny),
    MealOption('Lunch', '12:00 - 14:00', Icons.wb_sunny_outlined),
    MealOption('Snacks', '16:00 - 17:00', Icons.local_cafe),
    MealOption('Dinner', '19:00 - 21:00', Icons.nights_stay),
  ];

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      final isWide = r.size.index >= HSize.lg.index;
      
      return Container(
        padding: EdgeInsets.all(HSpacing.responsive(r,
          xs: HTokens.md,
          sm: HTokens.lg,
          md: HTokens.lg,
          lg: HTokens.xl,
          xl: HTokens.xl,
        )),
        decoration: BoxDecoration(
          color: HTokens.surface,
          borderRadius: BorderRadius.circular(HTokens.sheetRadius),
          boxShadow: HTokens.sheetShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(r),
            SizedBox(height: HTokens.lg),
            _buildQuickActions(r),
            SizedBox(height: HTokens.lg),
            if (isWide) _buildWideLayout(r) else _buildNarrowLayout(r),
          ],
        ),
      );
    });
  }

  Widget _buildHeader(HResponsive r) {
    return Row(
      children: [
        Icon(
          Icons.restaurant,
          color: HTokens.primary,
          size: HFontSize.responsive(r, base: 24),
        ),
        SizedBox(width: HTokens.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Meal Intent - ${_formatDate(widget.date)}',
                style: TextStyle(
                  fontSize: HFontSize.responsive(r, base: 20),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Set your meal preferences for tomorrow',
                style: TextStyle(
                  fontSize: HFontSize.responsive(r, base: 14),
                  color: HTokens.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(HResponsive r) {
    return Wrap(
      spacing: HTokens.sm,
      runSpacing: HTokens.sm,
      children: [
        _QuickActionChip(
          label: 'All Yes',
          icon: Icons.check_circle,
          onTap: widget.onAllYes,
        ),
        _QuickActionChip(
          label: 'All No',
          icon: Icons.cancel,
          onTap: widget.onAllNo,
        ),
        _QuickActionChip(
          label: 'Same as Yesterday',
          icon: Icons.history,
          onTap: widget.onSameAsYesterday,
        ),
      ],
    );
  }

  Widget _buildWideLayout(HResponsive r) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Meals grid (left side)
        Expanded(
          flex: 2,
          child: _buildMealsGrid(r),
        ),
        SizedBox(width: HTokens.xl),
        // Diet preferences panel (right side)
        Expanded(
          flex: 1,
          child: _buildDietPanel(r),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout(HResponsive r) {
    return Column(
      children: [
        _buildMealsGrid(r),
        SizedBox(height: HTokens.lg),
        _buildDietPanel(r),
      ],
    );
  }

  Widget _buildMealsGrid(HResponsive r) {
    final columns = r.size == HSize.md ? 2 : 1;
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: HTokens.md,
        mainAxisSpacing: HTokens.md,
        childAspectRatio: columns == 2 ? 3 : 4,
      ),
      itemCount: _meals.length,
      itemBuilder: (context, index) {
        final meal = _meals[index];
        final isSelected = widget.mealIntents[meal.name.toLowerCase()] ?? false;
        
        return _MealToggleCard(
          meal: meal,
          isSelected: isSelected,
          onToggle: (value) => widget.onMealToggle(meal.name.toLowerCase(), value),
        );
      },
    );
  }

  Widget _buildDietPanel(HResponsive r) {
    return Container(
      padding: EdgeInsets.all(HTokens.lg),
      decoration: BoxDecoration(
        color: HTokens.background,
        borderRadius: BorderRadius.circular(HTokens.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Diet Preferences',
            style: TextStyle(
              fontSize: HFontSize.responsive(r, base: 16),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: HTokens.md),
          _DietChip(label: 'Vegetarian', isSelected: true),
          SizedBox(height: HTokens.sm),
          _DietChip(label: 'Non-Vegetarian', isSelected: false),
          SizedBox(height: HTokens.sm),
          _DietChip(label: 'Jain', isSelected: false),
          SizedBox(height: HTokens.sm),
          _DietChip(label: 'Vegan', isSelected: false),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class MealOption {
  final String name;
  final String time;
  final IconData icon;

  const MealOption(this.name, this.time, this.icon);
}

class _MealToggleCard extends StatelessWidget {
  final MealOption meal;
  final bool isSelected;
  final Function(bool) onToggle;

  const _MealToggleCard({
    required this.meal,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      return Material(
        color: isSelected ? HTokens.primary.withOpacity(0.1) : HTokens.surface,
        borderRadius: BorderRadius.circular(HTokens.cardRadius),
        child: InkWell(
          onTap: () => onToggle(!isSelected),
          borderRadius: BorderRadius.circular(HTokens.cardRadius),
          child: Container(
            padding: EdgeInsets.all(HSpacing.responsive(r,
              xs: HTokens.sm,
              sm: HTokens.md,
              md: HTokens.md,
              lg: HTokens.lg,
              xl: HTokens.lg,
            )),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(HTokens.cardRadius),
              border: Border.all(
                color: isSelected ? HTokens.primary : Colors.grey[300]!,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  meal.icon,
                  color: isSelected ? HTokens.primary : HTokens.onSurfaceVariant,
                  size: HFontSize.responsive(r, base: 24),
                ),
                SizedBox(height: HTokens.xs),
                Text(
                  meal.name,
                  style: TextStyle(
                    fontSize: HFontSize.responsive(r, base: 14),
                    fontWeight: FontWeight.w600,
                    color: isSelected ? HTokens.primary : HTokens.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: HTokens.xs),
                Text(
                  meal.time,
                  style: TextStyle(
                    fontSize: HFontSize.responsive(r, base: 12),
                    color: HTokens.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: HTokens.xs),
                Icon(
                  isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: isSelected ? HTokens.primary : Colors.grey[400],
                  size: HFontSize.responsive(r, base: 20),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _QuickActionChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const _QuickActionChip({
    required this.label,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      return ActionChip(
        onPressed: onTap,
        avatar: Icon(icon, size: HFontSize.responsive(r, base: 16)),
        label: Text(
          label,
          style: TextStyle(fontSize: HFontSize.responsive(r, base: 14)),
        ),
        backgroundColor: HTokens.primary.withOpacity(0.1),
        labelStyle: TextStyle(color: HTokens.primary),
      );
    });
  }
}

class _DietChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _DietChip({
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      return FilterChip(
        label: Text(
          label,
          style: TextStyle(fontSize: HFontSize.responsive(r, base: 12)),
        ),
        selected: isSelected,
        onSelected: (selected) {
          // Handle diet preference change
        },
        selectedColor: HTokens.primary.withOpacity(0.2),
        checkmarkColor: HTokens.primary,
      );
    });
  }
}
