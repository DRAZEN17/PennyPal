import 'package:flutter/material.dart';
import 'add_income_screen.dart';
import 'goals_list_screen.dart';
import 'app_bottom_nav.dart';
import 'transactions_screen.dart';
import 'more_screen.dart';
import 'transaction.dart';
import 'transaction_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color primaryGreen = Color(0xFF154808);
  static const Color bg = Color(0xFFF5F5F5);

  final List<Transaction> _transactions = [
    Transaction(
      title: 'Salary',
      category: 'Income',
      date: '24 sep 2026',
      time: '10:00am',
      amount: 120000,
      sign: '+',
      icon: Icons.arrow_upward,
      color: primaryGreen,
    ),
    Transaction(
      title: 'Food',
      category: 'Expense',
      date: '22 sep 2026',
      time: '1:15pm',
      amount: 25000,
      sign: '-',
      icon: Icons.shopping_basket_outlined,
      color: const Color(0xFF6A1B9A),
    ),
    Transaction(
      title: 'Transport',
      category: 'Expense',
      date: '21 sep 2026',
      time: '8:30am',
      amount: 15000,
      sign: '-',
      icon: Icons.directions_car_outlined,
      color: const Color(0xFFD81B60),
    ),
  ];

  String _money(num n) {
    final s = n.toStringAsFixed(0);
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final posFromRight = s.length - i;
      buffer.write(s[i]);
      if (posFromRight > 1 && posFromRight % 3 == 1) buffer.write(',');
    }
    return '\u20A6${buffer.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipPath(
                          clipper: _HeaderClipper(),
                          child: Container(
                            color: primaryGreen,
                            padding: const EdgeInsets.fromLTRB(20, 12, 20, 70),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/logo.png',
                                      width: 40,
                                      height: 40,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'PennyPal',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.notifications_none, color: Colors.white, size: 24),
                                    const SizedBox(width: 14),
                                    const CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Colors.white24,
                                      child: Icon(Icons.person, color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Good morning,',
                                  style: TextStyle(color: Colors.white70, fontSize: 14),
                                ),
                                const Text(
                                  'Chioma',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Text(
                                  "Here's your financial overview",
                                  style: TextStyle(color: Colors.white70, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          right: 20,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(Icons.visibility_outlined, size: 16, color: Colors.black54),
                                        SizedBox(width: 6),
                                        Text('Total Balance', style: TextStyle(color: Colors.black54)),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFD9F2C4),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(Icons.arrow_upward, size: 14, color: primaryGreen),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          _money(550000),
                                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFB6E39A),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text('-12%', style: TextStyle(fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _statCard('Total Income', _money(340000), Icons.calendar_view_month, primaryGreen),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: _statCard('Total Expenses', _money(130000), Icons.credit_card, const Color(0xFFD81B60)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: _statCard('This Month Income', _money(550000), Icons.calendar_view_month, primaryGreen),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: _statCard('This month Expenses', _money(120000), Icons.calendar_view_month, const Color(0xFFEF6C00)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              const Text('Recent Transactions', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const TransactionsScreen()),
                                  );
                                },
                                child: const Text('See all >', style: TextStyle(color: Color(0xFF6A1B9A))),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          for (final t in _transactions) _transactionTile(t),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppBottomNav(
              currentIndex: 0,
              onAddTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddIncomeScreen()),
                );
              },
              onTabTap: (i) {
                if (i == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TransactionsScreen()),
                  );
                } else if (i == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GoalsListScreen()),
                  );
                } else if (i == 4) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MoreScreen()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: color.withOpacity(0.15), shape: BoxShape.circle),
                child: Icon(icon, size: 16, color: color),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _transactionTile(Transaction t) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TransactionDetailScreen(transaction: t)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: t.color, shape: BoxShape.circle),
              child: Icon(t.icon, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                  Text('${t.category} . ${t.date}', style: const TextStyle(color: Colors.black54, fontSize: 12)),
                ],
              ),
            ),
            Text(
              '${t.sign} ${_money(t.amount)}',
              style: TextStyle(
                color: t.sign == '-' ? Colors.red : primaryGreen,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class _HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width * 0.25, size.height,
      size.width * 0.55, size.height - 25,
    );
    path.quadraticBezierTo(
      size.width * 0.8, size.height - 55,
      size.width, size.height - 20,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}