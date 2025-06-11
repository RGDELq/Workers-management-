import 'package:flutter/material.dart';
import '../../utils/theme.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String hintText;
  final FormFieldValidator<String?> validator;
  final bool obSecureText;
  final Widget? perfix;
  final Color fillColor;
  final bool filled;
  
  final dynamic maxLines;

  const TextFieldWidget({
    super.key,
    this.maxLines,
    required this.controller,
    this.label,
    required this.hintText,
    required this.validator,
    this.obSecureText = false,
    this.perfix,
    required this.fillColor,
    required this.filled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Text(
              label!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            obscureText: obSecureText,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 13.0, horizontal: 16),
              suffixIcon: perfix,
              filled: filled,
              fillColor: fillColor,
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: primary.withOpacity(0.2)),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: error),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: primary.withOpacity(0.4)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: primary.withOpacity(0.2)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
