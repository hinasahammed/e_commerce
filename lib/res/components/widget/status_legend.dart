import 'package:e_commerce/res/components/text/label_medium_text.dart';
import 'package:flutter/material.dart';

class StatusLegend extends StatelessWidget {
  const StatusLegend({
    super.key,
    required this.status,
    required this.statusColor,
  });
  final String status;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: .2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: LabelMediumText(text: status),
    );
  }
}
