import 'package:e_commerce/res/components/text/label_medium_text.dart';
import 'package:e_commerce/res/utils/utils.dart';
import 'package:flutter/material.dart';

class BillRowItem extends StatelessWidget {
  const BillRowItem({
    super.key,
    required this.title,
    required this.price,
    this.isLast = false,
  });
  final String title;
  final double price;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LabelMediumText(
          text: title,
          fontWeight: isLast ? FontWeight.w600 : null,
          textColor: isLast
              ? colorScheme.onSurface
              : colorScheme.onSurface.withValues(alpha: .6),
        ),
        LabelMediumText(
          text: Utils.formatIndianCurrency(price),
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
