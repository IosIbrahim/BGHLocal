import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(const BottomNavState());

  void selectIndex(int index) {
    if (index == state.selectedIndex) return;
    emit(state.copyWith(selectedIndex: index));
  }

  /// Returns `true` if the app should exit, `false` if navigated back to home.
  bool handleBackPress() {
    if (state.selectedIndex == 0) return true;
    emit(const BottomNavState(selectedIndex: 0));
    return false;
  }
}
