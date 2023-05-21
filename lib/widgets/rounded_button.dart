import 'package:ngaohap_pizza_app/services/configruation.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function fct;
  final Color color, textColor;
  const RoundedButton(
      {Key? key,
      required this.text,
      required this.fct,
      this.color = primaryLogin,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
            backgroundColor: color,
          ),
          onPressed: () {
            fct();
          },
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
