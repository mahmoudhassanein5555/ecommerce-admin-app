import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  Function()? onTap;
  String title;
  IconData icon;
  Color? color;
  bool? selected;
  CustomCardWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    required this.color,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: color ?? const Color(0xffC59A44),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.white,
            size: selected == true ? 28 : 24,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: selected == true ? 16 : 14,
              fontWeight: selected == true
                  ? FontWeight.w500
                  : FontWeight.normal,
              fontFamily: 'SwiftBuyBody',
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
