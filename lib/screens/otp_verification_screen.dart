import 'dart:async';
import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'illustration_header.dart';
import 'pennypal_text_field.dart';
import 'new_password_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  static const int _codeLength = 4;
  static const int _startSeconds = 72; // 01:12

  final List<TextEditingController> _controllers =
      List.generate(_codeLength, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(_codeLength, (_) => FocusNode());

  int _secondsLeft = _startSeconds;
  Timer? _timer;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controllers[0].text = '3'; // mirrors the pre-filled first digit in the design
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsLeft = _startSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft == 0) {
        t.cancel();
        return;
      }
      setState(() => _secondsLeft--);
    });
  }

  String get _formattedTime {
    final m = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  String get _enteredCode => _controllers.map((c) => c.text).join();

  Future<void> _handleContinue() async {
    if (_enteredCode.length < _codeLength) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter the 4-digit code')),
      );
      return;
    }
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NewPasswordScreen()),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('OTP Verification'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              const IllustrationHeader(icon: Icons.phonelink_lock_rounded),
              const SizedBox(height: 24),
              const Center(child: Text('Verification', style: AppTextStyles.screenTitle)),
              const SizedBox(height: 12),
              const Text(
                'The OTP verification code will be sent to you now',
                textAlign: TextAlign.center,
                style: AppTextStyles.subtitle,
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_codeLength, (i) => _otpBox(i)),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _secondsLeft == 0
                        ? () {
                            _startTimer();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Code re-sent')),
                            );
                          }
                        : null,
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have a code? ",
                        style: AppTextStyles.body,
                        children: [
                          TextSpan(
                            text: 'Re-Send',
                            style: TextStyle(
                              color: _secondsLeft == 0
                                  ? AppColors.fieldBorderGreen
                                  : AppColors.fieldBorderGreen.withOpacity(0.4),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(_formattedTime, style: AppTextStyles.body),
                ],
              ),
              const SizedBox(height: 28),
              PennyPalPrimaryButton(
                label: 'Continue',
                isLoading: _isLoading,
                onPressed: _handleContinue,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _otpBox(int index) {
    return SizedBox(
      width: 64,
      height: 64,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.fieldBorderGreen, width: 1.6),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < _codeLength - 1) {
            _focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
          setState(() {});
        },
      ),
    );
  }
}
