import 'package:flutter/material.dart';
import 'transaction.dart';
import 'edit_transaction_screen.dart';

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({super.key, required this.transaction});

  final Transaction transaction;

  static const primaryGreen = Color(0xFF154808);

  String money(num n) {
    final s = n.toStringAsFixed(0);
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final posFromRight = s.length - i;
      buffer.write(s[i]);
      if (posFromRight > 1 && posFromRight % 3 == 1) buffer.write(',');
    }
    return '\$$buffer';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.chevron_left, size: 28),
                  ),
                  const Text(
                    'Transactions details',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditTransactionScreen(transaction: transaction),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Center(
                child: Text(
                  '${transaction.sign}${money(transaction.amount)}',
                  style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  '${transaction.time} ${transaction.date}',
                  style: const TextStyle(color: Colors.black54, fontSize: 15),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(color: Colors.black26),
              const SizedBox(height: 24),
              detailRow('Transaction Type:', transaction.category),
              const SizedBox(height: 20),
              detailRow('Description:', transaction.description),
              const SizedBox(height: 20),
              detailRow('Date:', transaction.date),
              const SizedBox(height: 20),
              detailRow('Time:', transaction.time),
              const SizedBox(height: 30),
              const Divider(color: Colors.black26),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Receipt downloaded')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  icon: const Icon(Icons.download_outlined, color: Colors.white),
                  label: const Text(
                    'Details',
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

  Widget detailRow(String label, String value) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontSize: 15, color: Colors.black87)),
        const SizedBox(width: 8),
        Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
      ],
    );
  }
}
