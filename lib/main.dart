import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngaohap_pizza_app/inner_screens/browseall_screen.dart';
import 'package:ngaohap_pizza_app/inner_screens/cat_screen.dart';
import 'package:ngaohap_pizza_app/inner_screens/product_details.dart';
import 'package:ngaohap_pizza_app/providers/cart_provider.dart';
import 'package:ngaohap_pizza_app/providers/products_provider.dart';
import 'package:ngaohap_pizza_app/providers/viewed_prod_provider.dart';
import 'package:ngaohap_pizza_app/screens/auth/forget_password.dart';
import 'package:ngaohap_pizza_app/screens/auth/login.dart';
import 'package:ngaohap_pizza_app/screens/auth/register.dart';

import 'package:ngaohap_pizza_app/screens/cart/cart_screen.dart';
import 'package:ngaohap_pizza_app/screens/categories.dart';
import 'package:ngaohap_pizza_app/screens/orders/orders_screen.dart';
import 'package:ngaohap_pizza_app/screens/user.dart';
import 'package:ngaohap_pizza_app/screens/home_screen.dart';
import 'package:ngaohap_pizza_app/screens/viewed_recently/viewed_screen.dart';
import 'package:flutter/material.dart';
import 'package:ngaohap_pizza_app/screens/btm_bar.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firebaseInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('An orror occured'),
                ),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => ProductsProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => CartProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => ViewedProdProvider(),
              ),
            ],
            child: (Consumer<ProductsProvider>(
              builder: (context, ProductModel, child) {
                return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'NgaoHap Pizza',
                    home: const BottomBarScreen(),
                    routes: {
                      BrowseallScreen.routeName: (ctx) =>
                          const BrowseallScreen(),
                      ProductDetails.routeName: (ctx) => const ProductDetails(),
                      OrderScreen.routeName: (ctx) => const OrderScreen(),
                      ViewedScreen.routeName: (ctx) => const ViewedScreen(),
                      RegisterScreen.routeName: (ctx) => const RegisterScreen(),
                      LoginScreen.routeName: (ctx) => const LoginScreen(),
                      ForgetPasswordScreen.routeName: (ctx) =>
                          const ForgetPasswordScreen(),
                      CategoryScreen.routeName: (ctx) => const CategoryScreen(),
                    });
              },
            )),
            // MaterialApp(
            //       debugShowCheckedModeBanner: false,
            //       title: 'NgaoHap Pizza',
            //       home: const BottomBarScreen(),
            //       routes: {
            //         BrowseallScreen.routeName: (ctx) => const BrowseallScreen(),
            //         ProductDetails.routeName: (ctx) => const ProductDetails(),
            //         OrderScreen.routeName: (ctx) => const OrderScreen(),
            //         ViewedScreen.routeName: (ctx) => const ViewedScreen(),
            //         RegisterScreen.routeName: (ctx) => const RegisterScreen(),
            //         LoginScreen.routeName: (ctx) => const LoginScreen(),
            //         ForgetPasswordScreen.routeName: (ctx) => const ForgetPasswordScreen(),
            //       }),
            // ),
          );
        });
  }
}
