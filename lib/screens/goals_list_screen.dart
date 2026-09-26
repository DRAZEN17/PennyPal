import 'package:flutter/material.dart';
import 'colors.dart';
import 'widgets.dart';
import 'goal_detail_screen.dart';
import 'create_goal_screen.dart';
import 'home_screen.dart';
import 'add_income_screen.dart';
import 'app_bottom_nav.dart';
import 'transactions_screen.dart';
import 'more_screen.dart';

class SavingsGoal {
  const SavingsGoal({
    required this.category,
    required this.title,
    required this.icon,
    required this.iconBackground,
    required this.savedSoFar,
    required this.target,
    required this.targetDate,
    required this.progressColor,
  });

  final String category;
  final String title;
  final IconData icon;
  final Color iconBackground;
  final double savedSoFar;
  final double target;
  final String targetDate;
  final Color progressColor;

  double get progress => savedSoFar / target;
  double get remaining => target - savedSoFar;
}

class GoalsListScreen extends StatefulWidget {
  const GoalsListScreen({super.key});

  @override
  State<GoalsListScreen> createState() => _GoalsListScreenState();
}

class _GoalsListScreenState extends State<GoalsListScreen> {
  int _selectedTab = 0;

  final List<SavingsGoal> _activeGoals = const [
    SavingsGoal(
      category: 'Tech & Study',
      title: 'MacBook Air M3 for College',
      icon: Icons.laptop_mac,
      iconBackground: AppColors.lightBlue,
      savedSoFar: 720,
      target: 1000,
      targetDate: 'Target: Oct 15, 2025',
      progressColor: AppColors.mediumGreen,
    ),
    SavingsGoal(
      category: 'Safety Net',
      title: 'Student Emergency Cushion',
      icon: Icons.shield_outlined,
      iconBackground: AppColors.lightOrange,
      savedSoFar: 350,
      target: 500,
      targetDate: 'Target: Dec 31, 2025',
      progressColor: AppColors.orange,
    ),
    SavingsGoal(
      category: 'Vacation',
      title: 'Summer Semester Roadtrip',
      icon: Icons.directions_car_outlined,
      iconBackground: AppColors.lightGreen,
      savedSoFar: 250,
      target: 400,
      targetDate: 'Target: Jul 30, 2025',
      progressColor: AppColors.mediumGreen,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildTopBar(),
            const SizedBox(height: 20),
            _buildTotalStashCard(),
            const SizedBox(height: 20),
            _buildTabs(),
            const SizedBox(height: 16),

            if (_selectedTab == 0)
              ..._activeGoals.map((goal) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _GoalCard(
                      goal: goal,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => GoalDetailScreen(goal: goal)),
                        );
                      },
                    ),
                  ))
            else
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'Your completed goals will show up here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.grey),
                ),
              ),

            _buildCreateGoalCard(context),
            const SizedBox(height: 20),
            _buildCelebratedVictories(),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 3,
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
          } else if (i == 4) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MoreScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        const PennyPalMark(),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'Savings Goals',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textDark),
          ),
        ),
        const Icon(Icons.notifications_none, color: AppColors.textDark),
        const SizedBox(width: 12),
        const ProfileAvatar(),
      ],
    );
  }

  Widget _buildTotalStashCard() {
    final totalSaved = _activeGoals.fold<double>(0, (sum, g) => sum + g.savedSoFar);
    const totalTarget = 1900.0;
    final progress = totalSaved / totalTarget;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.darkGreen, AppColors.mediumGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('🔥 4-Month Habit Streak!',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
              const Text('TOTAL STASH',
                  style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800),
                  children: [
                    TextSpan(text: '\$${totalSaved.toStringAsFixed(2)}'),
                    TextSpan(
                      text: ' / \$${totalTarget.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Text('${(progress * 100).round()}%',
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 10),
          SimpleProgressBar(progress: progress, color: Colors.white),
          const SizedBox(height: 10),
          const Text(
            '↗ Pace: +\$145/mo   ·   On track for semester goals',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        _TabChip(
          label: 'Active (${_activeGoals.length})',
          selected: _selectedTab == 0,
          onTap: () => setState(() => _selectedTab = 0),
        ),
        const SizedBox(width: 10),
        _TabChip(
          label: 'Completed (2)',
          selected: _selectedTab == 1,
          onTap: () => setState(() => _selectedTab = 1),
        ),
        const Spacer(),
        TextButton.icon(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateGoalScreen()),
          ),
          icon: const Icon(Icons.add, size: 18, color: AppColors.darkGreen),
          label: const Text('New Goal', style: TextStyle(color: AppColors.darkGreen)),
        ),
      ],
    );
  }

  Widget _buildCreateGoalCard(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CreateGoalScreen()),
      ),
      child: AppCard(
        color: AppColors.lightBlue,
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppColors.darkGreen,
              child: Icon(Icons.add, color: Colors.white),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Create a New Savings Goal',
                      style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textDark)),
                  SizedBox(height: 2),
                  Text('Automate small change or set target milestones',
                      style: TextStyle(fontSize: 12, color: AppColors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCelebratedVictories() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.emoji_events_outlined, color: AppColors.orange),
              SizedBox(width: 8),
              Text('Celebrated Victories',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              SizedBox(width: 6),
              CircleAvatar(radius: 10, backgroundColor: AppColors.lightBlue, child: Text('2', style: TextStyle(fontSize: 11))),
            ],
          ),
          const Divider(height: 28),
          const _VictoryRow(
            icon: Icons.headphones,
            title: 'Noise Cancelling Headphones',
            subtitle: '\$180.00 Saved  ·  Completed Jun 12, 2024',
          ),
          const SizedBox(height: 16),
          const _VictoryRow(
            icon: Icons.menu_book_outlined,
            title: 'Textbooks Fall Fund',
            subtitle: '\$220.00 Saved  ·  Completed Jan 28, 2025',
          ),
        ],
      ),
    );
  }

}

class _GoalCard extends StatelessWidget {
  const _GoalCard({required this.goal, required this.onTap});

  final SavingsGoal goal;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: goal.iconBackground,
                  child: Icon(goal.icon, color: AppColors.darkGreen),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(goal.category, style: const TextStyle(fontSize: 12, color: AppColors.grey)),
                      Text(goal.title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                const Icon(Icons.more_vert, color: AppColors.grey),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Saved so far', style: TextStyle(fontSize: 12, color: AppColors.grey)),
                    Text('\$${goal.savedSoFar.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.darkGreen)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Target: \$${goal.target.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 12, color: AppColors.grey)),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.lightOrange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('\$${goal.remaining.toStringAsFixed(2)} left',
                          style: const TextStyle(fontSize: 11, color: AppColors.orange)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Progress', style: TextStyle(fontSize: 12, color: AppColors.grey)),
                Text('${(goal.progress * 100).round()}%',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 4),
            SimpleProgressBar(progress: goal.progress, color: goal.progressColor),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.grey),
                    const SizedBox(width: 6),
                    Text(goal.targetDate, style: const TextStyle(fontSize: 12, color: AppColors.grey)),
                  ],
                ),
                const Text('+ Deposit →',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.mediumGreen)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.darkGreen : AppColors.lightBlue,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.textDark,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _VictoryRow extends StatelessWidget {
  const _VictoryRow({required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(backgroundColor: AppColors.lightGreen, child: Icon(icon, color: AppColors.darkGreen, size: 18)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.grey)),
            ],
          ),
        ),
        const Icon(Icons.check_circle, color: AppColors.mediumGreen, size: 20),
      ],
    );
  }
}
