import 'package:flutter/material.dart';
import 'home_screen.dart';

class IncomeAddedScreen extends StatelessWidget {
  final double amount;
  final String source;
  final DateTime date;
  final String description;

  const IncomeAddedScreen({
    super.key,
    required this.amount,
    required this.source,
    required this.date,
    required this.description,
  });

  static const Color primaryGreen = Color(0xFF154808);
  static const Color bg = Color(0xFFF5F5F5);

  String _formatDate(DateTime d) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }

  String _formatAmount(double a) {
    final s = a.toStringAsFixed(0);
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final posFromRight = s.length - i;
      buffer.write(s[i]);
      if (posFromRight > 1 && posFromRight % 3 == 1) buffer.write(',');
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              SizedBox(
                width: 140,
                height: 140,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    for (final angle in [-60.0, -20.0, 20.0, 60.0, 120.0, 160.0, 200.0, 240.0])
                      Transform.rotate(
                        angle: angle * 3.1415926535 / 180,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 2,
                            height: 12,
                            margin: const EdgeInsets.only(top: 4),
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [primaryGreen, Colors.black],
                        ),
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 44),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Income Added!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                '\u20A6 ${_formatAmount(amount)}',
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              Text(
                'has been added to your income successfully.',
                textAlign: TextAlign.center,
                style: TextStyle(color: primaryGreen, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: primaryGreen.withOpacity(0.4)),
                ),
                child: Column(
                  children: [
                    _detailRow(Icons.mail_outline, 'Source', source),
                    const SizedBox(height: 16),
                    _detailRow(Icons.calendar_today_outlined, 'Date', _formatDate(date)),
                    const SizedBox(height: 16),
                    _detailRow(
                      Icons.description_outlined,
                      'Description',
                      description.isEmpty ? '-' : description,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: primaryGreen.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: primaryGreen, size: 18),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.black54, fontSize: 13)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          ],
        ),
      ],
    );
  }
}