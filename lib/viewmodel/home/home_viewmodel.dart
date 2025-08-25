import 'package:e_commerce/model/productsModel/products_model.dart';
import 'package:e_commerce/res/components/constants/data/products.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

class HomeState {
  HomeState({required this.recentSearchItem, required this.searchItem});
  final List<ProductsModel> recentSearchItem;
  final List<ProductsModel> searchItem;

  HomeState copyWith({
    List<ProductsModel>? recentSearchItem,
    List<ProductsModel>? searchItem,
  }) {
    return HomeState(
      recentSearchItem: recentSearchItem ?? this.recentSearchItem,
      searchItem: searchItem ?? this.searchItem,
    );
  }
}

@riverpod
class HomeViewmodel extends _$HomeViewmodel {
  @override
  HomeState build() {
    return HomeState(recentSearchItem: [], searchItem: []);
  }

  void searchProduct(String query) {
    String value = query.toLowerCase();
    if (value.isEmpty) {
      state = state.copyWith(searchItem: []);
    } else {
      state = state.copyWith(
        searchItem: groceryProducts
            .where(
              (element) => element.subSkuName.toLowerCase().contains(value),
            )
            .toList(),
      );
    }
  }

  void addToRecent(ProductsModel product) {
    state = state.copyWith(
      recentSearchItem: [...state.recentSearchItem, product],
    );
  }
}
