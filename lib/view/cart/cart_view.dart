import 'package:e_commerce/res/components/buttons/custom_button.dart';
import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/res/components/text/label_medium_text.dart';
import 'package:e_commerce/view/cart/widget/bill_row_item.dart';
import 'package:e_commerce/view/cart/widget/cart_item.dart';
import 'package:e_commerce/viewmodel/cart/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final viewmodel = ref.read(cartViewmodelProvider.notifier);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text("Your cart"),
                  actions: [
                    IconButton(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Clear"),
                            content: const Text(
                              "Are you want to clear item from cart?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: const Text("Cancel"),
                              ),
                              CustomButton(
                                height: 40,
                                bgColor: colorScheme.tertiary,
                                onPressed: () {
                                  viewmodel.clearCart();
                                  context.pop();
                                },
                                btnText: "Clear",
                              ),
                            ],
                          ),
                        );
                      },
                      icon: Icon(Icons.delete, color: colorScheme.tertiary),
                    ),
                  ],
                ),
                SliverPadding(
                  padding: const EdgeInsetsGeometry.all(16),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.onSurface.withValues(alpha: .2),
                            blurRadius: 5,
                            spreadRadius: 1,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Consumer(
                        builder: (context, ref, child) {
                          final state = ref.watch(cartViewmodelProvider);
                          final cartItems = state.cartItems;
                          return cartItems.isNotEmpty
                              ? Column(
                                  spacing: 12,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: cartItems
                                      .map(
                                        (data) => CartItem(
                                          product: data.product,
                                          qty: data.qty,
                                        ),
                                      )
                                      .toList(),
                                )
                              : const Center(
                                  child: LabelLargeText(
                                    text: "No items in cart try to add one",
                                  ),
                                );
                        },
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsetsGeometry.all(16),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.onSurface.withValues(alpha: .2),
                            blurRadius: 5,
                            spreadRadius: 1,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Consumer(
                        builder: (context, ref, child) {
                          final state = ref.watch(cartViewmodelProvider);
                          final cartItems = state.cartItems;
                          double itemTotal = cartItems.fold(
                            0.0,
                            (sum, item) => sum + item.product.sellingPrice,
                          );
                          return Column(
                            spacing: 4,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const LabelMediumText(text: "BILL DETAIL"),
                              const Divider(),
                              BillRowItem(
                                title: "Item total",
                                price: itemTotal,
                              ),
                              const BillRowItem(
                                title: "Delivery charge",
                                price: 30,
                              ),
                              const Gap(12),
                              const Divider(),
                              BillRowItem(
                                title: "Total",
                                price: itemTotal + 30,
                                isLast: true,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              border: Border.all(
                color: colorScheme.onSurface.withValues(alpha: .1),
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomButton(
                  width: double.infinity,
                  onPressed: () {},
                  btnText: "Checkout",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
