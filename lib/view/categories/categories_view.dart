import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_commerce/model/subCategoryParameter/sub_catgeory_parameter.dart';
import 'package:e_commerce/res/components/constants/data/categories.dart';
import 'package:e_commerce/res/components/constants/data/sub_categories.dart';
import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CategoriesView extends ConsumerStatefulWidget {
  const CategoriesView({super.key});

  @override
  ConsumerState<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends ConsumerState<CategoriesView> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(title: const Text("Categories")),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
              bottom: 100,
            ),
            itemCount: groceryCategories.length,
            shrinkWrap: true,
            separatorBuilder: (context, index) => const Gap(10),
            itemBuilder: (context, index) {
              final category = groceryCategories[index];
              final subCategory = grocerySubCategories
                  .where((element) => element.masterCode == category.code)
                  .toList();
              return Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelLargeText(
                    text: category.title,
                    fontWeight: FontWeight.w600,
                  ),
                  GridView.builder(
                    itemCount: subCategory.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 80,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          mainAxisExtent: 110,
                        ),
                    itemBuilder: (context, index) {
                      final subcategoryITem = subCategory[index];
                      return InkWell(
                        onTap: () {
                          context.push(
                            "/sub_category",
                            extra: SubCatgeoryParameter(
                              code: subcategoryITem.code,
                              categoryName: subcategoryITem.subCategoryName,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            spacing: 8,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(10),
                                child: Image.network(
                                  subcategoryITem.imageUrl,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              AutoSizeText(
                                subcategoryITem.subCategoryName,
                                minFontSize: 10,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.labelMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                                maxFontSize: 11,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
