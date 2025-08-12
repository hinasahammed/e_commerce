import 'dart:async';

import 'package:e_commerce/res/components/text/headline_large_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _groceryBagController;
  late AnimationController _contentController;

  late Animation<Offset> _groceryBagSlideAnimation;
  late Animation<Offset> _contentSlideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _groceryBagController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _contentController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _groceryBagSlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 1.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _groceryBagController,
            curve: Curves.easeOutCubic,
          ),
        );

    _contentSlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, -0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _contentController,
            curve: Curves.easeOutCubic,
          ),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeInOut),
    );

    _startAnimations();
    gotoLogin();
  }

  void _startAnimations() async {
    _groceryBagController.forward();

    await Future.delayed(const Duration(milliseconds: 200));
    _contentController.forward();
  }

  void gotoLogin() {
    Timer(const Duration(seconds: 3), () => context.go('/login'));
  }

  @override
  void dispose() {
    _groceryBagController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: .3,
                child: Image.asset(
                  "assets/images/splah_banner.png",
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            RepaintBoundary(
              child: SlideTransition(
                position: _contentSlideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    spacing: 8,
                    children: [
                      const SizedBox(height: 250),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          Icons.shopping_basket,
                          color: colorScheme.onPrimary,
                          size: 80,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          HeadlineLargeText(
                            text: "Fresh",
                            textColor: colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                          HeadlineLargeText(
                            text: "Cart",
                            textColor: colorScheme.secondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: RepaintBoundary(
                child: SlideTransition(
                  position: _groceryBagSlideAnimation,
                  child: Image.asset(
                    "assets/images/grocery_bag.png",
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: 300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
