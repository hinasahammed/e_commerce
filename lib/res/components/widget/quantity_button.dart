import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:flutter/material.dart';

class QuantityButton extends StatelessWidget {
  const QuantityButton({
    super.key,
    this.incrementPressed,
    this.decrementPressed,
    required this.quantityCount,
  });
  final void Function()? incrementPressed;
  final void Function()? decrementPressed;
  final String quantityCount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.primary),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: decrementPressed,
            visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
            icon: Icon(Icons.remove, color: colorScheme.primary, size: 14),
          ),
          LabelLargeText(
            text: quantityCount,
            textColor: colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
          IconButton(
            onPressed: incrementPressed,
            visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
            icon: Icon(Icons.add, color: colorScheme.primary, size: 14),
          ),
        ],
      ),
    );
  }
}
