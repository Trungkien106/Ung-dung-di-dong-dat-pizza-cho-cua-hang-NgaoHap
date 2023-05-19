import 'package:ngaohap_pizza_app/providers/cart_provider.dart';
import 'package:ngaohap_pizza_app/screens/cart/cart_screen.dart';
import 'package:ngaohap_pizza_app/screens/categories.dart';
import 'package:ngaohap_pizza_app/screens/home_screen.dart';
import 'package:ngaohap_pizza_app/screens/user.dart';
import 'package:ngaohap_pizza_app/widgets/text_widget.dart';
import 'package:ngaohap_pizza_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;

  // final TextEditingController _addressTextController =
  //     TextEditingController(text: '');
  // void dispose() {
  //   _addressTextController.dispose();
  //   super.dispose();
  // }

  final List<Map<String, dynamic>> _pages = [
    {'page': HomeScreen(), 'title': 'Trang chủ'},
    {'page': CategoriesScreen(), 'title': 'Thể loại'},
    {'page': const CartScreen(), 'title': 'Giỏ hàng '},
    {'page': UserScreen(), 'title': 'Người dùng'},
  ];
  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _selectedPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:
                Icon(_selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
            label: "Trang chủ",
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 1
                ? IconlyBold.category
                : IconlyLight.category),
            label: "Thể loại",
          ),
          BottomNavigationBarItem(
            icon: Consumer<CartProvider>(builder: (_, myCart, ch) {
              return badges.Badge(
                badgeAnimation: const badges.BadgeAnimation.slide(
                  toAnimate: true,
                ),
                position: badges.BadgePosition.topEnd(top: -7, end: -7),
                badgeStyle: const badges.BadgeStyle(
                  shape: badges.BadgeShape.circle,
                  badgeColor: Colors.deepPurple,
                ),
                badgeContent: TextWidget(
                  text: myCart.getCartItems.length.toString(),
                  color: Colors.white,
                  textSize: 15,
                ),
                child: Icon(
                    _selectedIndex == 2 ? IconlyBold.bag : IconlyLight.bag),
              );
            }),
            label: "Giỏ hàng",
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
            label: "Người dùng",
          ),
        ],
      ),
    );
  }
}
