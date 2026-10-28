import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../splash/presentation/view/splash_screen.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import '../widgets/login_footer.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';
import '../widgets/login_contact.dart';
import '../widgets/login_doctor.dart';

/// Login Screen — orchestration only.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Explicitly listen to locale changes to trigger rebuild
    final _ = context.locale;

    return BlocProvider<LoginCubit>(
      create: (_) => instance<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: _onStateChanged,
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, _) {
              if (didPop) return;
              SystemNavigator.pop();
            },
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarColor: ColorManager.colorGrayF3,
                statusBarIconBrightness: Brightness.dark,
              ),
              child: Scaffold(
                backgroundColor: ColorManager.colorGrayF3,
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ── Header: logos + welcome text ──────────────
                        LoginHeader(),

                        // ── Form: fields + forgot password + button ────
                        LoginForm(
                          isLoading: state is LoginLoading,
                          onSubmit: (username, password) {
                            context
                                .read<LoginCubit>()
                                .login(username, password);
                          },
                        ),

                        // ── Footer: register prompt ────────────────────
                        LoginFooter(
                          onRegisterTap: () {
                            // TODO: navigate to registration screen
                          },
                        ),
                        const SizedBox(height: AppSize.s10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: colorDarkOrLightMode(
                                  false,
                                  ColorManager.colorGray37,
                                  ColorManager.white,
                                ),
                                borderRadius:
                                    BorderRadius.circular(AppRadius.r20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.06),
                                    blurRadius: AppRadius.r16,
                                    offset: const Offset(0, AppRadius.r4),
                                  ),
                                ],
                              ),
                              child: LoginContact(
                                onContactTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.contactUsRoute,
                                  );
                                },
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: colorDarkOrLightMode(
                                  false,
                                  ColorManager.colorGray37,
                                  ColorManager.white,
                                ),
                                borderRadius:
                                    BorderRadius.circular(AppRadius.r20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.06),
                                    blurRadius: AppRadius.r16,
                                    offset: const Offset(0, AppRadius.r4),
                                  ),
                                ],
                              ),
                              child: LoginDoctor(
                                onSearchTap: () {
                                  // TODO: navigate to doctor search screen
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSize.s20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onStateChanged(BuildContext context, LoginState state) {
    if (state is LoginLoading) {
      showLoadingDialog(context);
    } else {
      dismissLoadingDialog();
    }

    if (state is LoginSuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SplashScreen()),
      );
    } else if (state is LoginError) {
      context.showErrorToast(state.message);
    }
  }
}
