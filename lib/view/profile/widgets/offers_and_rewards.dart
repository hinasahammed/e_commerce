import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/view/profile/widgets/row_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OffersAndRewards extends StatelessWidget {
  const OffersAndRewards({super.key});

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
              text: "OFFERS & REWARDS",
              fontWeight: FontWeight.w600,
              textColor: colorScheme.onSurface.withValues(alpha: .8),
            ),
          ),
          Divider(color: colorScheme.onSurface.withValues(alpha: .1)),
          RowItem(
            color: colorScheme.secondary,
            icon: FontAwesomeIcons.ticketAlt,
            title: "Coupons & Offers",
            subTitle: "Available promo code",
          ),
          RowItem(
            color: colorScheme.error,
            icon: FontAwesomeIcons.receipt,
            title: "Invoices",
            subTitle: "Download receipt",
          ),
        ],
      ),
    );
  }
}
