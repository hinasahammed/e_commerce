import 'package:e_commerce/res/components/text/label_medium_text.dart';
import 'package:e_commerce/res/components/text/label_small_text.dart';
import 'package:flutter/material.dart';

class VariantItemCard extends StatelessWidget {
  const VariantItemCard({
    super.key,
    required this.imageUrl,
    required this.subskuname,
    required this.uom,
    required this.sellingPrice,
    required this.mrp,
  });
  final String imageUrl;
  final String subskuname;
  final String uom;
  final String sellingPrice;
  final String mrp;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelMediumText(text: subskuname, fontWeight: FontWeight.w500),
                LabelSmallText(
                  text: uom,
                  textColor: colorScheme.onSurface.withValues(alpha: .5),
                ),
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
                      textColor: colorScheme.onSurface.withValues(alpha: .5),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(5),
            ),
            child: LabelMediumText(
              text: "Add",
              textColor: colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
