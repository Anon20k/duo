// lib/screens/home_landing_screen.dart
import 'package:flutter/material.dart';
import '../routes.dart';
import '../models/level_model.dart';
import '../services/quiz_service.dart';

class HomeLandingScreen extends StatelessWidget {
  const HomeLandingScreen({super.key});

  Future<Nivel> _loadCurrentNivel() {
    // Ajusta capítulo y nombre de JSON según dónde esté
    return QuizService.loadNivel(1, 'nivel_sumas_resta');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Nivel>(
      future: _loadCurrentNivel(),
      builder: (ctx, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snap.hasError) {
          return Center(
            child: Text(
              'Error cargando nivel:\n${snap.error}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        }

        final nivel = snap.data!;
        // La primera sección → primera etapa
        final int currentStage = nivel.secciones.first.etapas.first.etapa;

        return LayoutBuilder(
          builder: (ctx2, constraints) {
            final isWide = constraints.maxWidth > 800;

            // Escala entre 1.0 y 1.5 según ancho
            final rawScale = constraints.maxWidth / 1200;
            final scale = rawScale.clamp(1.0, 1.5);

            final gap = 16.0 * scale;
            final textL = 18.0 * scale;
            final textM = 16.0 * scale;
            final iconL = 32.0 * scale;
            final iconS = 24.0 * scale;
            final progH = 12.0 * scale;

            // Local helpers
            Widget vh(double v) => SizedBox(height: v * scale);
            Widget vw(double v) => SizedBox(width: v * scale);

            Widget card(Widget child) => Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2C2655), Color(0xFF15082F)],
                ),
                borderRadius: BorderRadius.circular(24 * scale),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(255, 255, 255, 0.1),
                    blurRadius: 12 * scale,
                    spreadRadius: 2 * scale,
                  ),
                ],
              ),
              padding: EdgeInsets.all(gap),
              child: child,
            );

            // 1) Etapa
            Widget stageCard() => GestureDetector(
              onTap: () => Navigator.pushNamed(ctx2, Routes.panelNiveles),
              child: card(
                Row(
                  children: [
                    Text(
                      'Etapa $currentStage',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: textL,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '10 / 10',
                      style: TextStyle(color: Colors.white, fontSize: textM),
                    ),
                    vw(8),
                    Icon(Icons.star, color: Colors.amber, size: iconL),
                  ],
                ),
              ),
            );

            // 2) Misiones
            Widget missionCard() => card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Progreso misiones',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textL,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  vh(8),
                  Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.yellow,
                        size: iconL,
                      ),
                      vw(8),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8 * scale),
                          child: LinearProgressIndicator(
                            value: 1.0,
                            backgroundColor: Colors.white24,
                            valueColor: const AlwaysStoppedAnimation(
                              Colors.green,
                            ),
                            minHeight: progH * 1.5,
                          ),
                        ),
                      ),
                      vw(8),
                      Icon(
                        Icons.card_giftcard,
                        color: Colors.brown,
                        size: iconL,
                      ),
                    ],
                  ),
                ],
              ),
            );

            // 3) Rendimiento
            Widget performanceCard() => card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Desempeño de ayer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textL,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  vh(12),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: iconL),
                      vw(4),
                      Icon(Icons.star, color: Colors.amber, size: iconS),
                      vw(4),
                      Icon(Icons.star_border, color: Colors.amber, size: iconS),
                    ],
                  ),
                  vh(8),
                  Text(
                    'Excelente',
                    style: TextStyle(color: Colors.white, fontSize: textM),
                  ),
                ],
              ),
            );

            // 4) Continuar
            Widget continueCard() => card(
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.white,
                    size: iconL * 1.25,
                  ),
                  vh(8),
                  Text(
                    'Continuar',
                    style: TextStyle(color: Colors.white, fontSize: textM),
                  ),
                ],
              ),
            );

            // 5) Estadísticas
            Widget statsCard() {
              Widget rowItem(String label, double pct, int cnt) {
                return Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        label,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    vw(8),
                    Expanded(
                      flex: 6,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8 * scale),
                        child: LinearProgressIndicator(
                          value: pct,
                          backgroundColor: Colors.white24,
                          valueColor: const AlwaysStoppedAnimation(
                            Colors.green,
                          ),
                          minHeight: progH,
                        ),
                      ),
                    ),
                    vw(8),
                    Text('$cnt', style: const TextStyle(color: Colors.white)),
                  ],
                );
              }

              return card(
                Column(
                  children: [
                    rowItem('Correctas', 1.0, 10),
                    vh(12),
                    rowItem('Incompletas', 0.0, 0),
                    vh(12),
                    rowItem('Erróneas', 0.0, 0),
                  ],
                ),
              );
            }

            final cards = [
              stageCard(),
              missionCard(),
              performanceCard(),
              continueCard(),
              statsCard(),
            ];

            if (isWide) {
              // ─── Desktop: 3 filas (2 + 2 + 1)
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(gap),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(child: cards[0]),
                          vw(gap / 2),
                          Expanded(child: cards[1]),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: gap),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(child: cards[2]),
                          vw(gap / 2),
                          Expanded(child: cards[3]),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(gap),
                      child: cards[4],
                    ),
                  ),
                ],
              );
            }

            // ─── Móvil: Grid 2×3 sin scroll
            return Padding(
              padding: EdgeInsets.all(gap),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: gap,
                crossAxisSpacing: gap,
                childAspectRatio:
                    constraints.maxWidth /
                    constraints.maxHeight *
                    2, // ajusta para tu estética
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: cards,
              ),
            );
          },
        );
      },
    );
  }
}
