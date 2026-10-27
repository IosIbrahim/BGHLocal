import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/card_state.dart';
import 'card_placeholders.dart';

class DashCard<T> extends StatelessWidget {
  /// Title displayed at the top of the card. Pass empty string to hide.
  final String title;

  /// Current state of the card's data.
  final CardState<T> state;

  /// Builder called when [state] is [CardData].
  final Widget Function(T data) builder;

  /// Minimum height for loading / error states so the card doesn't collapse.
  final double minHeight;

  /// Optional icon shown before the [title] in the header.
  final IconData? leadingIcon;

  /// Optional SVG asset for the leading icon; takes precedence over [leadingIcon].
  final String? leadingAsset;

  /// Colour of [leadingIcon]. Defaults to the muted grey used by labels.
  final Color? leadingIconColor;

  /// Optional widget pinned to the trailing edge of the header (e.g. a badge).
  final Widget? trailing;

  /// Optional content rendered below the card body (e.g. progress bars).
  final Widget? footer;

  const DashCard({
    super.key,
    required this.title,
    required this.state,
    required this.builder,
    this.minHeight = 120,
    this.leadingIcon,
    this.leadingAsset,
    this.leadingIconColor,
    this.trailing,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_hasHeader) ...[
            _buildHeader(),
            const SizedBox(height: 18),
          ],
          _buildBody(),
          if (footer != null) ...[
            const SizedBox(height: 20),
            footer!,
          ],
        ],
      ),
    );
  }

  bool get _hasHeader =>
      title.isNotEmpty ||
      leadingIcon != null ||
      leadingAsset != null ||
      trailing != null;

  Widget _buildHeader() {
    return Row(
      children: [
        if (leadingAsset != null) ...[
          SvgPicture.asset(leadingAsset!, width: 20, height: 20),
          const SizedBox(width: 8),
        ] else if (leadingIcon != null) ...[
          Icon(
            leadingIcon,
            size: 20,
            color: leadingIconColor ?? const Color(0xFF8A8FA8),
          ),
          const SizedBox(width: 8),
        ],
        if (title.isNotEmpty)
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
                letterSpacing: 0,
              ),
            ),
          )
        else
          const Spacer(),
        if (trailing != null) ...[const SizedBox(width: 8), trailing!],
      ],
    );
  }

  Widget _buildBody() {
    return switch (state) {
      CardLoading() => CardLoadingPlaceholder(minHeight: minHeight),
      CardError(:final message, :final onRetry) =>
        CardErrorPlaceholder(message: message, onRetry: onRetry, minHeight: minHeight),
      CardData(:final data) => builder(data),
    };
  }
}
