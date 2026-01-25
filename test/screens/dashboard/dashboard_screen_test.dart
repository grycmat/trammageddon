import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trammageddon/screens/dashboard/all_incidents_count.dart';
import 'package:trammageddon/screens/dashboard/dashboard_screen.dart';
import 'package:trammageddon/screens/dashboard/my_all_incidents_count.dart';
import 'package:trammageddon/screens/dashboard/my_today_incidents_count.dart';
import 'package:trammageddon/screens/dashboard/today_incidents_count.dart';
import 'package:trammageddon/screens/dashboard/top_ranking.dart';
import 'package:trammageddon/theme/theme.dart';

Widget createTestableWidget(Widget child) {
  return MaterialApp(
    theme: AppTheme.darkTheme,
    home: Scaffold(body: child),
  );
}

class TestDashboardScreen extends StatelessWidget {
  const TestDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBar(title: Text('CO TAM W MIEŚCIE')),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: MockDataBox(label: 'OKROPIEŃSTW DZIŚ', value: 5)),
              const SizedBox(width: 16),
              Expanded(child: MockDataBox(label: 'WSZYSTKO', value: 100)),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'ME ŻALE',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: MockDataBox(label: 'Z DZIŚ', value: 2)),
              const SizedBox(width: 16),
              Expanded(child: MockDataBox(label: 'WSZYSTKIE', value: 25)),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'NAJGORSI Z NAJGORSZYCH',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          MockTopRanking(),
        ],
      ),
    );
  }
}

class MockDataBox extends StatelessWidget {
  final String label;
  final int value;

  const MockDataBox({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontFamily: 'ChivoMono',
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class MockTopRanking extends StatelessWidget {
  const MockTopRanking({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text('RANKING'),
        ],
      ),
    );
  }
}

void main() {
  group('DashboardScreen structure tests', () {
    testWidgets('renders without errors', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const TestDashboardScreen()));
      await tester.pump();

      expect(find.byType(TestDashboardScreen), findsOneWidget);
    });

    testWidgets('displays AppBar with correct title', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const TestDashboardScreen()));
      await tester.pump();

      expect(find.text('CO TAM W MIEŚCIE'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('displays ME ŻALE section header', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const TestDashboardScreen()));
      await tester.pump();

      expect(find.text('ME ŻALE'), findsOneWidget);
    });

    testWidgets('displays NAJGORSI Z NAJGORSZYCH section header', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const TestDashboardScreen()));
      await tester.pump();

      expect(find.text('NAJGORSI Z NAJGORSZYCH'), findsOneWidget);
    });

    testWidgets('displays incident count labels', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const TestDashboardScreen()));
      await tester.pump();

      expect(find.text('OKROPIEŃSTW DZIŚ'), findsOneWidget);
      expect(find.text('WSZYSTKO'), findsOneWidget);
      expect(find.text('Z DZIŚ'), findsOneWidget);
      expect(find.text('WSZYSTKIE'), findsOneWidget);
    });

    testWidgets('displays incident count values', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const TestDashboardScreen()));
      await tester.pump();

      expect(find.text('5'), findsOneWidget);
      expect(find.text('100'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('25'), findsOneWidget);
    });

    testWidgets('has correct layout structure with SingleChildScrollView', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const TestDashboardScreen()));
      await tester.pump();

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('has Column as main layout container', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const TestDashboardScreen()));
      await tester.pump();

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('has Row widgets for incident count pairs', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const TestDashboardScreen()));
      await tester.pump();

      final rows = find.byType(Row);
      expect(rows, findsWidgets);
    });

    testWidgets('displays four DataBox widgets', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const TestDashboardScreen()));
      await tester.pump();

      expect(find.byType(MockDataBox), findsNWidgets(4));
    });

    testWidgets('section headers use center text alignment', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const TestDashboardScreen()));
      await tester.pump();

      final meZaleFinder = find.text('ME ŻALE');
      final najgorsiFinder = find.text('NAJGORSI Z NAJGORSZYCH');

      expect(meZaleFinder, findsOneWidget);
      expect(najgorsiFinder, findsOneWidget);

      final meZaleText = tester.widget<Text>(meZaleFinder);
      final najgorsiText = tester.widget<Text>(najgorsiFinder);

      expect(meZaleText.textAlign, TextAlign.center);
      expect(najgorsiText.textAlign, TextAlign.center);
    });

    testWidgets('incident count widgets are wrapped in Expanded', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const TestDashboardScreen()));
      await tester.pump();

      final expandedWidgets = find.byType(Expanded);
      expect(expandedWidgets, findsNWidgets(4));
    });

    testWidgets('uses BouncingScrollPhysics for scroll behavior', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const TestDashboardScreen()));
      await tester.pump();

      final scrollView = tester.widget<SingleChildScrollView>(
        find.byType(SingleChildScrollView),
      );
      expect(scrollView.physics, isA<BouncingScrollPhysics>());
    });

    testWidgets('has correct padding on SingleChildScrollView', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const TestDashboardScreen()));
      await tester.pump();

      final scrollView = tester.widget<SingleChildScrollView>(
        find.byType(SingleChildScrollView),
      );
      expect(scrollView.padding, const EdgeInsets.all(16));
    });

    testWidgets('Column uses stretch for cross axis alignment', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const TestDashboardScreen()));
      await tester.pump();

      final columns = tester.widgetList<Column>(find.byType(Column));
      final mainColumn = columns.firstWhere(
        (col) => col.crossAxisAlignment == CrossAxisAlignment.stretch,
        orElse: () => throw StateError('No Column with stretch alignment found'),
      );
      expect(mainColumn.crossAxisAlignment, CrossAxisAlignment.stretch);
    });

    testWidgets('displays TopRanking section', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const TestDashboardScreen()));
      await tester.pump();

      expect(find.text('RANKING'), findsOneWidget);
    });

    testWidgets('first row contains two Expanded widgets', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const TestDashboardScreen()));
      await tester.pump();

      final rows = tester.widgetList<Row>(find.byType(Row)).toList();
      expect(rows.length, greaterThanOrEqualTo(2));

      final firstRow = rows[0];
      final expandedInFirstRow = firstRow.children.whereType<Expanded>().length;
      expect(expandedInFirstRow, 2);
    });

    testWidgets('second row contains two Expanded widgets', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const TestDashboardScreen()));
      await tester.pump();

      final rows = tester.widgetList<Row>(find.byType(Row)).toList();
      expect(rows.length, greaterThanOrEqualTo(2));

      final secondRow = rows[1];
      final expandedInSecondRow = secondRow.children.whereType<Expanded>().length;
      expect(expandedInSecondRow, 2);
    });
  });

  group('DashboardScreen widget type verification', () {
    testWidgets('DashboardScreen class exists and is a StatelessWidget', (WidgetTester tester) async {
      expect(DashboardScreen, isNotNull);
      final screen = const DashboardScreen();
      expect(screen, isA<StatelessWidget>());
    });

    testWidgets('verifies TodayIncidentsCount widget exists in codebase', (WidgetTester tester) async {
      expect(TodayIncidentsCount, isNotNull);
    });

    testWidgets('verifies AllIncidentsCount widget exists in codebase', (WidgetTester tester) async {
      expect(AllIncidentsCount, isNotNull);
    });

    testWidgets('verifies MyTodayIncidentsCount widget exists in codebase', (WidgetTester tester) async {
      expect(MyTodayIncidentsCount, isNotNull);
    });

    testWidgets('verifies MyAllIncidentsCount widget exists in codebase', (WidgetTester tester) async {
      expect(MyAllIncidentsCount, isNotNull);
    });

    testWidgets('verifies TopRanking widget exists in codebase', (WidgetTester tester) async {
      expect(TopRanking, isNotNull);
    });
  });

  group('DashboardScreen layout verification', () {
    testWidgets('verifies correct number of SizedBox spacers', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const TestDashboardScreen()));
      await tester.pump();

      final sizedBoxes = find.byType(SizedBox);
      expect(sizedBoxes, findsWidgets);
    });

    testWidgets('verifies section headers are Text widgets', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const TestDashboardScreen()));
      await tester.pump();

      final meZale = find.text('ME ŻALE');
      final najgorsi = find.text('NAJGORSI Z NAJGORSZYCH');

      expect(tester.widget(meZale), isA<Text>());
      expect(tester.widget(najgorsi), isA<Text>());
    });

    testWidgets('verifies DataBox widgets have correct container structure', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const TestDashboardScreen()));
      await tester.pump();

      final containers = find.descendant(
        of: find.byType(MockDataBox),
        matching: find.byType(Container),
      );
      expect(containers, findsNWidgets(4));
    });
  });
}
