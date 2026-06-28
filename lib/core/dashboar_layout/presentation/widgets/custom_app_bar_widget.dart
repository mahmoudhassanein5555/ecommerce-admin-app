import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({
    super.key,
    required this.menuItems,
    required this.selectedIndex,
  });

  final List<String> menuItems;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xffC59A44),
      elevation: 0,
      leading: const Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: Icon(Icons.search, color: Color(0xFF493603), size: 26),
      ),
      leadingWidth: 42,
      title: Text(
        menuItems[selectedIndex],
        style: const TextStyle(
          color: Color(0xFF493603),
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: 'SwiftBuyHeading',
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none_outlined),
          color: const Color(0xFF493603),
          iconSize: 26,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.help_outline_rounded),
          color: const Color(0xFF493603),
          iconSize: 26,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          color: const Color(0xFF493603),
          iconSize: 26,
          onPressed: () {},
        ),
        const SizedBox(width: 8),

        Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF493603).withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFF1A1617),
                // backgroundImage: AssetImage('assets/images/admin_profile.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
