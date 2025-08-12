import 'package:flutter/material.dart';

class BarItem extends StatelessWidget {
  const BarItem({
    super.key,
    required this.icon,
    required this.isCurrent,
    this.onTap,
  });
  final IconData icon;
  final bool isCurrent;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isCurrent ? colorScheme.primary : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isCurrent
              ? colorScheme.onPrimary
              : colorScheme.onPrimaryContainer.withValues(alpha: .7),
        ),
      ),
    );
  }
}
