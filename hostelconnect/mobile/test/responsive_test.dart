// test/responsive_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hostelconnect/core/responsive.dart';
import 'package:hostelconnect/features/dashboards/presentation/widgets/dash_tile.dart';
import 'package:hostelconnect/shared/widgets/responsive_page.dart';

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() {
    binding.window.clearPhysicalSizeTestValue();
    binding.window.clearDevicePixelRatioTestValue();
  });

  group('Responsive layout breakpoints', () {
    testWidgets('HDashGrid adjusts column count based on width', (tester) async {
      Future<int> pumpGrid(double width) async {
        binding.window.devicePixelRatioTestValue = 1.0;
        binding.window.physicalSizeTestValue = Size(width, 1000);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: HResponsive.builder(
                builder: (context, r) => HDashGrid(
                  tiles: const [
                    DashTile(title: 'A', value: '1', updatedAt: 'now'),
                    DashTile(title: 'B', value: '2', updatedAt: 'now'),
                    DashTile(title: 'C', value: '3', updatedAt: 'now'),
                    DashTile(title: 'D', value: '4', updatedAt: 'now'),
                  ],
                ),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final grid = tester.widget<GridView>(find.byType(GridView));
        final delegate = grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
        return delegate.crossAxisCount;
      }

      expect(await pumpGrid(320), 1); // xs
      expect(await pumpGrid(720), 1); // sm
      expect(await pumpGrid(960), 2); // md
      expect(await pumpGrid(1300), 3); // lg
      expect(await pumpGrid(1600), 4); // xl
    });

    testWidgets('Navigation switches between bottom bar and rail', (tester) async {
      Future<Scaffold> pumpNav(double width) async {
        binding.window.devicePixelRatioTestValue = 1.0;
        binding.window.physicalSizeTestValue = Size(width, 900);

        await tester.pumpWidget(
          MaterialApp(
            home: HPage(
              body: const SizedBox.shrink(),
              bottomNavigation: HBottomNav(
                currentIndex: 0,
                onTap: (_) {},
                items: const [
                  HNavItem(icon: Icons.home, label: 'Home'),
                  HNavItem(icon: Icons.qr_code_scanner, label: 'Scan'),
                  HNavItem(icon: Icons.restaurant, label: 'Meals'),
                  HNavItem(icon: Icons.logout, label: 'Gate Pass'),
                  HNavItem(icon: Icons.person, label: 'Profile'),
                ],
              ),
              navigationRail: HNavRail(
                currentIndex: 0,
                onTap: (_) {},
                items: const [
                  HNavItem(icon: Icons.home, label: 'Home'),
                  HNavItem(icon: Icons.qr_code_scanner, label: 'Scan'),
                  HNavItem(icon: Icons.restaurant, label: 'Meals'),
                  HNavItem(icon: Icons.logout, label: 'Gate Pass'),
                  HNavItem(icon: Icons.person, label: 'Profile'),
                ],
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        return tester.widget<Scaffold>(find.byType(Scaffold).first);
      }

      final phoneScaffold = await pumpNav(360);
      expect(phoneScaffold.bottomNavigationBar, isNotNull);
      expect(find.byType(HNavRail), findsNothing);

      final desktopScaffold = await pumpNav(1400);
      expect(desktopScaffold.bottomNavigationBar, isNull);
      expect(find.byType(HNavRail), findsOneWidget);
    });
  });
}
