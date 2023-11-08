part of '../login_screen.dart';

class KTextField extends StatelessWidget {
  const KTextField({
    super.key,
    required this.hint,
    this.contentPadding,
    this.suffixIcon,
    this.controller,
    this.obscureText = false,
    this.textInputAction,
    this.inputType,
    this.onSubmitted,
    this.borderRadius = 0,
    this.prefixIcon,
  });

  final String hint;
  final EdgeInsets? contentPadding;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? inputType;
  final Function(String)? onSubmitted;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: obscureText,
          textInputAction: textInputAction,
          keyboardType: inputType,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            fillColor: Colors.white,
            filled: true,
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            hintText: hint,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
          ),
        ),
      ],
    );
  }
}