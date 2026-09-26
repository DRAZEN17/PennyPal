import 'package:flutter/material.dart';
import 'colors.dart';
import '../widgets/widgets.dart';

class CreateGoalScreen extends StatefulWidget {
  const CreateGoalScreen({super.key});

  @override
  State<CreateGoalScreen> createState() => _CreateGoalScreenState();
}

class _CreateGoalScreenState extends State<CreateGoalScreen> {
  final _nameController = TextEditingController(text: 'M2 MacBook Air Fund');
  final _targetController = TextEditingController(text: '850');
  final _seedController = TextEditingController(text: '100');

  final List<Map<String, String>> _quickIdeas = const [
    {'emoji': '💻', 'label': 'Laptop / Study Tech'},
    {'emoji': '🧳', 'label': 'Semester Break Trip'},
    {'emoji': '🛡️', 'label': 'Emergency Cushion'},
    {'emoji': '📜', 'label': 'Certification Exam'},
    {'emoji': '🎉', 'label': 'Concert & Festivals'},
  ];

  String _selectedHorizon = '6 Months';
  final List<String> _horizons = const ['3 Months', '6 Months', 'By Semester End', '1 Full Year'];

  bool _isMonthly = true;

  @override
  void dispose() {
    _nameController.dispose();
    _targetController.dispose();
    _seedController.dispose();
    super.dispose();
  }

  double _numberFrom(TextEditingController controller) {
    return double.tryParse(controller.text.trim()) ?? 0;
  }

  int get _monthsForHorizon {
    switch (_selectedHorizon) {
      case '3 Months':
        return 3;
      case '1 Full Year':
        return 12;
      case 'By Semester End':
        return 4;
      case '6 Months':
      default:
        return 6;
    }
  }

  @override
  Widget build(BuildContext context) {
    final target = _numberFrom(_targetController);
    final seed = _numberFrom(_seedController);
    final fundedPercent = target == 0 ? 0.0 : (seed / target).clamp(0.0, 1.0);
    final remainingToSave = (target - seed).clamp(0, double.infinity);
    final recommendedMonthly = _monthsForHorizon == 0 ? 0.0 : remainingToSave / _monthsForHorizon;

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
            Text('Create Goal', style: TextStyle(color: AppColors.textDark, fontSize: 18, fontWeight: FontWeight.w700)),
          ],
        ),
        actions: const [
          Padding(padding: EdgeInsets.only(right: 16), child: ProfileAvatar(size: 32)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildHeaderBanner(),
          const SizedBox(height: 20),
          _buildStepOneGoalName(),
          const SizedBox(height: 20),
          _buildStepTwoTargetFunds(fundedPercent),
          const SizedBox(height: 20),
          _buildStepThreeTimeline(recommendedMonthly),
          const SizedBox(height: 20),
          _buildStudentTip(),
          const SizedBox(height: 20),
          _buildPacingRoadmap(),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Create Savings Goal',
            icon: Icons.check_circle_outline,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              '🔒 Zero commitments. You can pause or adjust target anytime.',
              style: TextStyle(fontSize: 12, color: AppColors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBanner() {
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.18), borderRadius: BorderRadius.circular(20)),
            child: const Text('✨ SMART SAVER', style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
          const SizedBox(height: 10),
          const Text('Design your next\nmicro-win',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          const Text('Turn wishful thinking into steady pocket money momentum.',
              style: TextStyle(color: Colors.white70, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildStepOneGoalName() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('Goal Name', 'Step 1 of 3', showStar: true),
          const SizedBox(height: 12),
          Row(
            children: [
              CircleAvatar(backgroundColor: AppColors.lightBlue, child: const Icon(Icons.laptop_mac, color: AppColors.darkGreen)),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _nameController,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: AppColors.lightBlue,
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none),
                    contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text('Quick student ideas', style: TextStyle(fontSize: 12, color: AppColors.grey)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _quickIdeas.map((idea) {
              return GestureDetector(
                onTap: () => setState(() => _nameController.text = idea['label']!),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: AppColors.lightBlue, borderRadius: BorderRadius.circular(20)),
                  child: Text('${idea['emoji']} ${idea['label']}', style: const TextStyle(fontSize: 12)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStepTwoTargetFunds(double fundedPercent) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('Target & Starting Funds', 'Step 2 of 3'),
          const SizedBox(height: 14),
          const Text('How much do you need?', style: TextStyle(fontSize: 13, color: AppColors.grey)),
          const SizedBox(height: 8),
          _MoneyField(controller: _targetController, onChanged: () => setState(() {})),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(child: Text('Initial Seed Deposit (Optional)', style: TextStyle(fontSize: 13, color: AppColors.grey))),
              Text('Head start!', style: TextStyle(fontSize: 12, color: AppColors.mediumGreen, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 8),
          _MoneyField(controller: _seedController, onChanged: () => setState(() {})),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Starting Day 1 with:', style: TextStyle(fontSize: 12, color: AppColors.grey)),
              Text('${(fundedPercent * 100).toStringAsFixed(1)}% funded',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.darkGreen)),
            ],
          ),
          const SizedBox(height: 6),
          SimpleProgressBar(progress: fundedPercent),
        ],
      ),
    );
  }

  Widget _buildStepThreeTimeline(double recommendedMonthly) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('Timeline & Smart Pacing', 'Step 3 of 3'),
          const SizedBox(height: 12),
          const Text('Select target horizon:', style: TextStyle(fontSize: 13, color: AppColors.grey)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _horizons.map((h) {
              final selected = h == _selectedHorizon;
              return GestureDetector(
                onTap: () => setState(() => _selectedHorizon = h),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.darkGreen : AppColors.lightBlue,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(h, style: TextStyle(color: selected ? Colors.white : AppColors.textDark, fontSize: 13)),
                      if (selected) ...[
                        const SizedBox(width: 6),
                        const Icon(Icons.check_circle, color: Colors.white, size: 16),
                      ],
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 18),
          const Text('Auto-save cadence:', style: TextStyle(fontSize: 13, color: AppColors.grey)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _CadenceButton(
                  label: 'Weekly (Bite-sized)',
                  icon: Icons.calendar_view_week,
                  selected: !_isMonthly,
                  onTap: () => setState(() => _isMonthly = false),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _CadenceButton(
                  label: 'Monthly',
                  icon: Icons.calendar_month,
                  selected: _isMonthly,
                  onTap: () => setState(() => _isMonthly = true),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          AppCard(
            color: AppColors.lightBlue,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.bolt, color: AppColors.darkGreen),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('RECOMMENDED DEPOSIT', style: TextStyle(fontSize: 11, color: AppColors.grey, fontWeight: FontWeight.w700)),
                      Text('\$${recommendedMonthly.toStringAsFixed(2)} / month',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.darkGreen)),
                      const SizedBox(height: 6),
                      Text(
                        '✅ 🚀 Looking solid! Saving \$${recommendedMonthly.toStringAsFixed(2)}/mo keeps you steady and prepared without unexpected budget crunches.',
                        style: const TextStyle(fontSize: 12, color: AppColors.textDark),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentTip() {
    return AppCard(
      color: AppColors.lightOrange,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.lightbulb_outline, color: AppColors.orange),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('STUDENT MICRO-TIP', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.orange)),
                SizedBox(height: 4),
                Text(
                  'Breaking savings into bite-sized recurring transfers increases goal completion likelihood by over 80%!',
                  style: TextStyle(fontSize: 12, color: AppColors.textDark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPacingRoadmap() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Pacing Road Map', style: TextStyle(fontWeight: FontWeight.w700)),
              Text('Target: Nov 2024', style: TextStyle(fontSize: 12, color: AppColors.mediumGreen)),
            ],
          ),
          const SizedBox(height: 12),
          const SimpleProgressBar(progress: 0.3),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Kickoff', style: TextStyle(fontSize: 11, color: AppColors.grey)),
              Text('25%', style: TextStyle(fontSize: 11, color: AppColors.grey)),
              Text('Halfway', style: TextStyle(fontSize: 11, color: AppColors.grey)),
              Text('Unlocked 🎉', style: TextStyle(fontSize: 11, color: AppColors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, String stepLabel, {bool showStar = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            if (showStar) const Text(' *', style: TextStyle(color: Colors.red)),
          ],
        ),
        Text(stepLabel, style: const TextStyle(fontSize: 12, color: AppColors.grey)),
      ],
    );
  }
}

class _MoneyField extends StatelessWidget {
  const _MoneyField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (_) => onChanged(),
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
      decoration: InputDecoration(
        prefixText: '\$ ',
        prefixStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.darkGreen),
        filled: true,
        fillColor: AppColors.lightBlue,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}

class _CadenceButton extends StatelessWidget {
  const _CadenceButton({required this.label, required this.icon, required this.selected, required this.onTap});

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected ? Colors.white : AppColors.lightBlue,
          borderRadius: BorderRadius.circular(14),
          border: selected ? Border.all(color: AppColors.darkGreen, width: 1.4) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: selected ? AppColors.darkGreen : AppColors.grey),
            const SizedBox(width: 6),
            Text(label,
                style: TextStyle(
                    fontSize: 12,
                    color: selected ? AppColors.darkGreen : AppColors.grey,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
