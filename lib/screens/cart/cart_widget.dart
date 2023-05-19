import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:ngaohap_pizza_app/inner_screens/product_details.dart';
import 'package:ngaohap_pizza_app/models/cart_model.dart';
import 'package:ngaohap_pizza_app/models/products_model.dart';
import 'package:ngaohap_pizza_app/providers/cart_provider.dart';
import 'package:ngaohap_pizza_app/providers/products_provider.dart';
import 'package:ngaohap_pizza_app/services/configruation.dart';
import 'package:ngaohap_pizza_app/services/global_method.dart';
import 'package:ngaohap_pizza_app/widgets/price_widget.dart';
import 'package:ngaohap_pizza_app/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key, required this.q}) : super(key: key);
  final int q;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = widget.q.toString();
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final cartModel = Provider.of<CartModel>(context);
    final getCurrProduct = productProvider.findProById(cartModel.productId);

    double totalPrice =
        getCurrProduct.price * int.parse(_quantityTextController.text);
    final cartProvider = Provider.of<CartProvider>(context);
    // Size size = Utils(context).getScreenSize;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: cartModel.productId);
        // GlobalMethods.navigateTo(
        //     ctx: context, routeName: ProductDetails.routeName);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      // color: primaryScreen,
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10.0),
                          height: 110.0,
                          width: 110.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(
                            getCurrProduct.imageUrl, fit: BoxFit.fill,
                            // fit: BoxFit.fill,
                          ),
                        ),
                        Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: getCurrProduct.title,
                              color: primaryText,
                              textSize: 18,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            //////////////////////////////
                            SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  _quantityController(
                                    fct: () {
                                      if (_quantityTextController.text == '1') {
                                        return;
                                      } else {
                                        cartProvider.reduceQuantityByOne(
                                            cartModel.productId);
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
                                              _quantityTextController.text =
                                                  '1';
                                            } else {
                                              return;
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  _quantityController(
                                    fct: () {
                                      cartProvider.increaseQuantityByOne(
                                          cartModel.productId);
                                      setState(() {
                                        _quantityTextController.text =
                                            (int.parse(_quantityTextController
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
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  cartProvider
                                      .removeOneItem(cartModel.productId);
                                },
                                child: const Icon(
                                  CupertinoIcons.delete_solid,
                                  color: primaryBoxx,
                                  size: 25,
                                ),
                              ),
                              const SizedBox(
                                height: 25.0,
                              ),
                              TextWidget(
                                text: '\$${totalPrice.toStringAsFixed(2)}',
                                color: primaryText,
                                textSize: 22,
                                maxLines: 1,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quantityController({
    required Function fct,
    required IconData icon,
    required Color color,
  }) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Material(
          // borderOnForeground: true,
          // color: Colors.green,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                icon,
                color: Colors.grey,
                size: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
