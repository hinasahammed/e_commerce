import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_commerce/model/productsModel/products_model.dart';
import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/res/components/text/label_medium_text.dart';
import 'package:e_commerce/res/components/text/label_small_text.dart';
import 'package:e_commerce/res/components/widget/quantity_button.dart';
import 'package:e_commerce/res/components/widget/variant_sheet.dart';
import 'package:e_commerce/res/utils/utils.dart';
import 'package:e_commerce/view/productDetails/product_details_view.dart';
import 'package:e_commerce/viewmodel/cart/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({super.key, required this.product});
  final ProductsModel product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final viewmodel = ref.read(cartViewmodelProvider.notifier);
    bool isVariant = product.code == product.variantCode;
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () async {
          await showModalBottomSheet(
            context: context,
            useSafeArea: true,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            sheetAnimationStyle: const AnimationStyle(
              duration: Duration(milliseconds: 600),
              curve: Curves.easeIn,
              reverseDuration: Duration(milliseconds: 400),
              reverseCurve: Curves.easeOut,
            ),
            builder: (context) =>
                ZoomIn(child: ProductDetailsView(product: product)),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: colorScheme.onSurface.withValues(alpha: .1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(product.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Consumer(
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
                        // log(currentItem.code);
                        return isInCart && !isVariant
                            ? QuantityButton(
                                incrementPressed: () =>
                                    viewmodel.incrementQty(product),
                                decrementPressed: () =>
                                    viewmodel.decrementQty(product),
                                quantityCount: qty.toString(),
                              )
                            : InkWell(
                                onTap: () async {
                                  if (isVariant) {
                                    await showModalBottomSheet(
                                      context: context,
                                      showDragHandle: true,
                                      useSafeArea: true,
                                      isScrollControlled: true,
                                      sheetAnimationStyle: const AnimationStyle(
                                        duration: Duration(milliseconds: 600),
                                        curve: Curves.easeIn,
                                        reverseDuration: Duration(
                                          milliseconds: 400,
                                        ),
                                        reverseCurve: Curves.easeOut,
                                      ),
                                      builder: (context) =>
                                          VariantSheet(code: product.code),
                                    );
                                  } else {
                                    viewmodel.addToCart(product);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colorScheme.primary,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      LabelLargeText(
                                        text: "Add",
                                        textColor: colorScheme.onPrimary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      if (isVariant)
                                        Icon(
                                          Icons.keyboard_arrow_up,
                                          color: colorScheme.onPrimary,
                                          size: 18,
                                        ),
                                    ],
                                  ),
                                ),
                              );
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsGeometry.symmetric(
                  horizontal: 6,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5,
                      children: [
                        Expanded(
                          child: LabelMediumText(
                            text: product.subSkuName,
                            lineHeight: 1,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: colorScheme.secondary,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: LabelSmallText(
                            text: "15% OFF",
                            textColor: colorScheme.onSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    LabelSmallText(text: product.uom),
                    const Gap(5),
                    Wrap(
                      spacing: 3,
                      children: [
                        AutoSizeText(
                          minFontSize: 8,
                          maxFontSize: 12,
                          style: textTheme.labelSmall!.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                          Utils.formatIndianCurrency(product.sellingPrice),
                        ),
                        AutoSizeText(
                          minFontSize: 6,
                          maxFontSize: 10,
                          style: textTheme.labelSmall!.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: .5),
                            decoration: TextDecoration.lineThrough,
                          ),
                          Utils.formatIndianCurrency(product.sellingPrice),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
