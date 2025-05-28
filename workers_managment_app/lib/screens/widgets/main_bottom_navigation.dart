import 'package:flutter/material.dart';
import '../../utils/theme.dart';

// ===============================
// CUSTOM BOTTOM NAVIGATION
// ===============================

class CustomBottomNavigation extends StatelessWidget {
  final VoidCallback? onReportsPressed;
  final VoidCallback? onAddReportPressed;
  final VoidCallback? onProfilePressed;

  const CustomBottomNavigation({
    super.key,
    this.onReportsPressed,
    this.onAddReportPressed,
    this.onProfilePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _BottomNavigationBar(
          onReportsPressed: onReportsPressed,
          onProfilePressed: onProfilePressed,
        ),
        Positioned(
          top: -28, 
          left: MediaQuery.of(context).size.width / 2 - 28, 
          child: FloatingActionButton(
            onPressed: onAddReportPressed ??
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Add Report tapped')),
                  );
                },
            backgroundColor: const Color(0xFF8D6E63),
            elevation: 8,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  final VoidCallback? onReportsPressed;
  final VoidCallback? onProfilePressed;

  const _BottomNavigationBar({
    this.onReportsPressed,
    this.onProfilePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F0),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _BottomNavItem(
            icon: Icons.description_outlined,
            label: 'Reports',
            onTap: onReportsPressed ??
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Reports tapped')),
                  );
                },
          ),
          const SizedBox(width: 56), // Space for the floating button
          _BottomNavItem(
            icon: Icons.person_outline,
            label: 'Profile',
            onTap: onProfilePressed ??
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile tapped')),
                  );
                },
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ===============================
// PRIMARY BUTTON
// ===============================

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
                          color: widget.withBorder ? dColor : white),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

// ===============================
// TEXT FIELD
// ===============================

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    this.label,
    required this.validator,
    required this.hintText,
    this.obSecureText = false,
    this.perfix,
    required this.fillColor,
    required this.filled,
  });

  final TextEditingController controller;
  final String? label;
  final String hintText;
  final FormFieldValidator<String?> validator;
  final bool obSecureText;
  final Widget? perfix;
  final Color fillColor;
  final bool filled;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (widget.label != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.label!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: widget.controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator,
            obscureText: widget.obSecureText,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 13.0, horizontal: 16),
              suffixIcon: widget.perfix,
              filled: widget.filled,
              fillColor: widget.fillColor,
              hintText: widget.hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: primary.withOpacity(0.2)),
              ),
              focusColor: primary.withOpacity(0.2),
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