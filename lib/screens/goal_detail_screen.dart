import 'package:flutter/material.dart';
import 'colors.dart';
import '../widgets/widgets.dart';
import 'goals_list_screen.dart' show SavingsGoal;

class GoalDetailScreen extends StatelessWidget {
  const GoalDetailScreen({super.key, required this.goal});

  final SavingsGoal goal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: const BackButton(color: AppColors.textDark),
        title: Row(
          children: const [
            PennyPalMark(size: 24),
            SizedBox(width: 8),
            Text('Goal Detail', style: TextStyle(color: AppColors.textDark, fontSize: 18, fontWeight: FontWeight.w700)),
          ],
        ),
        actions: const [
          Padding(padding: EdgeInsets.only(right: 16), child: ProfileAvatar(size: 32)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildTitleCard(),
          const SizedBox(height: 20),
          _buildStatsRow(),
          const SizedBox(height: 14),
          _buildOnTrackBanner(),
          const SizedBox(height: 20),
          _buildAutoDepositCard(context),
          const SizedBox(height: 20),
          _buildCheerBox(),
          const SizedBox(height: 20),
          _buildMilestones(),
          const SizedBox(height: 20),
          _buildDepositActivity(),
        ],
      ),
    );
  }

  Widget _buildTitleCard() {
    return AppCard(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: AppColors.lightBlue, borderRadius: BorderRadius.circular(20)),
              child: Text(goal.category, style: const TextStyle(fontSize: 12, color: AppColors.darkGreen)),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(goal.title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textDark)),
          ),
          const SizedBox(height: 20),
          CircleProgress(progress: goal.progress),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: AppCard(
            color: AppColors.lightBlue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Currently Saved', style: TextStyle(fontSize: 12, color: AppColors.grey)),
                const SizedBox(height: 4),
                Text('\$${goal.savedSoFar.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              AppCard(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Target Goal', style: TextStyle(fontSize: 11, color: AppColors.grey)),
                    Text('\$${goal.target.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              AppCard(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Remaining', style: TextStyle(fontSize: 11, color: AppColors.orange)),
                    Text('\$${goal.remaining.toStringAsFixed(2)} left',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.orange)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOnTrackBanner() {
    return AppCard(
      color: AppColors.lightGreen,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(backgroundColor: AppColors.darkGreen, radius: 16, child: Icon(Icons.bolt, color: Colors.white, size: 18)),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('On track!', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.darkGreen)),
                SizedBox(height: 2),
                Text('Est. completion: June 15, 2025', style: TextStyle(fontSize: 12, color: AppColors.textDark)),
                Text('Only 42 days left at current monthly pace.', style: TextStyle(fontSize: 12, color: AppColors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutoDepositCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.autorenew, color: AppColors.darkGreen, size: 18),
              const SizedBox(width: 8),
              const Expanded(
                child: Text('Auto-Deposit Active', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppColors.lightBlue, borderRadius: BorderRadius.circular(20)),
                child: const Text('\$60.00 / month', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text('Transfers automatically on the 1st of every month from Main Checking.',
              style: TextStyle(fontSize: 12, color: AppColors.grey)),
          const SizedBox(height: 16),
          PrimaryButton(
            label: '+ Quick Deposit \$20',
            icon: Icons.add_circle_outline,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Quick deposit added!')),
              );
            },
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton.icon(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.lightBlue,
                side: BorderSide.none,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              icon: const Icon(Icons.tune, color: AppColors.darkGreen, size: 18),
              label: const Text('+ Custom Deposit', style: TextStyle(color: AppColors.darkGreen, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheerBox() {
    return AppCard(
      color: AppColors.lightOrange,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🎉', style: TextStyle(fontSize: 26)),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Penny's Cheer Box", style: TextStyle(fontWeight: FontWeight.w700)),
                SizedBox(height: 4),
                Text(
                  'You are crushing this goal! Just 2 more deposits and your new laptop is ordered. Keep that momentum alive!',
                  style: TextStyle(fontSize: 12, color: AppColors.textDark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestones() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.emoji_events_outlined, color: AppColors.orange),
              SizedBox(width: 8),
              Expanded(child: Text('Goal Milestones', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16))),
              Text('2 of 3 Unlocked', style: TextStyle(fontSize: 12, color: AppColors.mediumGreen, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 16),
          const _MilestoneRow(
            icon: Icons.rocket_launch_outlined,
            title: 'First 25% Unlocked! 🚀',
            subtitle: 'Reached on April 1, 2025',
            statusText: 'Completed',
            statusColor: AppColors.mediumGreen,
            done: true,
          ),
          const SizedBox(height: 14),
          const _MilestoneRow(
            icon: Icons.flag_outlined,
            title: 'Halfway Hero 50% 🎯',
            subtitle: 'Reached on May 10, 2025',
            statusText: 'Completed',
            statusColor: AppColors.mediumGreen,
            done: true,
          ),
          const SizedBox(height: 14),
          const _MilestoneRow(
            icon: Icons.bolt,
            title: 'Home Stretch 75% ⚡',
            subtitle: '\$30.00 away!',
            statusText: '',
            statusColor: AppColors.orange,
            done: false,
            progress: 0.85,
          ),
        ],
      ),
    );
  }

  Widget _buildDepositActivity() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.history, color: AppColors.darkGreen),
              SizedBox(width: 8),
              Expanded(child: Text('Deposit Activity', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16))),
              Text('Last 30 days', style: TextStyle(fontSize: 12, color: AppColors.grey)),
            ],
          ),
          const SizedBox(height: 16),
          const _DepositRow(icon: Icons.school_outlined, title: 'Tutoring payout', subtitle: 'May 12, 2025 • One-time', amount: '+\$40.00'),
          const SizedBox(height: 14),
          const _DepositRow(icon: Icons.savings_outlined, title: 'Boba budget surplus', subtitle: 'May 8, 2025 • Roll-over', amount: '+\$20.00'),
          const SizedBox(height: 14),
          const _DepositRow(icon: Icons.autorenew, title: 'Monthly auto-save', subtitle: 'May 1, 2025 • Scheduled', amount: '+\$60.00'),
          const SizedBox(height: 14),
          const _DepositRow(icon: Icons.card_giftcard_outlined, title: 'Birthday gift top-up', subtitle: 'Apr 24, 2025 • One-time', amount: '+\$100.00'),
        ],
      ),
    );
  }
}

class _MilestoneRow extends StatelessWidget {
  const _MilestoneRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.statusText,
    required this.statusColor,
    required this.done,
    this.progress,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String statusText;
  final Color statusColor;
  final bool done;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: done ? AppColors.lightGreen : AppColors.lightBlue,
          child: Icon(icon, size: 18, color: done ? AppColors.darkGreen : AppColors.grey),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.grey)),
              if (progress != null) ...[
                const SizedBox(height: 6),
                SimpleProgressBar(progress: progress!, color: AppColors.orange, height: 6),
              ],
            ],
          ),
        ),
        if (statusText.isNotEmpty)
          Text(statusText, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: statusColor)),
      ],
    );
  }
}

class _DepositRow extends StatelessWidget {
  const _DepositRow({required this.icon, required this.title, required this.subtitle, required this.amount});

  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(backgroundColor: AppColors.lightBlue, child: Icon(icon, size: 18, color: AppColors.darkGreen)),
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
        Text(amount, style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.mediumGreen)),
      ],
    );
  }
}
