import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/res/components/constants/data/banners.dart';
import 'package:e_commerce/res/components/constants/data/categories.dart';
import 'package:e_commerce/res/components/constants/data/products.dart';
import 'package:e_commerce/res/components/text/body_large_text.dart';
import 'package:e_commerce/res/components/text/label_medium_text.dart';
import 'package:e_commerce/res/components/text/label_small_text.dart';
import 'package:e_commerce/res/components/text/title_large_text.dart';
import 'package:e_commerce/res/components/widget/product_card.dart';
import 'package:e_commerce/view/search/search_view.dart';
import 'package:e_commerce/viewmodel/categories/categories_viewmodel.dart';
import 'package:e_commerce/viewmodel/customNavigation/custom_navigation_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.sizeOf(context);
    final navigationViewmodel = ref.read(
      customNavigationViewmodelProvider.notifier,
    );
    final categoryViewmodel = ref.read(categoriesViewmodelProvider.notifier);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: Icon(Icons.shopping_basket, color: colorScheme.primary),
          title: const TitleLargeText(
            text: "Fresh Cart",
            fontWeight: FontWeight.w600,
          ),
          actions: [
            Icon(Icons.location_on, color: colorScheme.primary),
            const LabelSmallText(text: "Downtown"),
            ExpandIcon(onPressed: (value) {}),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    await showModalBottomSheet(
                      context: context,
                      useSafeArea: true,
                      isScrollControlled: true,
                      builder: (context) => const SearchView(),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: colorScheme.onSurface.withValues(alpha: .1),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search),
                        LabelMediumText(text: "Search groceries..."),
                      ],
                    ),
                  ),
                ),
                const Gap(16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 12,
                    children: groceryCategories
                        .map(
                          (e) => InkWell(
                            onTap: () {
                              navigationViewmodel.changeIndex(1);
                              categoryViewmodel.changeSelectedCategory(e.code);
                            },
                            child: Column(
                              spacing: 5,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(e.imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * .2,
                                  child: AutoSizeText(
                                    wrapWords: true,
                                    e.title,
                                    minFontSize: 10,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.labelMedium!.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxFontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const Gap(16),
                RepaintBoundary(
                  child: CarouselSlider(
                    items: groceryBanners
                        .map(
                          (e) => Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            height: 200, // Fixed height for consistency
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  // Background Image
                                  Image.network(
                                    e.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (
                                          context,
                                          error,
                                          stackTrace,
                                        ) => Container(
                                          color: colorScheme
                                              .surfaceContainerHighest,
                                          child: Icon(
                                            Icons.image_not_supported,
                                            color: colorScheme.onSurfaceVariant,
                                            size: 48,
                                          ),
                                        ),
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        color:
                                            colorScheme.surfaceContainerHighest,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            value:
                                                loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                                  // Gradient overlay for better text readability
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withValues(alpha: 0.7),
                                        ],
                                        stops: const [0.5, 1.0],
                                      ),
                                    ),
                                  ),

                                  // Content overlay
                                  Positioned(
                                    left: 16,
                                    right: 16,
                                    bottom: 16,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                shadows: [
                                                  Shadow(
                                                    color: Colors.black
                                                        .withValues(alpha: 0.5),
                                                    offset: const Offset(0, 1),
                                                    blurRadius: 2,
                                                  ),
                                                ],
                                              ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          e.description,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Colors.white.withValues(
                                                  alpha: 0.9,
                                                ),
                                                fontWeight: FontWeight.w400,
                                                shadows: [
                                                  Shadow(
                                                    color: Colors.black
                                                        .withValues(alpha: 0.5),
                                                    offset: const Offset(0, 1),
                                                    blurRadius: 2,
                                                  ),
                                                ],
                                              ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 1,
                    ),
                  ),
                ),
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BodyLargeText(
                      text: "Popular Products",
                      fontWeight: FontWeight.bold,
                    ),
                    TextButton(onPressed: () {}, child: const Text("See all")),
                  ],
                ),
                GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 270,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 265,
                  ),
                  itemBuilder: (context, index) {
                    final data = groceryProducts[index];
                    return ProductCard(product: data);
                  },
                ),
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BodyLargeText(
                      text: "Recomended for You",
                      fontWeight: FontWeight.bold,
                    ),
                    TextButton(onPressed: () {}, child: const Text("See all")),
                  ],
                ),
                SizedBox(
                  height: 265,
                  child: ListView.builder(
                    itemCount: 6,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final data = groceryProducts[index + 4];
                      return SizedBox(
                        width: 200, // Define width here
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                          ), // Add spacing between items
                          child: ProductCard(product: data),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SliverGap(60),
      ],
    );
  }
}
