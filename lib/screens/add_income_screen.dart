import 'package:flutter/material.dart';
import 'income_added_screen.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  static const Color primaryGreen = Color(0xFF154808);
  static const Color bg = Color(0xFFF5F5F5);
  static const Color errorRed = Color(0xFFD32F2F);

  final _sourceController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  bool _sourceError = false;
  bool _amountError = false;

  static const List<Map<String, dynamic>> _sources = [
    {'label': 'Salary', 'icon': Icons.calendar_view_month},
    {'label': 'Business', 'icon': Icons.storefront_outlined},
    {'label': 'Freelance', 'icon': Icons.laptop_mac_outlined},
    {'label': 'Gift', 'icon': Icons.card_giftcard_outlined},
    {'label': 'Other', 'icon': Icons.more_horiz},
  ];

  void _pickSource() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _sources.map((s) {
            return ListTile(
              leading: Icon(s['icon'] as IconData, color: primaryGreen),
              title: Text(s['label'] as String),
              onTap: () {
                setState(() {
                  _sourceController.text = s['label'] as String;
                  _sourceError = false;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  String _formatDate(DateTime d) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }

  void _handleSave() {
    final amount = double.tryParse(_amountController.text.replaceAll(',', ''));

    setState(() {
      _sourceError = _sourceController.text.trim().isEmpty;
      _amountError = amount == null || amount <= 10;
    });

    if (_sourceError || _amountError) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => IncomeAddedScreen(
          amount: amount!,
          source: _sourceController.text,
          date: _selectedDate,
          description: _descriptionController.text,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _sourceController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.chevron_left, size: 28),
                  ),
                  const Expanded(
                    child: Text(
                      'Add Income',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(width: 48), // balances the back button
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TODO: swap for your real illustration/icon asset
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [primaryGreen, Colors.black],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      "Add money you've received and keep your finances organized.",
                      style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.35),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              _fieldLabel('INCOME SOURCE'),
              _buildField(
                controller: _sourceController,
                hint: 'Select income source',
                icon: Icons.calendar_view_month,
                readOnly: true,
                onTap: _pickSource,
                error: _sourceError,
                errorText: 'Please select an income source',
              ),
              const SizedBox(height: 20),

              _fieldLabel('AMOUNT'),
              _buildField(
                controller: _amountController,
                hint: 'Enter amount',
                icon: Icons.currency_exchange,
                keyboardType: TextInputType.number,
                error: _amountError,
                errorText: 'Please enter a valid amount greater than 10.',
              ),
              const SizedBox(height: 20),

              _fieldLabel('DATE'),
              _buildField(
                controller: TextEditingController(text: _formatDate(_selectedDate)),
                hint: '',
                icon: Icons.calendar_today_outlined,
                readOnly: true,
                onTap: _pickDate,
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  _fieldLabel('DESCRIPTION'),
                  const SizedBox(width: 6),
                  const Text('(Optional)', style: TextStyle(color: Colors.black54)),
                ],
              ),
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Monthly salary payment',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: primaryGreen),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: primaryGreen),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: primaryGreen, width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _handleSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Save Income',
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

  Widget _fieldLabel(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 0.4),
        ),
      );

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool readOnly = false,
    VoidCallback? onTap,
    TextInputType? keyboardType,
    bool error = false,
    String? errorText,
  }) {
    final borderColor = error ? errorRed : primaryGreen;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.black87, size: 20),
            suffixIcon: error
                ? const Icon(Icons.error, color: errorRed, size: 20)
                : null,
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: borderColor, width: 1.5),
            ),
          ),
        ),
        if (error && errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Row(
              children: [
                const Icon(Icons.error, color: errorRed, size: 14),
                const SizedBox(width: 4),
                Text(errorText, style: const TextStyle(color: errorRed, fontSize: 12)),
              ],
            ),
          ),
      ],
    );
  }
}