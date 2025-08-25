import 'package:e_commerce/model/productsModel/products_model.dart';
import 'package:e_commerce/res/components/constants/data/products.dart';
import 'package:e_commerce/res/components/text/body_large_text.dart';
import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/res/components/text/label_medium_text.dart';
import 'package:e_commerce/res/components/text/label_small_text.dart';
import 'package:e_commerce/res/components/widget/product_card.dart';
import 'package:e_commerce/res/components/widget/quantity_button.dart';
import 'package:e_commerce/res/components/widget/variant_sheet.dart';
import 'package:e_commerce/res/utils/utils.dart';
import 'package:e_commerce/viewmodel/cart/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsView extends ConsumerWidget {
  const ProductDetailsView({super.key, required this.product});

  final ProductsModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final viewmodel = ref.read(cartViewmodelProvider.notifier);
    final isVariant = product.code == product.variantCode;
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 1.0,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 4),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.onSurface.withValues(alpha: .3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              product.imageUrl,
                              width: double.infinity,
                              height: 300,
                              fit: BoxFit.contain,
                            ),
                            Positioned(
                              left: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            border: Border.all(
                              color: colorScheme.onSurface.withValues(
                                alpha: .1,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.onSurface.withValues(
                                  alpha: .15,
                                ),
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                spacing: 10,
                                children: [
                                  Expanded(
                                    child: LabelLargeText(
                                      text: product.subSkuName,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 2,
                                    ),
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
                              LabelMediumText(
                                text: product.uom,
                                textColor: colorScheme.onSurface.withValues(
                                  alpha: .7,
                                ),
                              ),
                              Row(
                                spacing: 3,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  BodyLargeText(
                                    text: Utils.formatIndianCurrency(
                                      product.sellingPrice,
                                    ),
                                    fontWeight: FontWeight.w600,
                                    textColor: colorScheme.primary,
                                  ),
                                  LabelLargeText(
                                    text: Utils.formatIndianCurrency(
                                      product.mrp,
                                    ),
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.w500,
                                    textColor: colorScheme.onSurface.withValues(
                                      alpha: .5,
                                    ),
                                  ),
                                  const Spacer(),
                                  Consumer(
                                    builder: (context, ref, child) {
                                      final state = ref.watch(
                                        cartViewmodelProvider,
                                      );
                                      final cartItems = state.cartItems;
                                      final isInCart = cartItems.any(
                                        (element) =>
                                            element.product.code ==
                                            product.code,
                                      );
                                      int qty;
                                      if (isInCart) {
                                        final currentItem = cartItems
                                            .firstWhere(
                                              (element) =>
                                                  element.product.code ==
                                                  product.code,
                                            );
                                        qty = currentItem.qty;
                                      } else {
                                        qty = 0;
                                      }
                                      // log(currentItem.code);
                                      return isInCart && !isVariant
                                          ? QuantityButton(
                                              incrementPressed: () => viewmodel
                                                  .incrementQty(product),
                                              decrementPressed: () => viewmodel
                                                  .decrementQty(product),
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
                                                    sheetAnimationStyle:
                                                        const AnimationStyle(
                                                          duration: Duration(
                                                            milliseconds: 600,
                                                          ),
                                                          curve: Curves.easeIn,
                                                          reverseDuration:
                                                              Duration(
                                                                milliseconds:
                                                                    400,
                                                              ),
                                                          reverseCurve:
                                                              Curves.easeOut,
                                                        ),
                                                    builder: (context) =>
                                                        VariantSheet(
                                                          code: product.code,
                                                        ),
                                                  );
                                                } else {
                                                  viewmodel.addToCart(product);
                                                }
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 6,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: colorScheme.primary,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Row(
                                                  children: [
                                                    LabelLargeText(
                                                      text: "Add",
                                                      textColor:
                                                          colorScheme.onPrimary,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    if (isVariant)
                                                      Icon(
                                                        Icons.keyboard_arrow_up,
                                                        color: colorScheme
                                                            .onPrimary,
                                                        size: 18,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Gap(12),
                        const LabelLargeText(
                          text: "Description",
                          fontWeight: FontWeight.w600,
                        ),
                        LabelMediumText(
                          text: product.desc,
                          textColor: colorScheme.onSurface.withValues(
                            alpha: .8,
                          ),
                        ),
                        const Gap(12),
                        const LabelLargeText(
                          text: "Similar Product",
                          fontWeight: FontWeight.w600,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(5, (index) {
                              final data = groceryProducts[index];
                              return SizedBox(
                                width: 150,
                                child: ProductCard(product: data),
                              );
                            }),
                          ),
                        ),
                        const Gap(20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
