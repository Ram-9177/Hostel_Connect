import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/meal_service.dart';
import '../../../../core/models/meal_models.dart';
import '../../../../core/utils/csv_exporter.dart';

class KitchenDashboardPage extends ConsumerStatefulWidget {
  const KitchenDashboardPage({super.key});

  @override
  ConsumerState<KitchenDashboardPage> createState() => _KitchenDashboardPageState();
}

class _KitchenDashboardPageState extends ConsumerState<KitchenDashboardPage> {
  bool _exporting = false;

  @override
  Widget build(BuildContext context) {
    final forecasts = ref.watch(todayMealForecastsProvider('hostel_1'));
    final overrides = ref.watch(todayMealOverridesProvider('hostel_1'));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitchen Dashboard'),
        actions: [
          IconButton(
            onPressed: _exporting ? null : _exportTodayCsv,
            icon: const Icon(Icons.download),
            tooltip: 'Export Today CSV',
          ),
          IconButton(
            onPressed: _exporting ? null : _exportMonthCsv,
            icon: const Icon(Icons.table_view),
            tooltip: 'Export Monthly CSV',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCountCards(forecasts.data ?? []),
          const SizedBox(height: 16),
          _buildTodayList(forecasts.data ?? [], overrides.data ?? []),
          const SizedBox(height: 16),
          _buildMonthlyReportTeaser(),
        ],
      ),
    );
  }

  Widget _buildCountCards(List<MealForecast> forecasts) {
    int lunch = forecasts.where((f) => f.mealType == MealType.lunch).fold(0, (p, f) => p + f.finalCount);
    int dinner = forecasts.where((f) => f.mealType == MealType.dinner).fold(0, (p, f) => p + f.finalCount);
    return Row(
      children: [
        Expanded(child: _StatCard(title: 'Lunch Today', value: lunch.toString(), icon: Icons.lunch_dining)),
        const SizedBox(width: 12),
        Expanded(child: _StatCard(title: 'Dinner Today', value: dinner.toString(), icon: Icons.dinner_dining)),
      ],
    );
  }

  Widget _buildTodayList(List<MealForecast> forecasts, List<MealOverride> overrides) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Today Breakdown', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...forecasts.map((f) => ListTile(
              leading: Text(f.mealType.emoji, style: const TextStyle(fontSize: 18)),
              title: Text(f.mealType.displayName),
              subtitle: Text('Final: ${f.finalCount}  • Overrides: ${f.overrideCount}'),
              trailing: Text('${f.attendancePercentage.toStringAsFixed(1)}%'),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyReportTeaser() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.calendar_month),
        title: const Text('Monthly Reports'),
        subtitle: const Text('Download daily meal counts and wastage analysis'),
        trailing: ElevatedButton.icon(
          onPressed: _exporting ? null : _exportMonthCsv,
          icon: const Icon(Icons.download),
          label: const Text('Download'),
        ),
      ),
    );
  }

  Future<void> _exportTodayCsv() async {
    setState(() => _exporting = true);
    try {
      final forecasts = ref.read(todayMealForecastsProvider('hostel_1')).data ?? [];
      final rows = [
        ['Meal', 'Final Count', 'Override Count', 'Attendance %'],
        ...forecasts.map((f) => [f.mealType.displayName, f.finalCount, f.overrideCount, f.attendancePercentage]),
      ];
      await CsvExporter.saveCsv('kitchen_today.csv', rows);
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  Future<void> _exportMonthCsv() async {
    setState(() => _exporting = true);
    try {
      final now = DateTime.now();
      final days = List.generate(now.day, (i) => DateTime(now.year, now.month, i + 1));
      final rows = <List<dynamic>>[];
      rows.add(['Date', 'Meal', 'Final Count']);
      for (final day in days) {
        // Placeholder aggregation; replace with API for month
        final forecasts = ref.read(todayMealForecastsProvider('hostel_1')).data ?? [];
        for (final f in forecasts) {
          rows.add([day.toIso8601String().substring(0, 10), f.mealType.displayName, f.finalCount]);
        }
      }
      await CsvExporter.saveCsv('kitchen_month_${now.month}.csv', rows);
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.grey)),
                  Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


