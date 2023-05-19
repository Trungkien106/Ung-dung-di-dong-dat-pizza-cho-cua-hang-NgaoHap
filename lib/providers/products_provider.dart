import 'package:flutter/cupertino.dart';
import 'package:ngaohap_pizza_app/models/products_model.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductModel> get getProducts {
    return _productsList;
  }

  ProductModel findProById(String productId) {
    return _productsList.firstWhere((element) => element.id == productId);
  }

  List<ProductModel> findByCategory(String categoryName) {
    List<ProductModel> _categoryList = _productsList
        .where((element) => element.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return _categoryList;
  }

  static final List<ProductModel> _productsList = [
    // ProductModel(
    //   id: 'Bo_Cali',
    //   title: 'Bò Cali',
    //   imageUrl: 'assets/images/pizza/bo_cali.png',
    //   productCategoryName: 'California',
    //   description:
    //       'Lorem Ipsum chỉ đơn giản là một đoạn văn bản giả, được dùng vào việc trình bày và dàn trang phục vụ cho in ấn. Lorem Ipsum đã được sử dụng như một văn bản chuẩn cho ngành công nghiệp',
    //   price: 0.98,
    //   isPiece: true,
    //   isDescription: false,
    // ),
    ProductModel(
      id: 'Bo_Vien_NeaPol',
      title: 'Bò viên NeaPol',
      imageUrl: 'assets/images/pizza/bovien_nplt.png',
      productCategoryName: 'Neapolitian',
      description:
          'Lorem Ipsum chỉ đơn giản là một đoạn văn bản giả, được dùng vào việc trình bày và dàn trang phục vụ cho in ấn. Lorem Ipsum đã được sử dụng như một văn bản chuẩn cho ngành công nghiệp',
      price: 1.12,
      isPiece: true,
      isDescription: false,
    ),
    ProductModel(
      id: 'Ca_chua_Chicago',
      title: 'Cà chua Chicago',
      imageUrl: 'assets/images/pizza/cachua_ccg.png',
      productCategoryName: 'Chicago',
      description:
          'Lorem Ipsum chỉ đơn giản là một đoạn văn bản giả, được dùng vào việc trình bày và dàn trang phục vụ cho in ấn. Lorem Ipsum đã được sử dụng như một văn bản chuẩn cho ngành công nghiệp',
      price: 0.63,
      isPiece: true,
      isDescription: false,
    ),
    ProductModel(
      id: 'Pho_mai_Greek',
      title: 'Phô mai Greek',
      imageUrl: 'assets/images/pizza/phomai_gre.png',
      productCategoryName: 'Greek',
      description:
          'Lorem Ipsum chỉ đơn giản là một đoạn văn bản giả, được dùng vào việc trình bày và dàn trang phục vụ cho in ấn. Lorem Ipsum đã được sử dụng như một văn bản chuẩn cho ngành công nghiệp',
      price: 0.72,
      isPiece: true,
      isDescription: false,
    ),
    ProductModel(
      id: 'Pho_mai_Newyork',
      title: 'Phô mai Newyork',
      imageUrl: 'assets/images/pizza/phomai_ny.png',
      productCategoryName: 'Newyork',
      description:
          'Lorem Ipsum chỉ đơn giản là một đoạn văn bản giả, được dùng vào việc trình bày và dàn trang phục vụ cho in ấn. Lorem Ipsum đã được sử dụng như một văn bản chuẩn cho ngành công nghiệp',
      price: 1.29,
      isPiece: true,
      isDescription: false,
    ),
    ProductModel(
      id: 'Rau_Sicilian',
      title: 'Rau Sicilian',
      imageUrl: 'assets/images/pizza/rau_sici.png',
      productCategoryName: 'Sicilian',
      description:
          'Lorem Ipsum chỉ đơn giản là một đoạn văn bản giả, được dùng vào việc trình bày và dàn trang phục vụ cho in ấn. Lorem Ipsum đã được sử dụng như một văn bản chuẩn cho ngành công nghiệp',
      price: 1.52,
      isPiece: true,
      isDescription: false,
    ),
    ProductModel(
      id: 'Trung_Detroit',
      title: 'Trứng Detroit',
      imageUrl: 'assets/images/pizza/trung_detro.png',
      productCategoryName: 'Detroit',
      description:
          'Lorem Ipsum chỉ đơn giản là một đoạn văn bản giả, được dùng vào việc trình bày và dàn trang phục vụ cho in ấn. Lorem Ipsum đã được sử dụng như một văn bản chuẩn cho ngành công nghiệp',
      price: 1.87,
      isPiece: true,
      isDescription: false,
    ),
  ];
}
