import 'package:flutter/material.dart';
import 'package:ngaohap_pizza_app/services/configruation.dart';

class EmptyProdWidget extends StatelessWidget {
  const EmptyProdWidget({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(18.0),
              child: Image.asset('assets/images/sold_out.png'),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryText,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
