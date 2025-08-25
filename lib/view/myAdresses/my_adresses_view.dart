import 'package:e_commerce/res/components/constants/colors/app_colors.dart';
import 'package:e_commerce/view/myAdresses/widget/adress_card.dart';
import 'package:flutter/material.dart';

class MyAdressesView extends StatelessWidget {
  const MyAdressesView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text("My Adresses"), centerTitle: true),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 12,
          children: [
            AdressCard(
              leadingIcon: Icons.home,
              iconColor: AppColors.blueColor,
              title: "Home",
            ),
            AdressCard(
              leadingIcon: Icons.work,
              iconColor: AppColors.purpleColor,
              title: "Work",
            ),
            AdressCard(
              leadingIcon: Icons.location_on,
              iconColor: AppColors.secondaryColor,
              title: "Home",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: "Add Adress",
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
