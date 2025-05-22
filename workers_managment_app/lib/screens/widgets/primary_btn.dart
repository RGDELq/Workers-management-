import 'package:flutter/material.dart';
import '../utils/theme.dart';
 
class Primarybtn extends StatefulWidget {
  const Primarybtn({
    super.key,
    required this.text,
    required this.withBorder,
    this.widthFromScreen = 0.9,
    required this.isloading,
    required this.onPressed,
    this.isActive = true,
  });
  final String text;
  final bool withBorder;
  final double widthFromScreen;
  final bool isloading;
  final Function onPressed;
  final bool isActive;
  @override
  State<Primarybtn> createState() => _PrimarybtnState();
}

class _PrimarybtnState extends State<Primarybtn> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (widget.isActive) {
          widget.onPressed();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Container(
          height: 60,
          width: size.width * widget.widthFromScreen,
          decoration: BoxDecoration(
              color: widget.withBorder
                  ? white
                  : widget.isActive
                      ? primary
                      : grey1,
              border: Border.all(
                  color: widget.isActive ? primary : grey1, width: 1),
              borderRadius: BorderRadius.circular(60)),
          child: Center(
            child: widget.isloading
                ? CircularProgressIndicator(
                    color: widget.withBorder ? primary : grey1,
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.text,
                      style: TextStyle(
                          color: widget.withBorder ? darkblue : white),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}