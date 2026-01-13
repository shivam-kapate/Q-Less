import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class ScanButtonWidget extends StatefulWidget {
  final VoidCallback onPressed;

  const ScanButtonWidget({super.key, required this.onPressed});

  @override
  State<ScanButtonWidget> createState() => _ScanButtonWidgetState();
}

class _ScanButtonWidgetState extends State<ScanButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.electricCyan,
                    AppColors.electricCyan.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.electricCyan.withOpacity(
                      0.4 * _pulseAnimation.value,
                    ),
                    blurRadius: 20 * _pulseAnimation.value,
                    spreadRadius: 5 * _pulseAnimation.value,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Scan Icon with Pulse Effect
                  Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.charcoalBlack.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.qr_code_scanner,
                        size: 60,
                        color: AppColors.charcoalBlack,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Button Text
                  Text(
                    'Scan Item',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.charcoalBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Tap to start scanning',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.charcoalBlack.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
