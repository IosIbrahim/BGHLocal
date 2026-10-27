import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../resources/app_strings.dart';

/// Shared bottom navigation bar (Home / Dashboard / Profile / Settings).
/// The active item gets a filled accent tile.
class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const AppBottomNav({
    super.key,
    this.currentIndex = 0,
    this.onTap,
  });

  static const _accent = Color(0xFF2BA98C);
  static const _inactive = Color(0xFF9DA4AE);

  static const _items = <_NavItem>[
    _NavItem(Icons.home_rounded, AppStrings.navHome),
    _NavItem(Icons.speed_rounded, AppStrings.navDashboard),
    _NavItem(Icons.person_rounded, AppStrings.navProfile),
    _NavItem(Icons.settings_rounded, AppStrings.navSettings),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        12,
        10,
        12,
        10 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (i) {
          final selected = i == currentIndex;
          return _buildItem(_items[i], selected, () => onTap?.call(i));
        }),
      ),
    );
  }

  Widget _buildItem(_NavItem item, bool selected, VoidCallback onTapItem) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTapItem,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 38,
            decoration: BoxDecoration(
              color: selected ? _accent : _inactive.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              item.icon,
              size: 22,
              color: selected ? Colors.white : _inactive,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.label.tr(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected ? _accent : _inactive,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);
}
