import 'package:flutter/material.dart';
import 'package:workers_managment_app/screens/report_form_screen.dart';

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddReportScreen(),
                    ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddReportScreen(),
                    ),
                  );
                },
          ),
          const SizedBox(width: 56), // Space for FAB
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
          Icon(icon, size: 24, color: Colors.grey[600]),
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
