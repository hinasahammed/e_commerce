import 'package:e_commerce/model/productsModel/products_model.dart';

class CartModel {
  CartModel({String? code, required this.product, required this.qty})
    : code = code ?? "${DateTime.now().millisecondsSinceEpoch}cart";

  final String code;
  final ProductsModel product;
  final int qty;

  CartModel copyWith({ProductsModel? product, int? qty}) {
    return CartModel(
      code: code,
      product: product ?? this.product,
      qty: qty ?? this.qty,
    );
  }
}
