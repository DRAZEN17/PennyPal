import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'add_income_screen.dart';
import 'goals_list_screen.dart';
import 'transactions_screen.dart';
import 'app_bottom_nav.dart';
import 'login_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  static const Color primaryGreen = Color(0xFF154808);
  static const Color bg = Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {'icon': Icons.person_outline, 'label': 'Profile'},
      {'icon': Icons.settings_outlined, 'label': 'Settings'},
      {'icon': Icons.help_outline, 'label': 'Help & Support'},
      {'icon': Icons.privacy_tip_outlined, 'label': 'Privacy Policy'},
      {'icon': Icons.logout, 'label': 'Log out'},
    ];

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 16),
              child: Row(
                children: [
                  Text('More', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: menuItems.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  final isLogout = item['label'] == 'Log out';

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      leading: Icon(
                        item['icon'] as IconData,
                        color: isLogout ? Colors.red : primaryGreen,
                      ),
                      title: Text(
                        item['label'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isLogout ? Colors.red : Colors.black87,
                        ),
                      ),
                      trailing: isLogout
                          ? null
                          : const Icon(Icons.chevron_right, color: Colors.black38),
                      onTap: () {
                        if (isLogout) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginScreen()),
                            (route) => false,
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            AppBottomNav(
              currentIndex: 4,
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
                } else if (i == 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const TransactionsScreen()),
                  );
                } else if (i == 3) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const GoalsListScreen()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
