import 'package:flutter/material.dart';
import 'package:ngaohap_pizza_app/inner_screens/product_details.dart';
import 'package:ngaohap_pizza_app/services/configruation.dart';
import 'package:ngaohap_pizza_app/services/global_method.dart';
import 'package:ngaohap_pizza_app/widgets/text_widget.dart';

import 'package:flutter_iconly/flutter_iconly.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          GlobalMethods.navigateTo(
              ctx: context, routeName: ProductDetails.routeName);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/delivery.png',
              width: 80.0,
              height: 80.0,
            ),
            const SizedBox(
              width: 12.0,
            ),
            Column(
              children: [
                TextWidget(
                  text: 'Pizza Bo Bit tet x12',
                  color: primaryText,
                  textSize: 17.0,
                  isTitle: false,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                TextWidget(
                  text: 'Thanh toán: \$12.98',
                  color: Colors.grey,
                  textSize: 15.0,
                  isTitle: false,
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                children: [
                  TextWidget(
                    text: '03/05/2023',
                    color: primaryText,
                    textSize: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//   return ListTile(
//     subtitle: const Text('Thanh toan: \$12.8'),
//     onTap: () {
//       GlobalMethods.navigateTo(
//           ctx: context, routeName: ProductDetails.routeName);
//     },
//     leading: Container(
//       child: Image.asset(
//         'images/5.png',
//         width: 80.0,
//         fit: BoxFit.fill,
//       ),
//     ),
//     title: TextWidget(
//       text: "Pizza Bo Bam Tekiaki x12",
//       color: primaryText,
//       textSize: 18,
//     ),
//     trailing: TextWidget(
//       text: '03/05/2023',
//       color: primaryText,
//       textSize: 18,
//     ),
//   );
// }
}
