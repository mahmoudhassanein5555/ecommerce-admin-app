import 'package:ecommerce_admin_app/core/dashboar_layout/presentation/widgets/custom_app_bar_widget.dart';
import 'package:ecommerce_admin_app/core/dashboar_layout/presentation/widgets/custom_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;
  List<String> menuItems = [
    'Dashboard',
    "Products",
    "Categories",
    'Orders',
    'Customers',
    'Live Support',
  ];
  List<IconData> icons = [
    Icons.dashboard,
    Icons.shopping_cart,
    Icons.category,
    Icons.list,
    Icons.people,
    Icons.support_agent,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: 300,
            color: const Color(0xffC59A44),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SwiftBuy Dashboard',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'SwiftBuyHeading',
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Enterprise Oversight',
                  style: TextStyle(
                    color: const Color.fromARGB(
                      255,
                      255,
                      255,
                      255,
                    ).withOpacity(0.6),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SwiftBuyBody',
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 50),
                const Text(
                  'Admin Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    return CustomCardWidget(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      title: menuItems[index],
                      icon: icons[index],
                      color: index == selectedIndex
                          ? const Color(0xff9C7B3C)
                          : null,
                      selected: index == selectedIndex ? true : false,
                    );
                  },
                ),
                // const SizedBox(height: 30),
                const Spacer(),

                ElevatedButton(
                  onPressed: () {
                    // Handle new product logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff9C7B3C),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 70,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'New Product',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SwiftBuyBody',
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 64,
                  child: CustomAppBarWidget(
                    menuItems: menuItems,
                    selectedIndex: selectedIndex,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
