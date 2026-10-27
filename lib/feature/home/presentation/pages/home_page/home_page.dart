import 'package:dr_baksh_dashboard/feature/home/presentation/widgets/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../../core/widgets/charts/models/card_state.dart';
import '../../../../filter/presentation/widgets/filter_sheet.dart';
import '../../cubit/home_counts_cubit.dart';
import '../../cubit/home_counts_state.dart';
import '../../models/dashboard_feature.dart';
import '../../models/home_card_item_model.dart';
import '../../widgets/home_app_bar.dart';
import '../../widgets/home_card_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode = false;

  /// Static card definitions. Counts are not listed here — a card shows a count
  /// only if [HomeCountsCubit] has an endpoint for its feature.
  final List<HomeCardItemModel> _cardItems = const [
    HomeCardItemModel(
      title: 'Inpatient',
   //   subtitle: 'Wards & Beds',
      subtitle: 'Wards & ICUS',
      countLabel: 'Patients',
      iconColor: Color(0xFF3DDC84),
      iconColorEnd: Color(0xFF2BBF72),
      feature: DashboardFeature.inpatient,
    ),
    HomeCardItemModel(
    //  title: 'Outpatient',
      title: 'OPD',
      subtitle: 'Clinics & Visits',
      countLabel: 'Visits',
      iconColor: Color(0xFF4BCDDD),
      iconColorEnd: Color(0xFF1B5EF7),
      feature: DashboardFeature.outpatient,
    ),
    HomeCardItemModel(
   //   title: 'Emergency',
      title: 'ER',
      subtitle: 'ER & Triage',
      countLabel: 'Active',
      iconColor: Color(0xFFFF6B81),
      iconColorEnd: Color(0xFFFF4D4D),
      feature: DashboardFeature.emergency,
    ),
    HomeCardItemModel(
      title: 'HR',
      subtitle: 'Staff Management',
      countLabel: 'Staff',
      iconColor: Color(0xFF8B5CF6),
      iconColorEnd: Color(0xFF6D40C6),
      feature: DashboardFeature.hr,
    ),
    HomeCardItemModel(
      title: 'Revenue',
      subtitle: 'Financial Overview',
      countLabel: 'Total',
      iconColor: Color(0xFFF0A500),
      iconColorEnd: Color(0xFFD97706),
      feature: DashboardFeature.revenue,
    ),
    HomeCardItemModel(
    //  title: 'Operating',
      title: 'Operations',
      subtitle: 'Surgery & Procedures',
      countLabel: 'Scheduled',
      iconColor: Color(0xFF0076A8),
      iconColorEnd: Color(0xFF005C87),
      feature: DashboardFeature.operating,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => instance<HomeCountsCubit>()..loadCounts(),
      child: Scaffold(
        backgroundColor: colorDarkOrLightMode(
          isDarkMode,
          AppColors.darkMode,
          AppColors.grayBg,
        ),
        appBar: AppBar(
          backgroundColor: AppColors.primaryBlue,
          toolbarHeight: AppDimension.d1_5,
          elevation: 0,
        ),
        body: Builder(builder: _getHomScreenContent),
      ),
    );
  }

  Widget _getHomScreenContent(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: AppDimension.d280,
          decoration: const BoxDecoration(
            color: AppColors.primaryBlue,
            image: DecorationImage(
              image: AssetImage(ImageAssets.homeBackgroundIcon),
              fit: BoxFit.cover,
              opacity: 0.2,
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            HomeAppBar(
              isDarkMode: isDarkMode,
              showBackButton: false,
              // The sheet writes to the shared DashboardFilterStore that every
              // count request already reads, so applying it here just needs a
              // reload.
              onFilterPressed: () => openDashboardFilter(
                context,
                context.read<HomeCountsCubit>().loadCounts,
              ),
            ),
            const SizedBox(height: AppGap.g40),
            const Padding(
              padding: EdgeInsets.only(left: AppPadding.p18),
              child: UserData(),
            ),
            const SizedBox(height: AppGap.g16),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => context.read<HomeCountsCubit>().loadCounts(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p16,
                    vertical: AppPadding.p10,
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppGap.g12,
                      mainAxisSpacing: AppGap.g12,
                      childAspectRatio: 0.78,
                    ),
                    itemCount: _cardItems.length,
                    itemBuilder: (context, index) =>
                        _buildCard(_cardItems[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Each card subscribes only to its own feature's count slice, so a count
  /// arriving for one feature rebuilds just that card. A feature with no
  /// endpoint selects null and the card renders without a count footer.
  Widget _buildCard(HomeCardItemModel item) {
    return BlocSelector<HomeCountsCubit, HomeCountsState, CardState<String>?>(
      selector: (state) => state.countFor(item.feature),
      builder: (context, countState) => HomeCardItem(
        isDarkMode: isDarkMode,
        item: item,
        countState: countState,
        onTap: () => _onCardTap(item),
      ),
    );
  }

  void _onCardTap(HomeCardItemModel item) {
    final route = item.feature?.route;
    if (route != null) Navigator.of(context).pushNamed(route);
  }
}
