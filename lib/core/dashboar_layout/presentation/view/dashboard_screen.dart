import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_app/core/dashboar_layout/presentation/widgets/custom_app_bar_widget.dart';
import 'package:ecommerce_admin_app/core/dashboar_layout/presentation/widgets/custom_card_widget.dart';
import 'package:ecommerce_admin_app/core/di/servicelocator.dart';
import 'package:ecommerce_admin_app/features/categories/presentation/view/categories_screen.dart';
import 'package:ecommerce_admin_app/features/categories/presentation/view_model/categories_bloc.dart';
import 'package:ecommerce_admin_app/features/chats/presentation/view/chat_screen.dart';
import 'package:ecommerce_admin_app/features/chats/presentation/view_model/chats_bloc.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/view/customers_screen.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/view_model/customers_bloc.dart';
import 'package:ecommerce_admin_app/features/orders/presentation/view/orders_view.dart';
import 'package:ecommerce_admin_app/features/orders/presentation/view_model/orders_bloc.dart';
import 'package:ecommerce_admin_app/features/products/presentation/view/products_screen.dart';
import 'package:ecommerce_admin_app/features/products/presentation/view_model/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<void> createNewChatRoom({
    required String userId,
    required String userName,
    required String firstMessageText,
  }) async {
    try {
      final Timestamp currentTimestamp = Timestamp.now();
      final firestore = FirebaseFirestore.instance;
      final batch = firestore.batch();

      // هنا الـ Document ID هيبقى هو الـ ID بتاع العميل الجديد بالظبط
      final roomRef = firestore.collection('chats').doc(userId);

      // مرجع لرسالة جديدة بـ ID عشوائي جوه الـ sub-collection للعميل ده
      final messageRef = roomRef.collection('messages').doc();

      // بيانات الغرفة الرئيسية للعميل الجديد
      final Map<String, dynamic> roomData = {
        "lastMessageText": firstMessageText,
        "lastMessageTime": currentTimestamp,
        "lastSenderId": userId,
        "unreadByAdminCount": 0, // أو 1 لو العميل اللي بادئ والشاشة مقفولة
        "userId": userId,
        "userName": userName,
      };

      // بيانات أول رسالة في الشات
      final Map<String, dynamic> messageData = {
        "attachedId": "product2005",
        "attachedMetaData": {
          "productImageUrl": "http...",
          "productPrice": 250,
          "productTitle": "iPhone15",
        },
        "senderId": userId,
        "senderName": userName,
        "text": firstMessageText,
        "timestamp": currentTimestamp,
      };

      batch.set(roomRef, roomData);
      batch.set(messageRef, messageData);

      await batch.commit();
      print("Chat room created for $userName");
    } catch (e) {
      print("Error creating chat room: $e");
    }
  }

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
                    ).withValues(alpha: 0.6),
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
                //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                ElevatedButton(
                  onPressed: () async {
                    // للتجربة: هنعمل ID عشوائي عشان كل ضغطة تكريت عميل جديد خالص بره
                    final String newUserId =
                        "user_${DateTime.now().millisecondsSinceEpoch}";

                    await createNewChatRoom(
                      userId: newUserId,
                      userName: "Ahmed Ali", // اسم العميل الجديد
                      firstMessageText:
                          "Hello, I want to ask about this product",
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'New chat room created with ID: $newUserId',
                        ),
                      ),
                    );
                  },
                  child: const Text('Create New Customer Chat'),
                ),
                //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
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
                Expanded(
                  child: Builder(
                    builder: (context) {
                      switch (selectedIndex) {
                        case 1:
                          return BlocProvider(
                            create: (context) => getIt<ProductsBloc>(),
                            child: const ProductsScreen(),
                          );
                        case 2:
                          return BlocProvider(
                            create: (context) => getIt<CategoriesBloc>(),
                            child: const CategoriesScreen(),
                          );
                        case 3:
                          return BlocProvider(
                            create: (context) => getIt<OrdersBloc>(),
                            child: const OrdersView(),
                          );
                        case 4:
                          return BlocProvider(
                            create: (context) => getIt<CustomersBloc>(),
                            child: const CustomersScreen(),
                          );
                        case 5:
                          return BlocProvider(
                            create: (context) => getIt<ChatsBloc>(),
                            child: ChatScreen(),
                          );
                        default:
                          return const Center(
                            child: Text(
                              'Welcome to SwiftBuy Dashboard',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                      }
                    },
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
