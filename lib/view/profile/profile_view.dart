import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/res/components/text/label_medium_text.dart';
import 'package:e_commerce/res/components/text/title_large_text.dart';
import 'package:e_commerce/view/profile/widgets/offers_and_rewards.dart';
import 'package:e_commerce/view/profile/widgets/orders_and_payments.dart';
import 'package:e_commerce/view/profile/widgets/preferences.dart';
import 'package:e_commerce/view/profile/widgets/support_and_legal.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: colorScheme.primary,
          title: TitleLargeText(
            text: "Profile",
            textColor: colorScheme.onPrimary,
          ),
        ),
        SliverAppBar(
          backgroundColor: colorScheme.primary,
          collapsedHeight: 90,
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    radius: 25,
                    child: const Icon(Icons.image),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelLargeText(
                          text: "Sarah johnson",
                          fontWeight: FontWeight.w600,
                          textColor: colorScheme.onPrimary,
                        ),
                        LabelMediumText(
                          text: "sarah.johnson@gmail.com",
                          textColor: colorScheme.onPrimary.withValues(
                            alpha: .9,
                          ),
                        ),
                        LabelMediumText(
                          text: "+918586898748",
                          textColor: colorScheme.onPrimary.withValues(
                            alpha: .9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OrdersAndPayments(),
                const OffersAndRewards(),
                const Preferences(),
                const SupportAndLegal(),
                InkWell(
                  onTap: () {
                    context.go('/login');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      spacing: 12,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: colorScheme.error),
                        LabelLargeText(
                          text: "Logout",
                          fontWeight: FontWeight.w600,
                          textColor: colorScheme.error,
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(60),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
