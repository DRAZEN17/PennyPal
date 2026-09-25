import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'illustration_header.dart';
import 'pennypal_text_field.dart';
import 'login_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSend() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
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
        title: const Text('New Password'),
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
                const Center(child: Text('Reset Password', style: AppTextStyles.screenTitle)),
                const SizedBox(height: 12),
                const Text(
                  'Enter your new password to reset your password',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.subtitle,
                ),
                const SizedBox(height: 28),
                PennyPalTextField(
                  hintText: 'New password',
                  prefixIcon: Icons.email_outlined,
                  controller: _passwordController,
                  isPassword: true,
                  obscureText: true,
                  validator: (v) =>
                      (v == null || v.length < 6) ? 'Min 6 characters' : null,
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
