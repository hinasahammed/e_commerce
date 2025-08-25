import 'package:e_commerce/data/response/status.dart';
import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/res/components/widget/variant_item_card.dart';
import 'package:e_commerce/viewmodel/product/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class VariantSheet extends ConsumerStatefulWidget {
  const VariantSheet({super.key, required this.code});
  final int code;

  @override
  ConsumerState<VariantSheet> createState() => _VariantSheetState();
}

class _VariantSheetState extends ConsumerState<VariantSheet> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => getVariants());
    super.initState();
  }

  void getVariants() {
    final viemodel = ref.read(productViewmodelProvider.notifier);
    viemodel.getVariant(widget.code);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LabelLargeText(text: "Variants", fontWeight: FontWeight.w600),
            const Gap(12),
            Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(productViewmodelProvider);
                final status = state.variantStatus;
                final variantItems = state.variantItems;
                return switch (status) {
                  Status.initial => Container(),
                  Status.loading => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  Status.error => Container(),
                  Status.completed => Column(
                    spacing: 8,
                    children: variantItems
                        .map((e) => VariantItemCard(product: e))
                        .toList(),
                  ),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
