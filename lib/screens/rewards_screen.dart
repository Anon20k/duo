// lib/screens/rewards_screen.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  /// Últimos 7 días
  List<DateTime> get _dates {
    final today = DateTime.now();
    return List.generate(
      7,
      (i) => DateTime(today.year, today.month, today.day - (6 - i)),
    );
  }

  /// Datos de estudio (minutos) para cada día 1..7
  List<FlSpot> get _studyDataMin => const [
    FlSpot(1, 90),
    FlSpot(2, 120),
    FlSpot(3, 60),
    FlSpot(4, 150),
    FlSpot(5, 180),
    FlSpot(6, 120),
    FlSpot(7, 168),
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

        Widget chartCard({
          required Widget child,
          required String title,
          double aspect = 16 / 9,
        }) {
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
                  color: Colors.white.withOpacity(0.1),
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
                // Mantiene la proporción sin expandir más de lo necesario:
                AspectRatio(aspectRatio: aspect, child: child),
              ],
            ),
          );
        }

        // 1) Gráfico de líneas: minutos vs fecha
        final lineChart = LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 30,
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
                  getTitlesWidget:
                      (v, _) => Text(
                        '${v.toInt()}m',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (v, _) {
                    final idx = v.toInt() - 1;
                    if (idx < 0 || idx >= _dates.length)
                      return const SizedBox();
                    final formatted = DateFormat('dd-MM').format(_dates[idx]);
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

        // 2) Gráfico de pastel: precisión
        final pieChart = PieChart(
          PieChartData(
            sections: _accuracyData,
            centerSpaceRadius: 40,
            sectionsSpace: 8,
          ),
        );

        // ─────────── Desktop ──────────────────
        if (isWide) {
          return Padding(
            padding: EdgeInsets.all(padding),
            child: Row(
              children: [
                Expanded(
                  child: chartCard(
                    child: lineChart,
                    title: 'Estudio vs Fecha',
                    aspect: 16 / 9,
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: chartCard(
                    child: pieChart,
                    title: 'Precisión de respuestas',
                    aspect: 1,
                  ),
                ),
              ],
            ),
          );
        }

        // ─────────── Móvil ────────────────────
        return SingleChildScrollView(
          padding: EdgeInsets.all(padding),
          child: Column(
            children: [
              chartCard(
                child: lineChart,
                title: 'Estudio vs Fecha',
                aspect: constraints.maxWidth / (constraints.maxWidth * 0.6),
              ),
              const SizedBox(height: 24),
              chartCard(
                child: pieChart,
                title: 'Precisión de respuestas',
                aspect: 1,
              ),
            ],
          ),
        );
      },
    );
  }
}
