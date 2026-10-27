
import 'package:dr_baksh_dashboard/feature/home/presentation/pages/profile/profile_page.dart';
import 'package:dr_baksh_dashboard/feature/home/presentation/pages/settings/settings_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/core.dart';
import 'presentation/cubit/bottom_nav_cubit.dart';
import 'presentation/cubit/bottom_nav_state.dart';
import 'presentation/pages/home_page/home_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _tabsScreens = [
    HomePage(),
    Placeholder(),
    ProfilePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => instance<BottomNavCubit>(),
      child: const _HomeScreenBody(),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody();

  List<BottomNavigationBarItem> _bottomNavItems() => [
        SharedBottomNavItem.item(
          iconAsset: ImageAssets.homeNavIcon,
          label: AppStrings.home.tr(),
        ),
        SharedBottomNavItem.item(
          iconAsset: ImageAssets.dashboardNavIcon,
          label: AppStrings.dashboard.tr(),
        ),
        SharedBottomNavItem.item(
          iconAsset: ImageAssets.profileNavIcon,
          label: AppStrings.profile.tr(),
        ),
        SharedBottomNavItem.item(
          iconAsset: ImageAssets.settingsNavIcon,
          label: AppStrings.settings.tr(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        return PopScope(
          canPop: state.selectedIndex == 0,
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) return;
            context.read<BottomNavCubit>().handleBackPress();
          },
          child: Scaffold(
            // IndexedStack keeps each tab's State alive across switches, so
            // HomePage builds its HomeCountsCubit once instead of re-fetching
            // on every return to the Home tab.
            body: IndexedStack(
              index: state.selectedIndex,
              children: HomeScreen._tabsScreens,
            ),
            bottomNavigationBar: SharedBottomNavItem.wrapBar(
              child: SharedBottomNavItem.buildBar(
                currentIndex: state.selectedIndex,
                onTap: context.read<BottomNavCubit>().selectIndex,
                items: _bottomNavItems(),
              ),
            ),
          ),
        );
      },
    );
  }
}
