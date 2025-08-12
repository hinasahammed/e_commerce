import 'package:e_commerce/res/components/constants/colors/app_colors.dart';
import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/view/profile/widgets/row_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SupportAndLegal extends StatelessWidget {
  const SupportAndLegal({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.onSurface.withValues(alpha: .1)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 16,
              bottom: 8,
            ),
            child: LabelLargeText(
              text: "SUPPORT & LEGAL",
              fontWeight: FontWeight.w600,
              textColor: colorScheme.onSurface.withValues(alpha: .8),
            ),
          ),
          Divider(color: colorScheme.onSurface.withValues(alpha: .1)),
          RowItem(
            color: colorScheme.secondary,
            icon: FontAwesomeIcons.star,
            title: "Rate the App",
            subTitle: "Share your feadback",
          ),
          const RowItem(
            color: AppColors.pinkColor,
            icon: FontAwesomeIcons.questionCircle,
            title: "Help & Support",
            subTitle: "FAQs and contact",
          ),
          const RowItem(
            color: AppColors.tealColor,
            icon: FontAwesomeIcons.fileContract,
            title: "Terms & Privacy",
            subTitle: "Legal information",
          ),
          const RowItem(
            color: AppColors.blueColor,
            icon: FontAwesomeIcons.phoneAlt,
            title: "Terms & Privacy",
            subTitle: "Legal information",
          ),
        ],
      ),
    );
  }
}
