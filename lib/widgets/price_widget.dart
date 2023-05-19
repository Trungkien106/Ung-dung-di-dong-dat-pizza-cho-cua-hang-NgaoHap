import 'package:flutter/material.dart';
import 'package:ngaohap_pizza_app/services/configruation.dart';
import 'package:ngaohap_pizza_app/widgets/text_widget.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({Key? key, required this.price, required this.textPrice})
      : super(key: key);
  final double price;
  final String textPrice;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: FittedBox(
        child: Row(
          children: [
            TextWidget(
              text: '\$${(price * int.parse(textPrice)).toStringAsFixed(2)}',
              color: Colors.green,
              textSize: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
