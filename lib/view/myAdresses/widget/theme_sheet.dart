import 'package:e_commerce/res/components/enums/enums.dart';
import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/res/utils/utils.dart';
import 'package:e_commerce/viewmodel/theme/theme_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ThemeSheet extends ConsumerWidget {
  const ThemeSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final viewmodel = ref.read(themeViewmodelProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const LabelLargeText(
            text: "Select Theme",
            fontWeight: FontWeight.w600,
          ),
          const Gap(16),
          ...AppThemeMode.values.map(
            (theme) => Consumer(
              builder: (context, ref, child) {
                final currentTheme = ref.watch(
                  themeViewmodelProvider.select((value) => value.currentTheme),
                );
                return ListTile(
                  leading: Icon(Utils.getThemeIcon(theme)),
                  title: Text(Utils.getThemeDisplayName(theme)),
                  trailing: currentTheme == theme
                      ? Icon(Icons.check, color: colorScheme.primary)
                      : null,
                  onTap: () async {
                    await viewmodel.changeTheme(theme);
                    if (context.mounted) {
                      context.pop();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
