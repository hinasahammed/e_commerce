import 'package:e_commerce/res/components/text/label_medium_text.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.isRemaining = false,
    this.remainingCount = "0",
  });
  final String imageUrl;
  final double? width;
  final double? height;
  final bool isRemaining;
  final String remainingCount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      alignment: Alignment.center,
      width: width ?? 35,
      height: height ?? 35,
      decoration: BoxDecoration(
        color: colorScheme.onSurface.withValues(alpha: .7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.onPrimary),
        image: isRemaining
            ? null
            : DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
      ),
      child: isRemaining
          ? LabelMediumText(
              text: "+$remainingCount",
              fontWeight: FontWeight.w500,
              textColor: colorScheme.surface,
            )
          : null,
    );
  }
}
