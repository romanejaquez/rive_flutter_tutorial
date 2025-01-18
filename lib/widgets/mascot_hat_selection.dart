import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rive_app/models/enums.dart';
import 'package:rive_app/widgets/mascot_hat.dart';

class MascotHatSelection extends StatelessWidget {

  final MascotHatOptions hatOption;
  final Function(MascotHatOptions) onHatSelected;
  const MascotHatSelection({super.key, required this.hatOption, required this.onHatSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(MascotHatOptions.values.length, (index) {
        final hat = MascotHatOptions.values[index];
    
        if (hat == MascotHatOptions.none) {
          return const SizedBox.shrink();
        }
    
        return Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: hat == hatOption ? Colors.blueAccent : Colors.white.withValues(alpha: 0.25),
              width: 8
            ),
          ),
          child: MascotHat(
            hat: hat,
            onHatSelected: (value) {
              onHatSelected(value);
            }  
          ),
        );
      }).animate(
        interval: 0.25.seconds,
      ).slideX(
        begin: 1, end: 0,
        curve: Curves.easeInOut,
        duration: 0.5.seconds,
      ).fadeIn(
        curve: Curves.easeInOut,
        duration: 0.5.seconds,
      ),
    );
  }
}