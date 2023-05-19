import 'package:flutter/cupertino.dart';
import 'package:ngaohap_pizza_app/models/viewed_model.dart';

class ViewedProdProvider with ChangeNotifier {
  Map<String, ViewedProModel> _viewedProdlistItems = {};

  Map<String, ViewedProModel> get getViewedProdlistItems {
    return _viewedProdlistItems;
  }

  void addProductToHistory({required String productId}) {
    _viewedProdlistItems.putIfAbsent(
        productId,
        () => ViewedProModel(
            id: DateTime.now().toString(), productId: productId));
    notifyListeners();
  }

  void clearHistory() {
    _viewedProdlistItems.clear();
    notifyListeners();
  }
}
