import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_commerce/data/response/status.dart';
import 'package:e_commerce/model/subCategoryParameter/sub_catgeory_parameter.dart';
import 'package:e_commerce/res/components/constants/data/child_category.dart';
import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/res/components/widget/product_card.dart';
import 'package:e_commerce/viewmodel/categories/categories_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubCategoryView extends ConsumerStatefulWidget {
  const SubCategoryView({super.key, required this.parameter});

  final SubCatgeoryParameter parameter;

  @override
  ConsumerState<SubCategoryView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends ConsumerState<SubCategoryView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final viewmodel = ref.read(categoriesViewmodelProvider.notifier);
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.sizeOf(context);
    final childCategories = groceryChildCategory
        .where((element) => element.masterCode == widget.parameter.code)
        .toList();
    return Scaffold(
      appBar: AppBar(title: Text(widget.parameter.categoryName)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    final selectedCategory = ref.watch(
                      categoriesViewmodelProvider.select(
                        (value) => value.selectedCategoryCode,
                      ),
                    );
                    return SizedBox(
                      width: size.width * 0.2,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: colorScheme.onSurface.withValues(
                                alpha: .1,
                              ),
                            ),
                          ),
                        ),
                        child: ListView.separated(
                          itemCount: childCategories.length,
                          padding: const EdgeInsets.only(bottom: 70.0),
                          separatorBuilder: (context, index) => Divider(
                            color: colorScheme.onPrimary.withValues(alpha: 0.8),
                            thickness: 1,
                            height: 1,
                          ),
                          itemBuilder: (context, index) {
                            final data = childCategories[index];
                            final isSelected = selectedCategory == data.code;
                            return InkWell(
                              onTap: () {
                                viewmodel.changeSelectedCategory(data.code);
                                viewmodel.fetchProducts(data.code);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                padding: EdgeInsets.symmetric(
                                  vertical: isSelected ? 12 : 8,
                                ),
                                decoration: BoxDecoration(
                                  border: isSelected
                                      ? Border(
                                          top: BorderSide(
                                            color: colorScheme.primary,
                                          ),
                                        )
                                      : Border.all(
                                          color: colorScheme.onSurface
                                              .withValues(alpha: .05),
                                        ),
                                  gradient: isSelected
                                      ? LinearGradient(
                                          colors: [
                                            colorScheme.primary.withValues(
                                              alpha: .5,
                                            ),
                                            colorScheme.primary.withValues(
                                              alpha: .5,
                                            ),
                                            colorScheme.surface,
                                          ],
                                          stops: const [.1, .3, .5],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        )
                                      : null,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    Transform.scale(
                                      scale: isSelected ? 1 : .7,
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(data.imageUrl),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),

                                    AutoSizeText(
                                      data.name,
                                      minFontSize: 10,
                                      maxFontSize: 18,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.labelSmall!.copyWith(
                                        color: colorScheme.onPrimaryContainer,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),

                Expanded(
                  child: Consumer(
                    builder: (context, ref, child) {
                      final state = ref.watch(categoriesViewmodelProvider);
                      final status = state.categoriesProductStatus;
                      final products = state.products;
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
                          products.isEmpty
                              ? const Center(
                                  child: Text("No subcategories found"),
                                )
                              : GridView.builder(
                                  itemCount: products.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 255,
                                        mainAxisExtent: 280,
                                      ),
                                  itemBuilder: (context, index) {
                                    final product = products[index];
                                    return ProductCard(product: product);
                                  },
                                ),
                      };
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
