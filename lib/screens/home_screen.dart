import 'package:ngaohap_pizza_app/consts/contss.dart';
import 'package:ngaohap_pizza_app/inner_screens/cat_screen.dart';
import 'package:ngaohap_pizza_app/inner_screens/product_details.dart';
import 'package:ngaohap_pizza_app/models/products_model.dart';
import 'package:ngaohap_pizza_app/providers/products_provider.dart';
import 'package:ngaohap_pizza_app/screens/orders/orders_screen.dart';
import 'package:ngaohap_pizza_app/services/configruation.dart';
import 'package:ngaohap_pizza_app/inner_screens/browseall_screen.dart';
import 'package:ngaohap_pizza_app/services/global_method.dart';
import 'package:ngaohap_pizza_app/widgets/pizza_items.dart';
import 'package:ngaohap_pizza_app/widgets/text_widget.dart';
import 'package:ngaohap_pizza_app/widgets/pizza_items.dart';
import 'package:ngaohap_pizza_app/screens/categories.dart';
import 'package:ngaohap_pizza_app/widgets/categories_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    return Container(
        color: primaryScreen,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 70.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                child: Row(
                  children: [
                    TextWidget(
                      text: 'Bạn muốn ăn loại Pizza nào ?',
                      color: Colors.black,
                      textSize: 20.0,
                      isTitle: true,
                      letterSpacing: 0.2,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              InkWell(
                onTap: () {
                  // GlobalMethods.navigateTo(
                  //     ctx: context, routeName: CategoriesScreen.routeName);
                  // Navigator.pushNamed(context, CategoryScreen.routeName,
                  //     arguments: catText);
                },
                child: Container(
                  height: 50.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: catInfor.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          children: [
                            Container(
                              //Khung categoreis home
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(left: 15.0),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 127, 127, 1),

                                borderRadius: BorderRadius.circular(17.0),
                                //   border: Border.all(
                                //       color: primaryBoxx.withOpacity(0.7),
                                //       width: 2.0),
                              ),
                              child: Text(
                                (catInfor[index]['catText']),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                //Cột Hồng FreeShip
                height: 140.0,
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(252, 210, 210, 1),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            margin: EdgeInsets.only(top: 15.0),
                          ),
                          Container(
                            //khoảng cách + miễn phí ship + đăt hàng
                            padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                            width: 180.0,
                            child: Column(
                              children: [
                                TextWidget(
                                  text: 'Khoảng cách < 5m',
                                  color: Colors.black,
                                  textSize: 15.0,
                                  letterSpacing: 1.0,
                                  isTitle: true,
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),

                                TextWidget(
                                  text: 'Miễn phí Ship',
                                  color: primaryBoxx,
                                  textSize: 15.0,
                                  letterSpacing: 0.8,
                                  isTitle: true,
                                ),
                                // ),
                                const SizedBox(
                                  height: 13.0,
                                ),
                                Column(
                                  //Button đặt hàng ngay
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
                                      child: const Text(
                                        "ĐẶT HÀNG NGAY",
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      onPressed: () {
                                        GlobalMethods.navigateTo(
                                            ctx: context,
                                            routeName: OrderScreen.routeName);
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            //Hình shiper
                            margin: EdgeInsets.only(left: 200.0), //Ship
                            width: 190.0,
                            child: Image.asset(
                              'assets/images/delivery.png',
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Expanded(child: Container())
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: "NỔI BẬT TRONG TUẦN ",
                      color: Colors.black,
                      textSize: 17.0,
                      isTitle: true,
                    ),
                    // Spacer(),
                    TextButton(
                      onPressed: () {
                        GlobalMethods.navigateTo(
                            ctx: context, routeName: BrowseallScreen.routeName);
                      },
                      child: TextWidget(
                        text: 'Hiển thị tất cả',
                        maxLines: 1,
                        color: Colors.black,
                        textSize: 18.0, //cho nho chu di
                      ),
                    ),
                  ],
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 15.0),
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing:
                    15, // Nó được sử dụng để chỉ định số lượng pixel giữa mỗi widget con được liệt kê trong trục chính.
                // scrollDirection: Axis.horizontal,
                crossAxisCount: 2,

                childAspectRatio: 18 / 25,
                children: List.generate(
                    allProducts.length < 4 ? allProducts.length : 4, (index) {
                  return ChangeNotifierProvider.value(
                      value: allProducts[index], child: PizzaWidget());
                }),
              )
            ],
          ),
        ));
  }
}
