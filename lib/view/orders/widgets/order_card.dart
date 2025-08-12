import 'package:e_commerce/res/components/buttons/custom_button.dart';
import 'package:e_commerce/res/components/constants/data/orders_product.dart';
import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/res/components/text/label_medium_text.dart';
import 'package:e_commerce/res/components/widget/status_legend.dart';
import 'package:e_commerce/res/utils/utils.dart';
import 'package:e_commerce/view/orders/widgets/product_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.orderNo,
    required this.dot,
    required this.status,
    required this.total,
    required this.expectedTot,
    required this.address,
  });
  final String orderNo;
  final String dot;
  final String status;
  final String total;
  final String expectedTot;
  final String address;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: colorScheme.onSurface.withValues(alpha: .1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelLargeText(text: orderNo, fontWeight: FontWeight.w600),
                    LabelMediumText(
                      text: dot,
                      textColor: colorScheme.onSurface.withValues(alpha: .6),
                    ),
                  ],
                ),
              ),
              StatusLegend(
                status: Utils.getOrderStatus(status),
                statusColor: Utils.getOrderStatusColor(status),
              ),
            ],
          ),
          Row(
            spacing: 12,
            children: [
              SizedBox(
                width: 100,
                height: 35,
                child: Stack(
                  children: [
                    ...List.generate(
                      groceryOrdersProduct.length <= 3
                          ? groceryOrdersProduct.length
                          : 3,
                      (index) => Positioned(
                        left: index * 20.0,
                        child: ProductImage(
                          imageUrl: groceryOrdersProduct[index],
                        ),
                      ),
                    ),
                    if (groceryOrdersProduct.length > 3)
                      Positioned(
                        left: 3 * 20.0,
                        child: ProductImage(
                          imageUrl: "",
                          isRemaining: true,
                          remainingCount: (groceryOrdersProduct.length - 3)
                              .toString(),
                        ),
                      ),
                  ],
                ),
              ),
              LabelMediumText(
                text: "${groceryOrdersProduct.length} items",
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Total: ",
                        style: textTheme.labelLarge!.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: .6),
                        ),
                      ),
                      TextSpan(
                        text: total,
                        style: textTheme.labelLarge!.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (status != "3" && status != "4")
                Flexible(
                  child: LabelMediumText(
                    text: expectedTot,
                    textColor: colorScheme.primary,
                  ),
                ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                const Icon(Icons.location_on, size: 15),
                Expanded(
                  child: LabelMediumText(
                    text: address,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),
          Row(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (status == "2")
                Expanded(
                  child: CustomButton(
                    height: 40,
                    onPressed: () {},
                    btnIcon: FontAwesomeIcons.truck,
                    btnText: "Track",
                  ),
                ),
              Expanded(
                child: CustomButton(
                  height: 40,
                  onPressed: () {},
                  bgColor: colorScheme.secondary,
                  foregroundColor: colorScheme.onSecondary,
                  btnIcon: Icons.repeat,
                  btnText: "Reorder",
                ),
              ),
              if (status == "0")
                Expanded(
                  child: CustomButton(
                    height: 40,
                    onPressed: () {},
                    bgColor: colorScheme.surface,
                    foregroundColor: colorScheme.error,
                    borderColor: colorScheme.error,
                    btnIcon: FontAwesomeIcons.times,
                    btnText: "Cancel",
                  ),
                ),
              if (status == "3")
                Expanded(
                  child: CustomButton(
                    height: 40,
                    onPressed: () {},
                    btnIcon: FontAwesomeIcons.fileDownload,
                    btnText: "Invoice",
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
