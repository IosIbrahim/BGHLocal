import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';
import 'package:local_auth/local_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final LocalAuthentication auth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (_) => instance<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: _onStateChanged,
        builder: (context, state) {
          return _loginScreenContent(context,state);
        },
      ),
    );
  }

  Widget _loginScreenContent(BuildContext context,LoginState state){
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        SystemNavigator.pop();
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.grayBg,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: AppColors.grayBg,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LoginHeader(),
                  LoginForm(
                    onSubmit: (username, password) {
                      _authenticate(username,password,context);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _authenticate(String username, String password, BuildContext context) async {
    try {
      // bool authenticated = await auth.authenticate(
      //   localizedReason: AppStrings.confirm_your_identity.tr(),
      //   options: const AuthenticationOptions(
      //       biometricOnly: true,
      //       stickyAuth: true,
      //       useErrorDialogs: true
      //   ),
      // );

      // if (authenticated) {
        context.read<LoginCubit>().login(username, password);
      // }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  void _onStateChanged(BuildContext context, LoginState state) {
    if (state is LoginLoading) {
      showLoadingDialog(context);
    } else {
      dismissLoadingDialog();
    }

    if (state is LoginSuccess) {
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.homeRoute, (_) => false);
    } else if (state is LoginError) {
      context.showErrorToast(state.message);
    }
  }
}
