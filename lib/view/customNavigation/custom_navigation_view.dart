import 'dart:ui';
import 'package:e_commerce/view/categories/categories_view.dart';
import 'package:e_commerce/view/customNavigation/bar_item.dart';
import 'package:e_commerce/view/home/home_view.dart';
import 'package:e_commerce/view/profile/profile_view.dart';
import 'package:e_commerce/viewmodel/customNavigation/custom_navigation_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationView extends ConsumerStatefulWidget {
  const CustomNavigationView({super.key});

  @override
  ConsumerState<CustomNavigationView> createState() =>
      _CustomNavigationViewState();
}

class _CustomNavigationViewState extends ConsumerState<CustomNavigationView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final viewmodel = ref.read(customNavigationViewmodelProvider.notifier);

    return Consumer(
      builder: (context, ref, child) {
        final currentIndex = ref.watch(
          customNavigationViewmodelProvider.select(
            (value) => value.currentIndex,
          ),
        );
        return Scaffold(
          extendBody: true,
          body: IndexedStack(
            index: currentIndex,
            children: const [HomeView(), CategoriesView(), ProfileView()],
          ),
          bottomNavigationBar: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10,
                    sigmaY: 10,
                  ), // Increase blur intensity
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: colorScheme.surface.withValues(alpha: .8),
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: .2),
                        width: 1,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          colorScheme.primaryContainer.withValues(alpha: .7),
                          colorScheme.primaryContainer.withValues(alpha: .3),
                        ],
                      ),
                    ),
                    child: Row(
                      spacing: 16,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BarItem(
                          onTap: () {
                            viewmodel.changeIndex(0);
                          },
                          icon: FontAwesomeIcons.home,
                          isCurrent: currentIndex == 0,
                        ),
                        BarItem(
                          onTap: () {
                            viewmodel.changeIndex(1);
                          },
                          icon: FontAwesomeIcons.thLarge,
                          isCurrent: currentIndex == 1,
                        ),
                        BarItem(
                          onTap: () {
                            viewmodel.changeIndex(2);
                          },
                          icon: FontAwesomeIcons.userAlt,
                          isCurrent: currentIndex == 2,
                        ),
                        Badge(
                          alignment: const Alignment(.8, -.8),
                          child: BarItem(
                            onTap: () {
                              context.push('/cart');
                            },
                            icon: FontAwesomeIcons.shoppingCart,
                            isCurrent: currentIndex == 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
