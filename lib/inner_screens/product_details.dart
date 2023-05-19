import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ngaohap_pizza_app/consts/firebase_consts.dart';
import 'package:ngaohap_pizza_app/providers/cart_provider.dart';
import 'package:ngaohap_pizza_app/providers/products_provider.dart';
import 'package:ngaohap_pizza_app/providers/viewed_prod_provider.dart';
import 'package:ngaohap_pizza_app/services/configruation.dart';
import 'package:ngaohap_pizza_app/services/global_method.dart';
import 'package:ngaohap_pizza_app/widgets/text_widget.dart';
import 'package:ngaohap_pizza_app/screens/cart/cart_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = "/ProductDetails";
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _quantityTextController = TextEditingController(text: '1');
  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final getCurrProduct = productProvider.findProById(productId);

    double totalPrice =
        getCurrProduct.price * int.parse(_quantityTextController.text);
    bool? _isInCart = cartProvider.getCartItems.containsKey(getCurrProduct.id);

    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        viewedProdProvider.addProductToHistory(productId: productId);
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            leading: InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: () =>
                  Navigator.canPop(context) ? Navigator.pop(context) : null,
              child: Icon(
                IconlyLight.arrowLeft2,
                color: primaryText,
                size: 24,
              ),
            ),
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor),
        body: Column(
          children: [
            Flexible(
              flex: 2,
              child: Image.asset(
                getCurrProduct.imageUrl,
                // fit: BoxFit.fitWidth, //co van ddeef o day
                width: 300.0,
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: TextWidget(
                              text: getCurrProduct.title,
                              color: primaryText,
                              textSize: 25,
                              isTitle: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 15.0, right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextWidget(
                            text:
                                '\$${getCurrProduct.price.toStringAsFixed(2)}',
                            color: Colors.green,
                            textSize: 25,
                            isTitle: true,
                          ),
                          // TextWidget(
                          //   text: '/KG',
                          //   color: Colors.black,
                          //   textSize: 12,
                          //   isTitle: false,
                          // ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                quantityControl(
                                  fct: () {
                                    if (_quantityTextController.text == '1') {
                                      return;
                                    } else {
                                      setState(() {
                                        _quantityTextController.text =
                                            (int.parse(_quantityTextController
                                                        .text) -
                                                    1)
                                                .toString();
                                      });
                                    }
                                  },
                                  color: Colors.grey,
                                  icon: CupertinoIcons.minus,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: TextField(
                                    controller: _quantityTextController,
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(),
                                      ),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]'),
                                      ),
                                    ],
                                    onChanged: (inputhere) {
                                      setState(
                                        () {
                                          if (inputhere.isEmpty) {
                                            _quantityTextController.text = '1';
                                          } else {
                                            return;
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                                // SizedBox(
                                //   width: 5.0,
                                // ),
                                quantityControl(
                                  fct: () {
                                    setState(() {
                                      _quantityTextController.text = (int.parse(
                                                  _quantityTextController
                                                      .text) +
                                              1)
                                          .toString();
                                    });
                                  },
                                  color: Colors.grey,
                                  icon: CupertinoIcons.plus,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          TextWidget(
                            text: "MÔ TẢ CHI TIẾT",
                            color: primaryText,
                            textSize: 24.0,
                            isTitle: false,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          TextWidget(
                              text: getCurrProduct.description,
                              color: primaryText,
                              textSize: 14.0),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    const Spacer(),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 20.0, right: 12.0, left: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        //   borderRadius: const BorderRadius.only(
                        //     topLeft: Radius.circular(20.0),
                        //     topRight: Radius.circular(20.0),
                        //   ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: 'Tổng cộng',
                                  color: primaryBoxx,
                                  textSize: 20.0,
                                  isTitle: true,
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                FittedBox(
                                  child: Row(
                                    children: [
                                      TextWidget(
                                        text:
                                            '\$${totalPrice.toStringAsFixed(2)}',
                                        color: primaryText,
                                        textSize: 20.0,
                                        isTitle: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Flexible(
                            child: Material(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10.0),
                              child: InkWell(
                                onTap: _isInCart
                                    ? null
                                    : () {
                                        final User? user =
                                            authInstance.currentUser;
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
                                            productId: getCurrProduct.id,
                                            quantity: int.parse(
                                                _quantityTextController.text));
                                      },
                                borderRadius: BorderRadius.circular(10.0),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 5.0,
                                      bottom: 15.0,
                                      top: 15.0,
                                      right: 5.0),
                                  child: TextWidget(
                                    text: _isInCart
                                        ? 'Đã thêm'
                                        : "Thêm vào giỏ hàng",
                                    color: Colors.white,
                                    textSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget quantityControl(
      {required fct, required IconData icon, required Color color}) {
    return Flexible(
      flex: 2,
      child: Material(
        borderRadius: BorderRadius.circular(15.0),
        color: color,
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: () {
            fct();
          },
          child: Padding(
            padding: EdgeInsets.all(6.0),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
