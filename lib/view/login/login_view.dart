import 'package:e_commerce/res/components/buttons/custom_button.dart';
import 'package:e_commerce/res/components/field/custom_textformfield.dart';
import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/res/components/text/label_medium_text.dart';
import 'package:e_commerce/res/components/text/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                text: "Welcome back!",
                fontWeight: FontWeight.w600,
              ),
              LabelMediumText(
                text: "Sign in to continue shopping",
                textColor: colorScheme.onSurface.withValues(alpha: .6),
              ),
              const Gap(10),
              const LabelLargeText(text: "Email", fontWeight: FontWeight.w500),
              const CustomTextformField(labelText: "Enter your email"),
              const LabelLargeText(
                text: "Password",
                fontWeight: FontWeight.w500,
              ),
              const CustomTextformField(labelText: "Enter your password"),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Forgot password?"),
                ),
              ),
              const Gap(8),
              CustomButton(
                width: double.infinity,
                onPressed: () {
                  context.go('/custom_navigation');
                },
                btnText: "Login",
              ),
              const Gap(10),
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
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LabelLargeText(
                    text: "New to Fresh Cart?",
                    fontWeight: FontWeight.w500,
                  ),
                  TextButton(
                    onPressed: () {
                      context.push('/register');
                    },
                    child: const Text("Join now"),
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
