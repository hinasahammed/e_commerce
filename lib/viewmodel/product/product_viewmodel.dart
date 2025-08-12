import 'package:e_commerce/data/response/status.dart';
import 'package:e_commerce/model/productsModel/products_model.dart';
import 'package:e_commerce/res/components/constants/data/products.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_viewmodel.g.dart';

class ProductState {
  ProductState({
    this.variantStatus = Status.initial,
    required this.variantItems,
  });
  final Status variantStatus;
  final List<ProductsModel> variantItems;

  ProductState copyWith({
    Status? variantStatus,
    List<ProductsModel>? variantItems,
  }) {
    return ProductState(
      variantStatus: variantStatus ?? this.variantStatus,
      variantItems: variantItems ?? this.variantItems,
    );
  }
}

@riverpod
class ProductViewmodel extends _$ProductViewmodel {
  @override
  ProductState build() {
    return ProductState(variantItems: []);
  }

  void fecthingVariants(Status status) {
    state = state.copyWith(variantStatus: status);
  }

  void getVariant(int code) {
    state = state.copyWith(variantItems: []);
    fecthingVariants(Status.loading);
    state = state.copyWith(
      variantItems: groceryProducts
          .where((element) => element.variantCode == code)
          .toList(),
    );
    fecthingVariants(Status.completed);
  }
}
