// lib/screens/rewards_screen.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  /// Generate the last 7 days as DateTimes
  List<DateTime> get _dates {
    final today = DateTime.now();
    return List.generate(
      7,
      (i) => DateTime(today.year, today.month, today.day - 6 + i),
    );
  }

  /// Study data in **minutes**, x = index+1
  List<FlSpot> get _studyDataMin => const [
    FlSpot(1, 90), // 1.5h → 90m
    FlSpot(2, 120), // 2h → 120m
    FlSpot(3, 60), // 1h → 60m
    FlSpot(4, 150), // 2.5h → 150m
    FlSpot(5, 180), // 3h → 180m
    FlSpot(6, 120), // 2h → 120m
    FlSpot(7, 168), // 2.8h → 168m
  ];

  List<PieChartSectionData> get _accuracyData {
    const correct = 75.0;
    const incorrect = 25.0;
    return [
      PieChartSectionData(
        value: correct,
        title: '${correct.toInt()}%',
        color: Colors.greenAccent,
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        value: incorrect,
        title: '${incorrect.toInt()}%',
        color: Colors.redAccent,
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final isWide = constraints.maxWidth > 800;
        final padding = isWide ? 32.0 : 16.0;

        Widget chartCard({required Widget child, required String title}) {
          return Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2C2655), Color(0xFF15082F)],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 20),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(child: child),
              ],
            ),
          );
        }

        // --- 1) Line Chart (minutes vs date) ---
        final lineChart = LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 30,
              getDrawingHorizontalLine:
                  (y) => FlLine(color: Colors.white24, strokeWidth: 1),
            ),
            titlesData: FlTitlesData(
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 30,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '${value.toInt()}m',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    final idx = value.toInt() - 1;
                    if (idx < 0 || idx >= _dates.length)
                      return const SizedBox();
                    final date = _dates[idx];
                    final formatted = DateFormat('dd-MM').format(date);
                    return Text(
                      formatted,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(
              border: const Border(
                left: BorderSide(color: Colors.white54),
                bottom: BorderSide(color: Colors.white54),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: _studyDataMin,
                isCurved: true,
                barWidth: 3,
                color: Colors.lightBlueAccent,
                dotData: FlDotData(show: true),
              ),
            ],
          ),
        );

        // --- 2) Pie Chart ---
        final pieChart = PieChart(
          PieChartData(
            sections: _accuracyData,
            centerSpaceRadius: 40,
            sectionsSpace: 8,
          ),
        );

        if (isWide) {
          // Desktop: side by side
          return Padding(
            padding: EdgeInsets.all(padding),
            child: Row(
              children: [
                Expanded(
                  child: chartCard(child: lineChart, title: 'Estudio vs Fecha'),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: chartCard(
                    child: pieChart,
                    title: 'Precisión de respuestas',
                  ),
                ),
              ],
            ),
          );
        }

        // Mobile: stacked
        return Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.4,
                child: chartCard(child: lineChart, title: 'Estudio vs Fecha'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: constraints.maxHeight * 0.4,
                child: chartCard(
                  child: pieChart,
                  title: 'Precisión de respuestas',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
