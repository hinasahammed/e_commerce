import 'package:e_commerce/model/productsModel/products_model.dart';
import 'package:e_commerce/res/components/text/label_medium_text.dart';
import 'package:e_commerce/res/components/text/label_small_text.dart';
import 'package:e_commerce/res/components/widget/quantity_button.dart';
import 'package:e_commerce/res/utils/utils.dart';
import 'package:e_commerce/viewmodel/cart/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VariantItemCard extends ConsumerWidget {
  const VariantItemCard({super.key, required this.product});
  final ProductsModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final viewmodel = ref.read(cartViewmodelProvider.notifier);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.onSurface.withValues(alpha: .1)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 5,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200,
              image: DecorationImage(
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelMediumText(
                  text: product.subSkuName,
                  fontWeight: FontWeight.w500,
                ),
                LabelSmallText(
                  text: product.uom,
                  textColor: colorScheme.onSurface.withValues(alpha: .5),
                ),
                Row(
                  spacing: 3,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LabelMediumText(
                      text: Utils.formatIndianCurrency(product.sellingPrice),
                      fontWeight: FontWeight.w600,
                      textColor: colorScheme.primary,
                    ),
                    LabelSmallText(
                      text: Utils.formatIndianCurrency(product.mrp),
                      decoration: TextDecoration.lineThrough,
                      fontWeight: FontWeight.w500,
                      textColor: colorScheme.onSurface.withValues(alpha: .5),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(cartViewmodelProvider);
              final cartItems = state.cartItems;
              final isInCart = cartItems.any(
                (element) => element.product.code == product.code,
              );
              int qty;
              if (isInCart) {
                final currentItem = cartItems.firstWhere(
                  (element) => element.product.code == product.code,
                );
                qty = currentItem.qty;
              } else {
                qty = 0;
              }
              return isInCart
                  ? QuantityButton(
                      incrementPressed: () => viewmodel.incrementQty(product),
                      decrementPressed: () => viewmodel.decrementQty(product),
                      quantityCount: qty.toString(),
                    )
                  : InkWell(
                      onTap: () => viewmodel.addToCart(product),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: LabelMediumText(
                          text: "Add",
                          textColor: colorScheme.onPrimary,
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
