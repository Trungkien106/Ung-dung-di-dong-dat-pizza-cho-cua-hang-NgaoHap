import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class BackWidget extends StatefulWidget {
  const BackWidget({Key? key}) : super(key: key);

  @override
  State<BackWidget> createState() => _BackWidgetState();
}

class _BackWidgetState extends State<BackWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(IconlyLight.arrowLeft2, color: Colors.black),
    );
  }
}
