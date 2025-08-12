import 'package:e_commerce/data/response/status.dart';
import 'package:e_commerce/model/productsModel/products_model.dart';
import 'package:e_commerce/model/subCategoriesModel/sub_categories_model.dart';
import 'package:e_commerce/res/components/constants/data/products.dart';
import 'package:e_commerce/res/components/constants/data/sub_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_viewmodel.g.dart';

class CategoriesState {
  final Status categoriesProductStatus;
  final Status subCategoriesStatus;
  final List<ProductsModel> products;
  final List<SubCategoriesModel> subCategories;

  CategoriesState({
    this.categoriesProductStatus = Status.initial,
    this.subCategoriesStatus = Status.initial,
    required this.products,
    required this.subCategories,
  });

  CategoriesState copyWith({
    Status? categoriesProductStatus,
    Status? subCategoriesStatus,
    List<ProductsModel>? products,
    List<SubCategoriesModel>? subCategories,
  }) {
    return CategoriesState(
      categoriesProductStatus:
          categoriesProductStatus ?? this.categoriesProductStatus,
      subCategoriesStatus: subCategoriesStatus ?? this.subCategoriesStatus,
      products: products ?? this.products,
      subCategories: subCategories ?? this.subCategories,
    );
  }
}

@riverpod
class CategoriesViewmodel extends _$CategoriesViewmodel {
  @override
  CategoriesState build() {
    return CategoriesState(products: [], subCategories: []);
  }

  void fetchingsubCategories(Status status) {
    state = state.copyWith(subCategoriesStatus: status);
  }

  void fetchingCategoryProduct(Status status) {
    state = state.copyWith(categoriesProductStatus: status);
  }

  List<ProductsModel> getProducts(int code) {
    final list = groceryProducts
        .where(
          (element) =>
              element.subCategoryCode == code &&
              (element.code == element.variantCode || element.variantCode == 0),
        )
        .toList();
    return list;
  }

  void fetchSubcategories(int code) {
    state = state.copyWith(subCategories: []);
    fetchingsubCategories(Status.loading);
    state = state.copyWith(
      subCategories: grocerySubCategories
          .where((element) => element.masterCode == code)
          .toList(),
    );
    fetchingsubCategories(Status.completed);
  }
}
