import 'package:flutter/material.dart';
import '../../utils/theme.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final bool withBorder;
  final double widthFromScreen;
  final bool isLoading;
  final Function onPressed;
  final bool isActive;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.withBorder,
    this.widthFromScreen = 0.9,
    required this.isLoading,
    required this.onPressed,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        if (isActive) onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Container(
          height: 60,
          width: size.width * widthFromScreen,
          decoration: BoxDecoration(
            color: withBorder
                ? white
                : isActive
                    ? primary
                    : grey1,
            border: Border.all(
              color: isActive ? primary : grey1,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(60),
          ),
          child: Center(
            child: isLoading
                ? CircularProgressIndicator(
                    color: withBorder ? primary : grey1,
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: withBorder ? dColor : white,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
