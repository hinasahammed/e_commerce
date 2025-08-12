import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/res/components/constants/data/banners.dart';
import 'package:e_commerce/res/components/constants/data/categories.dart';
import 'package:e_commerce/res/components/constants/data/products.dart';
import 'package:e_commerce/res/components/field/custom_textformfield.dart';
import 'package:e_commerce/res/components/text/body_large_text.dart';
import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/res/components/text/label_medium_text.dart';
import 'package:e_commerce/res/components/text/label_small_text.dart';
import 'package:e_commerce/res/components/text/title_large_text.dart';
import 'package:e_commerce/res/components/widget/product_card.dart';
import 'package:e_commerce/res/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
                const CustomTextformField(
                  prefixIcon: Icon(Icons.search),
                  labelText: "Search for groceries...",
                ),
                const Gap(16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 12,
                    children: groceryCategories
                        .map(
                          (e) => Column(
                            spacing: 5,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: colorScheme.primary,
                                child: Icon(
                                  e.icon,
                                  color: colorScheme.onPrimary,
                                ),
                              ),
                              LabelMediumText(
                                text: e.title,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
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
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.all(16),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: colorScheme.onSurface,
                              image: DecorationImage(
                                image: NetworkImage(e.imageUrl),
                                fit: BoxFit.cover,
                                opacity: .6,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BodyLargeText(
                                  text: e.title,
                                  fontWeight: FontWeight.w600,
                                  textColor: colorScheme.onPrimary,
                                ),
                                LabelLargeText(
                                  text: e.description,
                                  textColor: colorScheme.onPrimary.withValues(
                                    alpha: .8,
                                  ),
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
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
                    return ProductCard(
                      code: data.code,
                      imageUrl: data.imageUrl,
                      name: data.subSkuName,
                      desc: data.desc,
                      uom: data.uom,
                      isVariant: data.code == data.variantCode,
                      sellingPrice: Utils.formatIndianCurrency(
                        data.sellingPrice,
                      ),
                      mrp: Utils.formatIndianCurrency(data.mrp),
                    );
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
                          child: ProductCard(
                            code: data.code,
                            imageUrl: data.imageUrl,
                            name: data.subSkuName,
                            desc: data.desc,
                            uom: data.uom,
                            isVariant: data.code == data.variantCode,
                            sellingPrice: Utils.formatIndianCurrency(
                              data.sellingPrice,
                            ),
                            mrp: Utils.formatIndianCurrency(data.mrp),
                          ),
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
