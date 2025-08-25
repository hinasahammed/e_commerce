import 'package:e_commerce/model/productsModel/products_model.dart';
import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/res/components/text/label_small_text.dart';
import 'package:e_commerce/res/components/widget/quantity_button.dart';
import 'package:e_commerce/res/utils/utils.dart';
import 'package:e_commerce/viewmodel/cart/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItem extends ConsumerWidget {
  const CartItem({super.key, required this.product, required this.qty});
  final ProductsModel product;
  final int qty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final viewmodel = ref.read(cartViewmodelProvider.notifier);
    return Row(
      spacing: 5,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: size.width * .25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelLargeText(
                text: product.subSkuName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
              ),
              LabelSmallText(text: product.uom),
            ],
          ),
        ),
        QuantityButton(
          incrementPressed: () => viewmodel.incrementQty(product),
          decrementPressed: () => viewmodel.decrementQty(product),
          quantityCount: qty.toString(),
        ),
        Expanded(
          child: LabelSmallText(
            text: Utils.formatIndianCurrency(product.sellingPrice),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
