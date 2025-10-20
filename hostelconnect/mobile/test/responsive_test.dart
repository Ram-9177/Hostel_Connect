// test/responsive_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hostelconnect_mobile/core/responsive.dart';
import 'package:hostelconnect_mobile/shared/widgets/responsive_page.dart';
import 'package:hostelconnect_mobile/features/dashboards/presentation/widgets/dash_tile.dart';

void main() {
  group('Responsive Layout Tests', () {
    testWidgets('Dashboard - xs layout (320px)', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(320, 2000);
      tester.binding.window.devicePixelRatioTestValue = 2.0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HResponsive.builder(
              builder: (context, r) => HDashGrid(
                tiles: [
                  DashTile(
                    title: 'Total Students',
                    value: '120',
                    updatedAt: '14:30',
                  ),
                  DashTile(
                    title: 'Present Today',
                    value: '115',
                    updatedAt: '14:30',
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(HDashGrid),
        matchesGoldenFile('goldens/dashboard_xs.png'),
      );
    });

    testWidgets('Dashboard - sm layout (360px)', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(360, 2000);
      tester.binding.window.devicePixelRatioTestValue = 2.0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HResponsive.builder(
              builder: (context, r) => HDashGrid(
                tiles: [
                  DashTile(
                    title: 'Total Students',
                    value: '120',
                    updatedAt: '14:30',
                  ),
                  DashTile(
                    title: 'Present Today',
                    value: '115',
                    updatedAt: '14:30',
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(HDashGrid),
        matchesGoldenFile('goldens/dashboard_sm.png'),
      );
    });

    testWidgets('Dashboard - md layout (480px)', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(480, 2000);
      tester.binding.window.devicePixelRatioTestValue = 2.0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HResponsive.builder(
              builder: (context, r) => HDashGrid(
                tiles: [
                  DashTile(
                    title: 'Total Students',
                    value: '120',
                    updatedAt: '14:30',
                  ),
                  DashTile(
                    title: 'Present Today',
                    value: '115',
                    updatedAt: '14:30',
                  ),
                  DashTile(
                    title: 'Gate Passes',
                    value: '25',
                    updatedAt: '14:30',
                  ),
                  DashTile(
                    title: 'Meals Served',
                    value: '450',
                    updatedAt: '14:30',
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(HDashGrid),
        matchesGoldenFile('goldens/dashboard_md.png'),
      );
    });

    testWidgets('Dashboard - lg layout (840px)', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(840, 2000);
      tester.binding.window.devicePixelRatioTestValue = 2.0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HResponsive.builder(
              builder: (context, r) => HDashGrid(
                tiles: [
                  DashTile(
                    title: 'Total Students',
                    value: '120',
                    updatedAt: '14:30',
                  ),
                  DashTile(
                    title: 'Present Today',
                    value: '115',
                    updatedAt: '14:30',
                  ),
                  DashTile(
                    title: 'Gate Passes',
                    value: '25',
                    updatedAt: '14:30',
                  ),
                  DashTile(
                    title: 'Meals Served',
                    value: '450',
                    updatedAt: '14:30',
                  ),
                  DashTile(
                    title: 'Room Occupancy',
                    value: '95%',
                    updatedAt: '14:30',
                  ),
                  DashTile(
                    title: 'Attendance Rate',
                    value: '96%',
                    updatedAt: '14:30',
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(HDashGrid),
        matchesGoldenFile('goldens/dashboard_lg.png'),
      );
    });

    testWidgets('Dashboard - xl layout (1200px)', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1200, 2000);
      tester.binding.window.devicePixelRatioTestValue = 2.0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HResponsive.builder(
              builder: (context, r) => HDashGrid(
                tiles: [
                  DashTile(
                    title: 'Total Students',
                    value: '120',
                    updatedAt: '14:30',
                  ),
                  DashTile(
                    title: 'Present Today',
                    value: '115',
                    updatedAt: '14:30',
                  ),
                  DashTile(
                    title: 'Gate Passes',
                    value: '25',
                    updatedAt: '14:30',
                  ),
                  DashTile(
                    title: 'Meals Served',
                    value: '450',
                    updatedAt: '14:30',
                  ),
                  DashTile(
                    title: 'Room Occupancy',
                    value: '95%',
                    updatedAt: '14:30',
                  ),
                  DashTile(
                    title: 'Attendance Rate',
                    value: '96%',
                    updatedAt: '14:30',
                  ),
                  DashTile(
                    title: 'Active Sessions',
                    value: '3',
                    updatedAt: '14:30',
                  ),
                  DashTile(
                    title: 'Pending Approvals',
                    value: '7',
                    updatedAt: '14:30',
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(HDashGrid),
        matchesGoldenFile('goldens/dashboard_xl.png'),
      );
    });

    testWidgets('Navigation - BottomNav on phones', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(360, 800);
      tester.binding.window.devicePixelRatioTestValue = 2.0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(),
            bottomNavigationBar: HBottomNav(
              currentIndex: 0,
              onTap: (index) {},
              items: [
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

      await expectLater(
        find.byType(HBottomNav),
        matchesGoldenFile('goldens/navigation_bottom.png'),
      );
    });

    testWidgets('Navigation - NavRail on tablets', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(840, 1200);
      tester.binding.window.devicePixelRatioTestValue = 2.0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                HNavRail(
                  currentIndex: 0,
                  onTap: (index) {},
                  items: [
                    HNavItem(icon: Icons.home, label: 'Home'),
                    HNavItem(icon: Icons.qr_code_scanner, label: 'Scan'),
                    HNavItem(icon: Icons.restaurant, label: 'Meals'),
                    HNavItem(icon: Icons.logout, label: 'Gate Pass'),
                    HNavItem(icon: Icons.person, label: 'Profile'),
                  ],
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(HNavRail),
        matchesGoldenFile('goldens/navigation_rail.png'),
      );
    });
  });
}
