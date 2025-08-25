import 'package:e_commerce/data/response/status.dart';
import 'package:e_commerce/model/productsModel/products_model.dart';
import 'package:e_commerce/res/components/constants/data/products.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_viewmodel.g.dart';

class CategoriesState {
  CategoriesState({
    this.categoriesProductStatus = Status.initial,
    required this.products,
    this.selectedCategoryCode = 1,
  });
  final Status categoriesProductStatus;
  final List<ProductsModel> products;
  final int selectedCategoryCode;

  CategoriesState copyWith({
    Status? categoriesProductStatus,
    List<ProductsModel>? products,
    int? selectedCategoryCode,
  }) {
    return CategoriesState(
      categoriesProductStatus:
          categoriesProductStatus ?? this.categoriesProductStatus,
      products: products ?? this.products,
      selectedCategoryCode: selectedCategoryCode ?? this.selectedCategoryCode,
    );
  }
}

@riverpod
class CategoriesViewmodel extends _$CategoriesViewmodel {
  @override
  CategoriesState build() {
    return CategoriesState(products: []);
  }

  void fetchingProducts(Status status) {
    state = state.copyWith(categoriesProductStatus: status);
  }

  void fetchProducts(int code) {
    fetchingProducts(Status.loading);
    state = state.copyWith(products: []);
    final list = groceryProducts
        .where(
          (element) =>
              element.subCategoryCode == code &&
              (element.code == element.variantCode || element.variantCode == 0),
        )
        .toList();
    state = state.copyWith(products: list);
    fetchingProducts(Status.completed);
  }

  void changeSelectedCategory(int code) {
    state = state.copyWith(selectedCategoryCode: code);
  }
}
