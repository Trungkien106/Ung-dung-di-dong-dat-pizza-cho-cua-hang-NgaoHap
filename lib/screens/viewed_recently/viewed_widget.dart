import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ngaohap_pizza_app/consts/firebase_consts.dart';
import 'package:ngaohap_pizza_app/inner_screens/product_details.dart';
import 'package:ngaohap_pizza_app/models/viewed_model.dart';
import 'package:ngaohap_pizza_app/providers/cart_provider.dart';
import 'package:ngaohap_pizza_app/providers/products_provider.dart';
import 'package:ngaohap_pizza_app/services/configruation.dart';
import 'package:ngaohap_pizza_app/services/global_method.dart';
import 'package:ngaohap_pizza_app/widgets/text_widget.dart';

import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class ViewedWidget extends StatefulWidget {
  const ViewedWidget({Key? key}) : super(key: key);

  @override
  State<ViewedWidget> createState() => _ViewedWidgetState();
}

class _ViewedWidgetState extends State<ViewedWidget> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);

    final viewedProdModel = Provider.of<ViewedProModel>(context);

    final getCurrProduct =
        productProvider.findProById(viewedProdModel.productId);

    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(getCurrProduct.id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          // GlobalMethods.navigateTo(
          //     ctx: context, routeName: ProductDetails.routeName);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              getCurrProduct.imageUrl,
              width: 80.0,
              height: 80.0,
            ),
            const SizedBox(
              width: 12.0,
            ),
            Column(
              children: [
                TextWidget(
                  text: getCurrProduct.title,
                  color: primaryText,
                  textSize: 20.0,
                  isTitle: true,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                TextWidget(
                  text: '\$${getCurrProduct.price.toStringAsFixed(2)}',
                  color: primaryText,
                  textSize: 20.0,
                  isTitle: false,
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Material(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.green,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.0),
                  onTap: _isInCart
                      ? null
                      : () {
                          //de y cai final den context
                          final User? user = authInstance.currentUser;
                          if (user == null) {
                            GlobalMethods.errorDialog(
                                subtitle:
                                    'Nguoi dung khong hop le , vui long dang nhap',
                                context: context);
                          }
                          // if (_isInCart) {
                          //   return;
                          // }
                          cartProvider.addProductsToCart(
                              productId: getCurrProduct.id, quantity: 1);
                        },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      _isInCart ? Icons.check : IconlyBold.plus,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
