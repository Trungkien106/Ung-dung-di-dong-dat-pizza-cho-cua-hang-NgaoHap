import 'package:ngaohap_pizza_app/inner_screens/product_details.dart';
import 'package:ngaohap_pizza_app/providers/cart_provider.dart';
import 'package:ngaohap_pizza_app/services/configruation.dart';
import 'package:ngaohap_pizza_app/models/products_model.dart';
import 'package:ngaohap_pizza_app/services/global_method.dart';
import 'package:ngaohap_pizza_app/widgets/price_widget.dart';
import 'package:ngaohap_pizza_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PizzaWidget extends StatefulWidget {
  const PizzaWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PizzaWidget> createState() => _PizzaWidgetState();
}

class _PizzaWidgetState extends State<PizzaWidget> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = Utils(context).getScreenSize;
    // double _screenWidth = MediaQuery.of(context).size.width;

    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: productModel.id);
        // GlobalMethods.navigateTo(
        //     ctx: context, routeName: ProductDetails.routeName);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0), //căn lề trái 20
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      // border: Border.all(color: Colors.grey),
                    ),
                    // margin: EdgeInsets.only(top: 42.0),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 28.0, top: 10.0),
                    width: 120.0,
                    height: 120.0,
                    child: Image.asset(
                      productModel.imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                  // SizedBox(
                  //   height: 15.0,
                  // ),
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          margin:
                              EdgeInsets.only(top: 137, bottom: 0.0, left: 0.0),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 1,
                                child: TextWidget(
                                  text: productModel.title,
                                  color: primaryText,
                                  textSize: 15.0,
                                  letterSpacing: 0.9,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Column(
                                children: [
                                  TextWidget(
                                    text: productModel.productCategoryName,
                                    color: Colors.blueGrey,
                                    textSize: 15.0,
                                    letterSpacing: 0.8,
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    PriceWidget(
                                      price: productModel.price,
                                      textPrice: _quantityTextController.text,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 1.0),
                              Column(
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              primaryBoxx),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                      ),
                                    ),
                                    child: TextWidget(
                                      text: _isInCart
                                          ? 'Da them'
                                          : 'Thêm vào giỏ ',
                                      color: Colors.white,
                                      textSize: 15.0,
                                    ),
                                    onPressed: _isInCart
                                        ? null
                                        : () {
                                            // if (_isInCart) {
                                            //   return;
                                            // }
                                            cartProvider.addProductsToCart(
                                                productId: productModel.id,
                                                quantity: int.parse(
                                                    _quantityTextController
                                                        .text));
                                          },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Expanded(child: Container())
          ],
        ),
      ),
    );
  }
}
