import 'package:flutter/material.dart';
import 'package:ngaohap_pizza_app/screens/orders/orders_widget.dart';
import 'package:ngaohap_pizza_app/services/configruation.dart';
import 'package:ngaohap_pizza_app/widgets/back_widget.dart';
import 'package:ngaohap_pizza_app/widgets/empty_screen.dart';
import 'package:ngaohap_pizza_app/widgets/text_widget.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = "/OrderScreen";
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool _isEmpty = true;
  @override
  Widget build(BuildContext context) {
    return _isEmpty == true
        ? EmptyScreen(
            title: 'Bạn chưa có đơn hàng nào cả!',
            subtitle: 'Hãy đặt gì đó và quay lại đây nha!',
            buttontext: 'Đặt hàng ngay ',
            imagePath: 'assets/images/empty.png',
          )
        : Scaffold(
            appBar: AppBar(
              leading: const BackWidget(),
              elevation: 0,
              centerTitle: false,
              title: TextWidget(
                text: 'Đơn đặt hàng (2)',
                color: primaryText,
                textSize: 24.0,
                isTitle: true,
              ),
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            ),
            body: ListView.separated(
              itemCount: 10,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
                  child: OrderWidget(),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: primaryText,
                  thickness: 1,
                );
              },
            ),
          );
  }
}
