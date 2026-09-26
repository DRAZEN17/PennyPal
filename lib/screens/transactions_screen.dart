import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'add_income_screen.dart';
import 'goals_list_screen.dart';
import 'more_screen.dart';
import 'app_bottom_nav.dart';
import 'transaction.dart';
import 'transaction_detail_screen.dart';
import 'edit_transaction_screen.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  static const primaryGreen = Color(0xFF154808);
  static const bg = Color(0xFFF5F5F5);

  String searchQuery = '';
  String selectedFilter = 'All';

  final searchController = TextEditingController();

  final List<Transaction> allTransactions = [
    Transaction(
      title: 'Textbook Purchase',
      category: 'Expense',
      date: '14 March 2024',
      time: '9:00am',
      amount: 20000,
      sign: '-',
      icon: Icons.menu_book_outlined,
      color: primaryGreen,
    ),
    Transaction(
      title: 'Allowance money',
      category: 'Income',
      date: '20 March 2024',
      time: '11:30am',
      amount: 300000,
      sign: '+',
      icon: Icons.account_balance_wallet_outlined,
      color: primaryGreen,
    ),
    Transaction(
      title: 'Laptop',
      category: 'Budget',
      date: '30 March 2024',
      time: '2:45pm',
      amount: 300000,
      sign: '',
      icon: Icons.savings_outlined,
      color: primaryGreen,
    ),
    Transaction(
      title: 'Freelance gig',
      category: 'Income',
      date: '2 April 2024',
      time: '4:00pm',
      amount: 85000,
      sign: '+',
      icon: Icons.laptop_mac_outlined,
      color: primaryGreen,
    ),
    Transaction(
      title: 'Concert ticket',
      category: 'Expense',
      date: '5 April 2024',
      time: '6:20pm',
      amount: 12000,
      sign: '-',
      icon: Icons.confirmation_number_outlined,
      color: primaryGreen,
    ),
  ];

  List<Transaction> get filteredTransactions {
    return allTransactions.where((t) {
      final matchesFilter = selectedFilter == 'All' || t.category == selectedFilter;
      final matchesSearch = t.title.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();
  }

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
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: primaryGreen,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.maybePop(context),
                        icon: const Icon(Icons.chevron_left, color: Colors.white, size: 28),
                      ),
                      const Text(
                        'Transactions',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const Spacer(),
                      const Icon(Icons.public, color: Colors.white, size: 20),
                      const SizedBox(width: 6),
                      const Text(
                        'PennyPal',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Total Transactions', style: TextStyle(color: Colors.white70, fontSize: 13)),
                            SizedBox(height: 4),
                            Text('\$1,873', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('Total Volume', style: TextStyle(color: Colors.white70, fontSize: 13)),
                            const SizedBox(height: 4),
                            const Text(
                              '\u20A61,925,966.22',
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EditTransactionScreen(transaction: allTransactions[0]),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.edit_note, color: Colors.white, size: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                transform: Matrix4.translationValues(0, -20, 0),
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              setState(() => searchQuery = value);
                            },
                            decoration: InputDecoration(
                              hintText: 'Search transactions...',
                              prefixIcon: const Icon(Icons.search, color: Colors.black45),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(vertical: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFilter = 'All';
                              searchQuery = '';
                              searchController.clear();
                            });
                          },
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: primaryGreen,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(Icons.filter_list, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          filterChip('All', null),
                          const SizedBox(width: 10),
                          filterChip('Income', Icons.attach_money),
                          const SizedBox(width: 10),
                          filterChip('Expenses', Icons.receipt_long_outlined),
                          const SizedBox(width: 10),
                          filterChip('Budget', Icons.pie_chart_outline),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredTransactions.length,
                        itemBuilder: (context, index) {
                          return transactionCard(filteredTransactions[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppBottomNav(
              currentIndex: 1,
              onAddTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddIncomeScreen()),
                );
              },
              onTabTap: (i) {
                if (i == 0) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                } else if (i == 3) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const GoalsListScreen()),
                  );
                } else if (i == 4) {
                  Navigator.pushReplacement(
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

  Widget filterChip(String label, IconData? icon) {
    final isSelected = selectedFilter == label || (label == 'All' && selectedFilter == 'All');
    final categoryValue = label == 'Expenses' ? 'Expense' : label;

    return GestureDetector(
      onTap: () {
        setState(() => selectedFilter = categoryValue);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? primaryGreen : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? primaryGreen : Colors.black26),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: isSelected ? Colors.white : Colors.black87),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget transactionCard(Transaction t) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TransactionDetailScreen(transaction: t)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: primaryGreen.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: primaryGreen.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(t.icon, color: primaryGreen, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                  Text(t.date, style: const TextStyle(color: Colors.black54, fontSize: 12)),
                ],
              ),
            ),
            Text(
              '${t.sign}${money(t.amount)}',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: t.sign == '-' ? Colors.red : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
