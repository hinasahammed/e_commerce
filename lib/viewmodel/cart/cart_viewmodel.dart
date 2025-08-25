import 'package:e_commerce/model/cartModel/cart_model.dart';
import 'package:e_commerce/model/productsModel/products_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_viewmodel.g.dart';

class CartState {
  CartState({required this.cartItems});
  final List<CartModel> cartItems;

  CartState copyWith({List<CartModel>? cartItems}) {
    return CartState(cartItems: cartItems ?? this.cartItems);
  }
}

@riverpod
class CartViewmodel extends _$CartViewmodel {
  @override
  CartState build() {
    return CartState(cartItems: []);
  }

  void addToCart(ProductsModel product) {
    state = state.copyWith(
      cartItems: [
        ...state.cartItems,
        CartModel(product: product, qty: 1),
      ],
    );
  }

  bool isInCart(int code) {
    return state.cartItems.any((element) => element.product.code == code);
  }

  void incrementQty(ProductsModel productmodel) {
    final index = state.cartItems.indexWhere(
      (element) => element.product.code == productmodel.code,
    );
    final currentList = state.cartItems;
    if (index >= 0) {
      final currentItem = currentList[index];
      currentList[index] = currentItem.copyWith(qty: currentItem.qty + 1);
      state = state.copyWith(cartItems: currentList);
    }
  }

  void decrementQty(ProductsModel productmodel) {
    final index = state.cartItems.indexWhere(
      (element) => element.product.code == productmodel.code,
    );
    final currentList = state.cartItems;
    if (index >= 0) {
      final currentItem = currentList[index];
      if (currentItem.qty > 1) {
        currentList[index] = currentItem.copyWith(qty: currentItem.qty - 1);
        state = state.copyWith(cartItems: currentList);
      } else {
        state = state.copyWith(cartItems: currentList..removeAt(index));
      }
    }
  }

  void clearCart() {
    state = state.copyWith(cartItems: []);
  }
}
