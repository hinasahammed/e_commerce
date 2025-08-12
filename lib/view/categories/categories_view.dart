import 'package:e_commerce/data/response/status.dart';
import 'package:e_commerce/res/components/constants/data/categories.dart';
import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/res/components/text/label_small_text.dart';
import 'package:e_commerce/res/components/widget/product_card.dart';
import 'package:e_commerce/res/utils/utils.dart';
import 'package:e_commerce/viewmodel/categories/categories_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesView extends ConsumerWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final viewmodel = ref.read(categoriesViewmodelProvider.notifier);
    final size = MediaQuery.sizeOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(title: const Text("Categories")),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
            child: Row(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListView.separated(
                      itemCount: groceryCategories.length,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      separatorBuilder: (context, index) => Divider(
                        color: colorScheme.onPrimary.withValues(alpha: 0.8),
                        thickness: 1,
                        height: 1,
                      ),
                      itemBuilder: (context, index) {
                        final data = groceryCategories[index];
                        return InkWell(
                          onTap: () {
                            viewmodel.fetchSubcategories(data.code);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: LabelSmallText(
                              text: data.title,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center,
                              textColor: colorScheme.onPrimaryContainer,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                Expanded(
                  child: Consumer(
                    builder: (context, ref, child) {
                      final state = ref.watch(categoriesViewmodelProvider);
                      final status = state.subCategoriesStatus;
                      final subCategories = state.subCategories;
                      return switch (status) {
                        Status.initial => const Center(
                          child: LabelLargeText(
                            text: "Select a category to view products",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Status.loading => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        Status.error => const Center(
                          child: Text("Error loading subcategories"),
                        ),
                        Status.completed =>
                          subCategories.isEmpty
                              ? const Center(
                                  child: Text("No subcategories found"),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.only(bottom: 60),
                                  itemCount: subCategories.length,
                                  itemBuilder: (context, index) {
                                    final data = subCategories[index];
                                    final products = viewmodel.getProducts(
                                      data.code,
                                    );
                                    return Padding(
                                      padding: const EdgeInsetsGeometry.only(
                                        bottom: 10,
                                      ),
                                      child: Column(
                                        spacing: 8,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          LabelLargeText(
                                            text: data.subCategoryName,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(
                                            height: 260,
                                            child: ListView.builder(
                                              itemCount: products.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                final product = products[index];
                                                return SizedBox(
                                                  width: 150,
                                                  child: ProductCard(
                                                    code: product.code,
                                                    imageUrl: product.imageUrl,
                                                    name: product.subSkuName,
                                                    desc: product.desc,
                                                    uom: product.uom,
                                                    isVariant:
                                                        product.code ==
                                                        product.variantCode,
                                                    sellingPrice:
                                                        Utils.formatIndianCurrency(
                                                          product.sellingPrice,
                                                        ),
                                                    mrp:
                                                        Utils.formatIndianCurrency(
                                                          product.mrp,
                                                        ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                      };
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
