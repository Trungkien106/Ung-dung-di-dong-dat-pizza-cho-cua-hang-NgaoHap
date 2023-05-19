import 'package:flutter/material.dart';
import 'package:ngaohap_pizza_app/consts/contss.dart';
import 'package:ngaohap_pizza_app/models/products_model.dart';
import 'package:ngaohap_pizza_app/providers/products_provider.dart';
import 'package:ngaohap_pizza_app/services/configruation.dart';
import 'package:ngaohap_pizza_app/widgets/back_widget.dart';
import 'package:ngaohap_pizza_app/widgets/pizza_items.dart';
import 'package:ngaohap_pizza_app/widgets/back_widget.dart';
import 'package:ngaohap_pizza_app/widgets/text_widget.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class BrowseallScreen extends StatefulWidget {
  static const routeName = "/BrowseallScreen";
  const BrowseallScreen({Key? key}) : super(key: key);

  @override
  State<BrowseallScreen> createState() => _BrowseallScreenState();
}

class _BrowseallScreenState extends State<BrowseallScreen> {
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: TextWidget(
          text: "Tất cả ",
          color: primaryBoxx,
          textSize: 24.0,
          isTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: kBottomNavigationBarHeight,
                child: TextField(
                  focusNode: _searchTextFocusNode,
                  controller: _searchTextController,
                  onChanged: (valuee) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: primaryBoxx, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: primaryBoxx, width: 1),
                      ),
                      hintText: "Bạn muốn tìm Pizza nào ?",
                      prefixIcon: const Icon(Icons.search),
                      suffix: IconButton(
                        onPressed: () {
                          _searchTextController!.clear();
                          _searchTextFocusNode.unfocus();
                        },
                        icon: Icon(
                          Icons.close,
                          color: _searchTextFocusNode.hasFocus
                              ? primaryBoxx
                              : Colors.black,
                        ),
                      )),
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              mainAxisSpacing: 15,
              childAspectRatio: 18 / 25,
              children: List.generate(allProducts.length, (index) {
                return ChangeNotifierProvider.value(
                    value: allProducts[index], child: const PizzaWidget());
              }),
            ),
          ],
        ),
      ),
    );
  }
}
