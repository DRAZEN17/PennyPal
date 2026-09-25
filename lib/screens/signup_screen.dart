import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'pennypal_text_field.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _acceptedTerms = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept the Terms & Conditions')),
      );
      return;
    }
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account created!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                const Center(child: PennyPalLogo()),
                const SizedBox(height: 20),
                const Center(child: Text('Sign Up', style: AppTextStyles.screenTitle)),
                const SizedBox(height: 24),
                PennyPalTextField(
                  hintText: 'Full Name',
                  prefixIcon: Icons.person_outline,
                  controller: _nameController,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter your name' : null,
                ),
                const SizedBox(height: 14),
                PennyPalTextField(
                  hintText: 'Mobile Number',
                  prefixIcon: Icons.phone_outlined,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (v) => (v == null || v.trim().length < 7) ? 'Enter a valid number' : null,
                ),
                const SizedBox(height: 14),
                PennyPalTextField(
                  hintText: 'Email Address',
                  prefixIcon: Icons.email_outlined,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
                ),
                const SizedBox(height: 14),
                PennyPalTextField(
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  controller: _passwordController,
                  isPassword: true,
                  obscureText: true,
                  validator: (v) => (v == null || v.length < 6) ? 'Min 6 characters' : null,
                ),
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _acceptedTerms,
                      activeColor: AppColors.fieldBorderGreen,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      onChanged: (v) => setState(() => _acceptedTerms = v ?? false),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: RichText(
                          text: const TextSpan(
                            style: AppTextStyles.body,
                            children: [
                              TextSpan(text: 'I accept all the '),
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                PennyPalPrimaryButton(
                  label: 'Sign up',
                  isLoading: _isLoading,
                  onPressed: _handleSignUp,
                ),
                const SizedBox(height: 24),
                const OrDivider(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialLoginButton(
                      onTap: () {},
                      child: const Text('G',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent)),
                    ),
                    const SizedBox(width: 24),
                    SocialLoginButton(
                      onTap: () {},
                      child: const Icon(Icons.facebook, color: Color(0xFF1877F2), size: 32),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account? ', style: AppTextStyles.body),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      ),
                      child: const Text('Login', style: AppTextStyles.linkBold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
