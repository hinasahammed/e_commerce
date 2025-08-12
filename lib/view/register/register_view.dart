import 'package:e_commerce/res/components/buttons/custom_button.dart';
import 'package:e_commerce/res/components/field/custom_textformfield.dart';
import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/res/components/text/label_medium_text.dart';
import 'package:e_commerce/res/components/text/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Center(
                child: Container(
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: [
                  TitleLargeText(
                    text: "Fresh",
                    textColor: colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                  TitleLargeText(
                    text: "Cart",
                    textColor: colorScheme.secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              const Gap(10),
              const TitleLargeText(
                text: "Welcome!",
                fontWeight: FontWeight.w600,
              ),
              LabelMediumText(
                text:
                    "Create your account to get started with our amazing features",
                textColor: colorScheme.onSurface.withValues(alpha: .6),
              ),
              const Gap(5),
              const LabelLargeText(
                text: "Full name",
                fontWeight: FontWeight.w500,
              ),
              const CustomTextformField(labelText: "Enter your full name"),
              const Gap(5),
              const LabelLargeText(text: "Email", fontWeight: FontWeight.w500),
              const CustomTextformField(labelText: "Enter your email"),
              const Gap(5),
              const LabelLargeText(
                text: "Phone number",
                fontWeight: FontWeight.w500,
              ),
              const CustomTextformField(labelText: "Enter your phone number"),
              const Gap(5),
              const LabelLargeText(
                text: "Password",
                fontWeight: FontWeight.w500,
              ),
              const CustomTextformField(labelText: "Enter your password"),
              const Gap(10),
              CustomButton(
                width: double.infinity,
                onPressed: () {},
                btnText: "Create Account",
              ),
              const Gap(8),
              const Row(
                spacing: 12,
                children: [
                  Expanded(child: Divider()),
                  LabelMediumText(text: "OR"),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: SignInButton(
                  Buttons.Google,
                  padding: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                  onPressed: () {},
                ),
              ),
              const Gap(8),
              SizedBox(
                width: double.infinity,
                child: SignInButton(
                  Buttons.Facebook,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                  onPressed: () {},
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LabelLargeText(
                    text: "Already have an account?",
                    fontWeight: FontWeight.w500,
                  ),
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text("Log in"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
