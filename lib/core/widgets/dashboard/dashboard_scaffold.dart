import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import 'primecare_header.dart';
import 'summary_card.dart';

/// Shared shell for every dashboard screen.
///
/// The colored [PrimeCareHeader] stays **fixed** while the summary [cards] and
/// section [children] scroll. At rest the cards overlap *on top of* the
/// header's lower strip (1:1 with the Figma); as the user scrolls, the cards
/// rise and disappear *behind* the header's title area — the colored band
/// never moves.
///
/// This is done by painting the band in two pinned layers (lower strip behind
/// the scroll content, title area in front of it) with the scrolling cards
/// sandwiched between them.
///
/// ```dart
/// DashboardScaffold(
///   title: 'Emergency Room',
///   subtitle: 'Real-time Triage & Patient Flow',
///   cards: const [ /* 3 SummaryCardData */ ],
///   children: [ /* section widgets */ ],
/// );
/// ```
class DashboardScaffold extends StatelessWidget {
  final String title;
  final String subtitle;

  /// Synchronous summary cards. Ignored when [summaryWidget] is provided.
  final List<SummaryCardData> cards;

  /// Optional replacement for the static card row. Use this when the cards
  /// depend on async state (e.g. the inpatient screen reads them from a BLoC).
  /// The widget is responsible for its own horizontal padding.
  final Widget? summaryWidget;

  /// Optional pull-to-refresh handler. When set, the scroll view is wrapped in
  /// a [RefreshIndicator].
  final Future<void> Function()? onRefresh;

  /// Scrolling section widgets shown beneath the cards.
  final List<Widget> children;

  final VoidCallback? onBack;
  final VoidCallback? onFilter;

  /// Horizontal padding for the cards and section [children].
  final double horizontalPadding;

  const DashboardScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    this.cards = const [],
    this.summaryWidget,
    this.onRefresh,
    required this.children,
    this.onBack,
    this.onFilter,
    this.horizontalPadding = 16,
  });

  @override
  Widget build(BuildContext context) {
    final hPad = EdgeInsets.symmetric(horizontal: horizontalPadding);
    final split = PrimeCareHeader.splitOf(context);

    final band = PrimeCareHeader(
      title: title,
      subtitle: subtitle,
      onBack: onBack ?? () => Navigator.of(context).maybePop(),
      onFilter: onFilter,
    );

    return Scaffold(
      backgroundColor: AppColors.grayBg,
      body: SizedBox.expand(
        child: Stack(
          children: [
            // Layer 1 — band's lower strip, behind the scrolling cards.
            Align(
              alignment: Alignment.topCenter,
              child: ClipRect(clipper: _BelowClip(split), child: band),
            ),

            // Layer 2 — scrolling cards (overlap the strip in front) + sections.
            Positioned.fill(
              child: _buildScrollBody(hPad, split),
            ),

            // Layer 3 — band's title area, in front; cards vanish behind it.
            Align(
              alignment: Alignment.topCenter,
              child: ClipRect(clipper: _AboveClip(split), child: band),
            ),
          ],
        ),
      ),
    );
  }

  /// The scrolling content (summary + sections). Wrapped in a
  /// [RefreshIndicator] when [onRefresh] is provided.
  Widget _buildScrollBody(EdgeInsets hPad, double split) {
    final list = ListView(
      // Keep the list draggable even when content is short so pull-to-refresh
      // still triggers.
      physics:
          onRefresh != null ? const AlwaysScrollableScrollPhysics() : null,
      padding: EdgeInsets.only(top: split, bottom: 24),
      children: [
        // When a [summaryWidget] is supplied it owns its padding; otherwise pad
        // the static card row to match the section [children].
        summaryWidget ??
            Padding(padding: hPad, child: _SummaryCardsRow(cards: cards)),
        const SizedBox(height: 24),
        for (final child in children) Padding(padding: hPad, child: child),
      ],
    );
    if (onRefresh == null) return list;
    // The pinned header band is painted on top of this scroll layer, so the
    // refresh spinner must settle *below* the header split — otherwise it spins
    // hidden behind the band and pull-to-refresh looks broken.
    return RefreshIndicator(
      onRefresh: onRefresh!,
      displacement: split + 16,
      child: list,
    );
  }
}

/// Clips a child to everything **above** [y] (the pinned title area).
class _AboveClip extends CustomClipper<Rect> {
  final double y;
  const _AboveClip(this.y);

  @override
  Rect getClip(Size size) => Rect.fromLTWH(0, 0, size.width, y);

  @override
  bool shouldReclip(_AboveClip old) => old.y != y;
}

/// Clips a child to everything **below** [y] (the lower colored strip).
class _BelowClip extends CustomClipper<Rect> {
  final double y;
  const _BelowClip(this.y);

  @override
  Rect getClip(Size size) =>
      Rect.fromLTWH(0, y, size.width, size.height - y);

  @override
  bool shouldReclip(_BelowClip old) => old.y != y;
}

class _SummaryCardsRow extends StatelessWidget {
  final List<SummaryCardData> cards;

  const _SummaryCardsRow({required this.cards});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < cards.length; i++) ...[
          if (i > 0) const SizedBox(width: 12),
          Expanded(child: SummaryCard(data: cards[i])),
        ],
      ],
    );
  }
}
