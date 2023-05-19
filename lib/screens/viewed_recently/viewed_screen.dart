import 'package:flutter/material.dart';
import 'package:ngaohap_pizza_app/providers/viewed_prod_provider.dart';
import 'package:ngaohap_pizza_app/screens/viewed_recently/viewed_widget.dart';
import 'package:ngaohap_pizza_app/services/configruation.dart';
import 'package:ngaohap_pizza_app/services/global_method.dart';
import 'package:ngaohap_pizza_app/widgets/back_widget.dart';
import 'package:ngaohap_pizza_app/widgets/empty_screen.dart';
import 'package:ngaohap_pizza_app/widgets/text_widget.dart';

import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class ViewedScreen extends StatefulWidget {
  static const routeName = "/ViewedScreen";
  const ViewedScreen({Key? key}) : super(key: key);

  @override
  State<ViewedScreen> createState() => _ViewedScreenState();
}

class _ViewedScreenState extends State<ViewedScreen> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    final viewedProdItemsList = viewedProdProvider.getViewedProdlistItems.values
        .toList()
        .reversed
        .toList();

    if (viewedProdItemsList.isEmpty) {
      return EmptyScreen(
        title: 'Hình như bạn chưa xem sản phẩm nào! ',
        subtitle: 'Add something and make happy',
        buttontext: 'Đặt hàng ngay ',
        imagePath: 'assets/images/empty.png',
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                GlobalMethods.warningDialog(
                    title: 'Xóa hết sản phẩm đã xem ?',
                    subtitle: 'Bạn có chắc không ?',
                    fct: () {},
                    context: context);
              },
              icon: Icon(
                IconlyLight.delete,
                color: primaryText,
              ),
            ),
          ],
          leading: const BackWidget(),
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: TextWidget(
            text: 'Lịch sử',
            color: primaryText,
            textSize: 24.0,
          ),
          backgroundColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        ),
        body: ListView.builder(
          itemCount: viewedProdItemsList.length,
          itemBuilder: (ctx, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
              child: ChangeNotifierProvider.value(
                  value: viewedProdItemsList[index], child: ViewedWidget()),
            );
          },
        ),
      );
    }

    ;
  }
}
