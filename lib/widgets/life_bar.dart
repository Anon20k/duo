// lib/widgets/life_bar.dart
import 'package:flutter/widgets.dart';

class LifeBar extends StatelessWidget {
  final int current;
  final int max;

  const LifeBar({Key? key, required this.current, required this.max})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(max, (i) {
        final filled = i < current;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Image.asset(
            filled
                ? 'assets/icons/energy_${i + 1}.png'
                : 'assets/icons/energy_0.png',
            width: 16,
            height: 24,
          ),
        );
      }),
    );
  }
}
