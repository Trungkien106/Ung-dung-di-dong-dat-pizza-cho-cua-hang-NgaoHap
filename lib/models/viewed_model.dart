import 'package:flutter/cupertino.dart';

class ViewedProModel with ChangeNotifier {
  final String id, productId;

  ViewedProModel({
    required this.id,
    required this.productId,
  });
}
