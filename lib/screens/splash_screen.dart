import 'dart:math';
import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  static const Color bgColor = Color(0xFF090909);
  static const Color rippleColor = Color(0xFF154808);
  static const String appName = 'PennyPal';

  late final AnimationController _sequence;
  late final AnimationController _ambient;

  late final Animation<double> _ringsOpacity;
  late final Animation<double> _spinnerOpacity;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _logoScale;
  late final Animation<double> _nameProgress;

  @override
  void initState() {
    super.initState();

    _sequence = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3400),
    );

    _ringsOpacity = CurvedAnimation(
      parent: _sequence,
      curve: const Interval(0.0, 0.08, curve: Curves.easeIn),
    );

    _spinnerOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 25),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 35),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 40),
    ]).animate(
      CurvedAnimation(
        parent: _sequence,
        curve: const Interval(0.42, 0.62, curve: Curves.easeInOut),
      ),
    );

    _logoOpacity = CurvedAnimation(
      parent: _sequence,
      curve: const Interval(0.60, 0.74, curve: Curves.easeIn),
    );

    _logoScale = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(
        parent: _sequence,
        curve: const Interval(0.60, 0.78, curve: Curves.easeOutCubic),
      ),
    );

    _nameProgress = CurvedAnimation(
      parent: _sequence,
      curve: const Interval(0.68, 1.0, curve: Curves.linear),
    );

    _ambient = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _sequence.forward();

    _sequence.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const OnboardingScreen()),
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _sequence.dispose();
    _ambient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ringScale = size.shortestSide / 400;
    final fullLength = appName.length;

    return Scaffold(
      backgroundColor: bgColor,
      body: AnimatedBuilder(
        animation: Listenable.merge([_sequence, _ambient]),
        builder: (context, child) {
          final visibleChars =
              (_nameProgress.value * fullLength).floor().clamp(0, fullLength);

          return Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: _ringsOpacity.value,
                child: CustomPaint(
                  size: Size.infinite,
                  painter: _RingClusterPainter(
                    time: _ambient.value,
                    scale: ringScale,
                    color: rippleColor,
                  ),
                ),
              ),
              Opacity(
                opacity: _spinnerOpacity.value,
                child: const SizedBox(
                  width: 26,
                  height: 26,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
              ),
              Opacity(
                opacity: _logoOpacity.value,
                child: Transform.scale(
                  scale: _logoScale.value,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        appName.substring(0, visibleChars),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _RingClusterPainter extends CustomPainter {
  final double time;
  final double scale;
  final Color color;

  static const int _ringCount = 4;
  static const int _pointCount = 10;
  static const double _waveFrequency = 3.0;

  _RingClusterPainter({
    required this.time,
    required this.scale,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    for (int ring = 0; ring < _ringCount; ring++) {
      final baseRadius = (50.0 + ring * 26.0) * scale;
      final amplitude = 6.0 * scale;
      final phase = time * 2 * pi + ring * 1.1;

      final points = <Offset>[];
      for (int i = 0; i < _pointCount; i++) {
        final angle = (i / _pointCount) * 2 * pi;
        final wobble = sin(angle * _waveFrequency + phase) * amplitude;
        final r = baseRadius + wobble;
        points.add(Offset(center.dx + cos(angle) * r, center.dy + sin(angle) * r));
      }

      final path = _smoothClosedPath(points);
      final rect = Rect.fromCircle(center: center, radius: baseRadius + amplitude);
      final opacity = 0.55 - ring * 0.11;
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withOpacity(opacity * 0.15),
            color.withOpacity(opacity),
          ],
        ).createShader(rect);

      canvas.drawPath(path, paint);
    }
  }

  Path _smoothClosedPath(List<Offset> pts) {
    final path = Path();
    final n = pts.length;
    if (n < 3) return path;

    path.moveTo(pts[0].dx, pts[0].dy);
    for (int i = 0; i < n; i++) {
      final p0 = pts[(i - 1 + n) % n];
      final p1 = pts[i];
      final p2 = pts[(i + 1) % n];
      final p3 = pts[(i + 2) % n];

      final cp1 = Offset(p1.dx + (p2.dx - p0.dx) / 6, p1.dy + (p2.dy - p0.dy) / 6);
      final cp2 = Offset(p2.dx - (p3.dx - p1.dx) / 6, p2.dy - (p3.dy - p1.dy) / 6);

      path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, p2.dx, p2.dy);
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant _RingClusterPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}
