import 'package:flutter/material.dart';

class ArrowBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ArrowBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: onPressed ?? () => Navigator.of(context).pop(),
      ),
    );
  }
}
