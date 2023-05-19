import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier {
  final String id, title, imageUrl, productCategoryName, description;
  final double price;
  final bool isPiece, isDescription;

  ProductModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.productCategoryName,
    required this.description,
    required this.price,
    required this.isPiece,
    required this.isDescription,
  });
}
