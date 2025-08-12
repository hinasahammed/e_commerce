import 'package:e_commerce/res/components/constants/colors/app_colors.dart';
import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/view/profile/widgets/row_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class OrdersAndPayments extends StatelessWidget {
  const OrdersAndPayments({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.onSurface.withValues(alpha: .1)),
        borderRadius: BorderRadius.circular(10),
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
              text: "ORDERS & PAYMENTS",
              fontWeight: FontWeight.w600,
              textColor: colorScheme.onSurface.withValues(alpha: .8),
            ),
          ),
          Divider(color: colorScheme.onSurface.withValues(alpha: .1)),
          RowItem(
            onTap: () {
              context.push("/orders");
            },
            color: AppColors.blueColor,
            icon: FontAwesomeIcons.shoppingBag,
            title: "My Orders",
            subTitle: "View order history",
          ),
          RowItem(
            color: colorScheme.primary,
            icon: FontAwesomeIcons.wallet,
            title: "My Wallet",
            subTitle: "Manage payments",
          ),
          const RowItem(
            color: AppColors.purpleColor,
            icon: FontAwesomeIcons.addressBook,
            title: "My Addresses",
            subTitle: "Delivery locations",
          ),
        ],
      ),
    );
  }
}
