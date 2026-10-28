import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

/// Owns the Form, TextEditingControllers, field validation,
/// the "Forgot Password" link, and the Login button.
class LoginForm extends StatefulWidget {
  /// Called when the form is valid and the user taps Login.
  final void Function(String username, String password) onSubmit;

  /// Driven by the BLoC state — disables the button while a request is in flight.
  final bool isLoading;

  const LoginForm({
    super.key,
    required this.onSubmit,
    required this.isLoading,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() == true) {
      widget.onSubmit(
        _usernameController.text.trim(),
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUnfocus,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Username Field ───────────────────────────────────────
          MyTextFieldWithTitle(
            hint: AppStrings.user_name.tr(),
            title: '',
            prefixIcon: ImageAssets.userIcon,
            obscureText: false,
            inputType: TextInputType.name,
            controller: _usernameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.enter_userName.tr();
              }
              return null;
            },
            takeValue: (_) {},
          ),
          const SizedBox(height: AppSize.s12),

          // ── Password Field ───────────────────────────────────────
          MyTextFieldWithTitle(
            hint: AppStrings.password.tr(),
            title: '',
            prefixIcon: ImageAssets.unLockIcon,
            obscureText: true,
            inputType: TextInputType.visiblePassword,
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.enter_password.tr();
              }
              return null;
            },
            takeValue: (_) {},
          ),
          const SizedBox(height: AppSize.s20),

          // ── Forgot Password ──────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: GestureDetector(
                onTap: () {
                  // TODO: navigate to forgot password screen
                },
                child: Text(
                  AppStrings.forgot_Password.tr(),
                  style: getMediumStyle(
                    color: ColorManager.colorBlue09,
                    fontSize: FontSize.size17,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSize.s20),

          // ── Login Button ─────────────────────────────────────────
          MyButton(
            color: widget.isLoading
                ? ColorManager.colorBlue02.withValues(alpha: 0.6)
                : ColorManager.colorBlue02,
            icon: ImageAssets.arrowLoginIcon,
            buttonText: AppStrings.login.tr(),
            fun: widget.isLoading ? () {} : _submit,
          ),
          const SizedBox(height: AppSize.s30),
        ],
      ),
    );
  }
}
