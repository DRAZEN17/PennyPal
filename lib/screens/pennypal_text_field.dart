import 'package:flutter/material.dart';
import 'app_theme.dart';

class PennyPalTextField extends StatefulWidget {
  const PennyPalTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.controller,
    this.obscureText = false,
    this.isPassword = false,
    this.keyboardType,
    this.validator,
  });

  final String hintText;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  State<PennyPalTextField> createState() => _PennyPalTextFieldState();
}

class _PennyPalTextFieldState extends State<PennyPalTextField> {
  late bool _obscured = widget.obscureText;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final borderColor =
        _focused ? AppColors.fieldBorderGreen : AppColors.fieldBorderGreen.withOpacity(0.6);

    return Focus(
      onFocusChange: (has) => setState(() => _focused = has),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscured : false,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        style: AppTextStyles.body,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 15),
          prefixIcon: Icon(widget.prefixIcon, color: AppColors.iconGreen, size: 20),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: Colors.grey,
                    size: 20,
                  ),
                  onPressed: () => setState(() => _obscured = !_obscured),
                )
              : null,
          filled: true,
          fillColor: AppColors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: borderColor, width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.fieldBorderGreen, width: 1.6),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: borderColor, width: 1.2),
          ),
        ),
      ),
    );
  }
}


class PennyPalPrimaryButton extends StatelessWidget {
  const PennyPalPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkGreen,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.4),
              )
            : Text(label, style: AppTextStyles.buttonLabel),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: Divider(color: Colors.grey, thickness: 0.6)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('Or', style: TextStyle(color: AppColors.textHint)),
        ),
        Expanded(child: Divider(color: Colors.grey, thickness: 0.6)),
      ],
    );
  }
}


class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({super.key, required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Center(child: child),
      ),
    );
  }
}
class PennyPalLogo extends StatelessWidget {
  const PennyPalLogo({super.key, this.size = 110});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.fieldBorderGreen.withOpacity(0.6)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 80,
            height: 80,
          ),
        ],
      ),
    );
  }
}
