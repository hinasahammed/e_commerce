import 'package:animate_do/animate_do.dart';
import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/res/components/text/label_medium_text.dart';
import 'package:e_commerce/res/components/text/label_small_text.dart';
import 'package:e_commerce/res/components/widget/variant_sheet.dart';
import 'package:e_commerce/view/productDetails/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.code,
    required this.imageUrl,
    required this.name,
    required this.desc,
    required this.uom,
    required this.sellingPrice,
    required this.mrp,
    required this.isVariant,
  });
  final int code;
  final String imageUrl;
  final String name;
  final String desc;
  final String uom;
  final String sellingPrice;
  final String mrp;
  final bool isVariant;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
            builder: (context) => ZoomIn(
              child: ProductDetailsView(
                imageUrl: imageUrl,
                subskuName: name,
                desc: desc,
                uom: uom,
                sellingPrice: sellingPrice,
                mrp: mrp,
              ),
            ),
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
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: InkWell(
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
                              reverseDuration: Duration(milliseconds: 400),
                              reverseCurve: Curves.easeOut,
                            ),
                            builder: (context) => VariantSheet(code: code),
                          );
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
                            text: name,
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
                    LabelSmallText(text: uom),
                    const Gap(5),
                    Row(
                      spacing: 3,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LabelMediumText(
                          text: sellingPrice,
                          fontWeight: FontWeight.w600,
                          textColor: colorScheme.primary,
                        ),
                        LabelSmallText(
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
            ],
          ),
        ),
      ),
    );
  }
}
