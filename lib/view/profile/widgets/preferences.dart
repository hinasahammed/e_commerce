import 'package:e_commerce/res/components/constants/colors/app_colors.dart';
import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/view/myAdresses/widget/theme_sheet.dart';
import 'package:e_commerce/view/profile/widgets/row_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Preferences extends StatelessWidget {
  const Preferences({super.key});

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
              text: "PREFERENCES",
              fontWeight: FontWeight.w600,
              textColor: colorScheme.onSurface.withValues(alpha: .8),
            ),
          ),
          Divider(color: colorScheme.onSurface.withValues(alpha: .1)),
          RowItem(
            onTap: () async {
              await showModalBottomSheet(
                context: context,
                builder: (context) => const ThemeSheet(),
              );
            },
            color: AppColors.yellowColor,
            icon: FontAwesomeIcons.palette,
            title: "Theme",
            subTitle: "Light mode",
          ),
          const RowItem(
            color: AppColors.pinkColor,
            icon: FontAwesomeIcons.bell,
            title: "Notifications",
            subTitle: "Manage preference",
          ),
        ],
      ),
    );
  }
}
