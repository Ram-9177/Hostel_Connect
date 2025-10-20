import 'package:flutter/material.dart';
import 'package:hostelconnect/core/responsive.dart';
import 'package:hostelconnect/features/meals/presentation/widgets/meals_one_sheet.dart';
import 'package:hostelconnect/shared/theme/telugu_theme.dart';

class MealsPage extends StatefulWidget {
  const MealsPage({super.key});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  final Map<String, bool> mealIntents = {
    'breakfast': true,
    'lunch': true,
    'dinner': false,
  };

  void _onMealToggle(String meal, bool value) {
    setState(() {
      mealIntents[meal] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      return Scaffold(
        appBar: AppBar(
          title: Text(HTeluguTheme.getTeluguEnglishText('meal_management', 'Meal Management')),
          backgroundColor: HTeluguTheme.primary,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(HTokens.md),
          child: MealsOneSheet(
            date: DateTime.now(),
            mealIntents: mealIntents,
            onMealToggle: _onMealToggle,
          ),
        ),
      );
    });
  }
}
