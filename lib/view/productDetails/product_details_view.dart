import 'package:e_commerce/res/components/constants/data/products.dart';
import 'package:e_commerce/res/components/text/body_large_text.dart';
import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/res/components/text/label_medium_text.dart';
import 'package:e_commerce/res/components/text/label_small_text.dart';
import 'package:e_commerce/res/components/widget/product_card.dart';
import 'package:e_commerce/res/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({
    super.key,
    required this.imageUrl,
    required this.subskuName,
    required this.desc,
    required this.uom,
    required this.sellingPrice,
    required this.mrp,
  });

  final String imageUrl;
  final String subskuName;
  final String desc;
  final String uom;
  final String sellingPrice;
  final String mrp;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
                              imageUrl,
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
                                      text: subskuName,
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
                                text: uom,
                                textColor: colorScheme.onSurface.withValues(
                                  alpha: .7,
                                ),
                              ),
                              Row(
                                spacing: 3,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  BodyLargeText(
                                    text: sellingPrice,
                                    fontWeight: FontWeight.w600,
                                    textColor: colorScheme.primary,
                                  ),
                                  LabelLargeText(
                                    text: mrp,
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.w500,
                                    textColor: colorScheme.onSurface.withValues(
                                      alpha: .5,
                                    ),
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
                          text: desc,
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
                                child: ProductCard(
                                  code: data.code,
                                  imageUrl: data.imageUrl,
                                  name: data.subSkuName,
                                  desc: data.desc,
                                  uom: data.uom,
                                  sellingPrice: Utils.formatIndianCurrency(
                                    data.sellingPrice,
                                  ),
                                  mrp: Utils.formatIndianCurrency(data.mrp),
                                  isVariant: data.code == data.variantCode,
                                ),
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
