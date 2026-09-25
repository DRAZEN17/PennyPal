import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'illustration_header.dart';
import 'pennypal_text_field.dart';
import 'otp_verification_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _contactController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _contactController.dispose();
    super.dispose();
  }

  Future<void> _handleSend() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
  
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const OtpVerificationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('Forgot Password'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                const IllustrationHeader(icon: Icons.lock_outline_rounded),
                const SizedBox(height: 24),
                const Center(child: Text('Verify Email', style: AppTextStyles.screenTitle)),
                const SizedBox(height: 12),
                const Text(
                  'Enter your email or phone number then we will send you a code to reset your password',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.subtitle,
                ),
                const SizedBox(height: 28),
                PennyPalTextField(
                  hintText: 'Email/Phone number',
                  prefixIcon: Icons.email_outlined,
                  controller: _contactController,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Enter your email or phone' : null,
                ),
                const SizedBox(height: 28),
                PennyPalPrimaryButton(
                  label: 'Send',
                  isLoading: _isLoading,
                  onPressed: _handleSend,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
