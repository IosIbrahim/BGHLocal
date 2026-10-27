import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class LoginForm extends StatefulWidget {
  final void Function(String username, String password) onSubmit;

  final bool isDarkMode;

  const LoginForm({
    super.key,
    this.isDarkMode = false,
    required this.onSubmit});

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
          MyTextField(
            hint: AppStrings.user_name.tr(),
            title: AppStrings.user_name.tr(),
            suffixIcon: "",
            obscureText: false,
            isDarkMode: widget.isDarkMode,
            inputType: TextInputType.text,
            controller: _usernameController,
            validator: (value) =>
                (value == null || value.isEmpty) ? AppStrings.user_name.tr() : null,
            takeValue: (value) {}, prefixIcon: ImageAssets.userIcon,
          ),
          const SizedBox(
            height: AppGap.g14,
          ),
          MyTextField(
            hint: AppStrings.password.tr(),
            title: AppStrings.password.tr(),
            suffixIcon: "",
            prefixIcon: ImageAssets.unLockIcon,
            obscureText: true,
            isDarkMode: widget.isDarkMode,
            inputType: TextInputType.visiblePassword,
            controller: _passwordController,
            validator: (value) =>
                (value == null || value.isEmpty) ? AppStrings.password.tr() : null,
            takeValue: (value) {},
          ),
          const SizedBox(height: AppGap.g20),
          MyButton(
              color: AppColors.legacyCyan,
              icon: ImageAssets.arrowLoginIcon,
              buttonText: AppStrings.login.tr(),
              fun: () {
                _submit();
              }
          ),
          const SizedBox(height: AppGap.g50)
        ],
      ),
    );
  }
}
