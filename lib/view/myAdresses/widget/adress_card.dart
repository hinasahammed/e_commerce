import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/res/components/text/label_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class AdressCard extends StatelessWidget {
  const AdressCard({
    super.key,
    required this.leadingIcon,
    required this.iconColor,
    required this.title,
  });
  final IconData leadingIcon;
  final Color iconColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.onSurface.withValues(alpha: .1)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 12,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: .2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(leadingIcon, color: iconColor),
              ),
              LabelLargeText(text: title, fontWeight: FontWeight.w600),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
            ],
          ),
          const Gap(10),
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: LabelMediumText(
                  text:
                      "456 Business Ave Suite 200 New York, NY 10002 John Doe • +1 (555) 987-6543",
                  textColor: colorScheme.onSurface.withValues(alpha: .8),
                ),
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  FontAwesomeIcons.mapMarkedAlt,
                  color: colorScheme.onSurface.withValues(alpha: .5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
