import 'package:e_commerce/res/components/constants/data/products.dart';
import 'package:e_commerce/res/components/field/custom_textformfield.dart';
import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/res/components/text/title_large_text.dart';
import 'package:e_commerce/res/components/widget/product_card.dart';
import 'package:e_commerce/view/search/widget/recent_card.dart';
import 'package:e_commerce/viewmodel/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});

  @override
  ConsumerState<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  final _searchController = TextEditingController();
  final _searchFocus = FocusNode();

  @override
  void initState() {
    _searchFocus.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final viewmodel = ref.read(homeViewmodelProvider.notifier);
    return SizedBox(
      height: size.height,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Row(
              spacing: 12,
              children: [
                CloseButton(),
                TitleLargeText(text: "Search", fontWeight: FontWeight.w600),
              ],
            ),
            const Gap(16),
            CustomTextformField(
              controller: _searchController,
              focusNode: _searchFocus,
              onChanged: (value) {
                viewmodel.searchProduct(value);
                setState(() {});
              },
              prefixIcon: const Icon(Icons.search),
              labelText: "Search groceries...",
            ),
            const Gap(12),
            Consumer(
              builder: (context, ref, child) {
                // final state = ref.watch(homeViewmodelProvider);
                // final recentItem = state.recentSearchItem;
                return Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelLargeText(
                      text: "Recent Search",
                      fontWeight: FontWeight.w600,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: List.generate(
                          5,
                          (index) => RecentCard(
                            imageUrl: groceryProducts[index].imageUrl,
                            name: groceryProducts[index].subSkuName,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const Gap(16),
            if (_searchController.text.isEmpty) ...[
              const Icon(Icons.search, size: 80),
              const LabelLargeText(
                text: "Try searching for a product",
                fontWeight: FontWeight.w600,
              ),
            ] else
              Consumer(
                builder: (context, ref, child) {
                  final searchItem = ref.watch(
                    homeViewmodelProvider.select((value) => value.searchItem),
                  );
                  return searchItem.isNotEmpty
                      ? GridView.builder(
                          itemCount: searchItem.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 270,
                                mainAxisExtent: 260,
                              ),
                          itemBuilder: (context, index) {
                            final data = searchItem[index];
                            return ProductCard(product: data);
                          },
                        )
                      : LabelLargeText(
                          text: "No \"${_searchController.text}\" result found",
                          fontWeight: FontWeight.w600,
                        );
                },
              ),
          ],
        ),
      ),
    );
  }
}
