import '../../../../core/widgets/charts/models/card_state.dart';
import '../models/dashboard_feature.dart';

/// Holds the live count for every dashboard feature that is backed by an API,
/// keyed by [DashboardFeature]. Features without a loaded count simply have no
/// entry — the UI falls back to its static value for those.
///
/// Values are already display-formatted strings rather than numbers, because
/// the cards mix plain counts ("86") with compact currency ("$2.4M") and each
/// feature's own dashboard owns that formatting.
class HomeCountsState {
  final Map<DashboardFeature, CardState<String>> counts;

  const HomeCountsState({this.counts = const {}});

  /// The count slice for [feature], or null when this feature has no live count.
  CardState<String>? countFor(DashboardFeature? feature) =>
      feature == null ? null : counts[feature];

  /// Returns a new state with a single [feature] slice replaced, leaving the
  /// other entries' identities intact so their selectors don't rebuild.
  HomeCountsState withCount(DashboardFeature feature, CardState<String> state) =>
      HomeCountsState(counts: {...counts, feature: state});
}
