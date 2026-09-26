import 'package:flutter/material.dart';
import 'transaction.dart';

class EditTransactionScreen extends StatefulWidget {
  const EditTransactionScreen({super.key, required this.transaction});

  final Transaction transaction;

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  static const primaryGreen = Color(0xFF154808);
  static const bg = Color(0xFFF5F5F5);
  static const errorRed = Color(0xFFD32F2F);

  late TextEditingController typeController;
  late TextEditingController amountController;
  late TextEditingController descriptionController;
  late DateTime selectedDate;

  bool typeError = false;
  bool amountError = false;

  @override
  void initState() {
    super.initState();
    typeController = TextEditingController(text: widget.transaction.title);
    amountController = TextEditingController(text: widget.transaction.amount.toStringAsFixed(0));
    descriptionController = TextEditingController(text: widget.transaction.description);
    selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    typeController.dispose();
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  String formatDate(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  void handleEdit() {
    final amount = double.tryParse(amountController.text.replaceAll(',', ''));

    setState(() {
      typeError = typeController.text.trim().isEmpty;
      amountError = amount == null || amount <= 10;
    });

    if (typeError || amountError) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transaction updated')),
    );
    Navigator.maybePop(context);
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
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.chevron_left, size: 28),
                  ),
                  const Expanded(
                    child: Text(
                      'Edit Transactions',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: primaryGreen.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.sync_alt, color: primaryGreen, size: 40),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'Edit Your transactions and keep your finances organized.',
                      style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.35),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              fieldLabel('Transaction Type'),
              buildField(
                controller: typeController,
                icon: Icons.calendar_view_month,
                error: typeError,
                errorText: 'Please enter a transaction type',
              ),
              const SizedBox(height: 20),
              fieldLabel('Amount'),
              buildField(
                controller: amountController,
                icon: Icons.currency_exchange,
                keyboardType: TextInputType.number,
                error: amountError,
                errorText: 'Please enter a valid amount greater than 10.',
              ),
              const SizedBox(height: 20),
              fieldLabel('Date'),
              buildField(
                controller: TextEditingController(text: formatDate(selectedDate)),
                icon: Icons.calendar_today_outlined,
                readOnly: true,
                onTap: pickDate,
              ),
              const SizedBox(height: 20),
              fieldLabel('Description (Optional)'),
              TextField(
                controller: descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Description..',
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
                  onPressed: handleEdit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text(
                    'Edit Transactions',
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

  Widget fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
    );
  }

  Widget buildField({
    required TextEditingController controller,
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
            suffixIcon: error ? const Icon(Icons.error, color: errorRed, size: 20) : null,
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
            child: Text(errorText, style: const TextStyle(color: errorRed, fontSize: 12)),
          ),
      ],
    );
  }
}
