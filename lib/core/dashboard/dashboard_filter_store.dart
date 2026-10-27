import 'package:flutter/foundation.dart';

import 'dashboard_filter.dart';

class DashboardFilterStore extends ChangeNotifier {
  DashboardFilter _filter = DashboardFilter.initial;

  DashboardFilter get filter => _filter;

  void apply(DashboardFilter filter) {
    if (filter == _filter) return;
    _filter = filter;
    notifyListeners();
  }

  void reset() => apply(DashboardFilter.initial);
}
