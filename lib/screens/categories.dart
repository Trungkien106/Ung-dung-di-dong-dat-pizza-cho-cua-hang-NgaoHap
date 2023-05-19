import 'package:ngaohap_pizza_app/services/configruation.dart';
import 'package:ngaohap_pizza_app/widgets/categories_widget.dart';

import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
      ),
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 28 / 25,
          crossAxisSpacing: 10, //khoang cach thang dung
          mainAxisSpacing: 10, // khoang cach ngang
          children: List.generate(7, (index) {
            return CategoriesWidget(
              catText: catInfor[index]['catText'],
              imgPath: catInfor[index]['imgPath'],
              color: Colors.grey,
            );
          }),
        ),
      )),
    );
  }
}
