import 'package:flutter/material.dart';

class ArrowBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ArrowBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onPressed ?? () => Navigator.of(context).pop(),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24,
          ),
        ),
      ),
    );
  }
}
