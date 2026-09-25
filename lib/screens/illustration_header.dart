import 'package:flutter/material.dart';

/// A soft blob background with a centered icon, matching the lock/OTP
/// illustrations used on Forgot Password / OTP / Reset Password screens.
class IllustrationHeader extends StatelessWidget {
  const IllustrationHeader({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 210,
            height: 210,
            decoration: BoxDecoration(
              color: const Color(0xFFD9E8FB),
              borderRadius: BorderRadius.circular(70),
            ),
          ),
          // sparkle accents
          const Positioned(top: 10, left: 60, child: _Sparkle(color: Color(0xFF9BB8F0), size: 14)),
          const Positioned(top: 30, right: 30, child: _Sparkle(color: Color(0xFF7FD1C4), size: 18)),
          const Positioned(bottom: 40, left: 30, child: _Sparkle(color: Color(0xFFB79BF0), size: 16)),
          const Positioned(bottom: 20, right: 55, child: _Sparkle(color: Color(0xFF7FD1C4), size: 12)),
          Icon(icon, size: 90, color: const Color(0xFF2C3E63)),
        ],
      ),
    );
  }
}

class _Sparkle extends StatelessWidget {
  const _Sparkle({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.auto_awesome, color: color, size: size);
  }
}
