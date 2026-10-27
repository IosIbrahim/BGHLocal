import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../models/card_state.dart';
import '../models/progress_item.dart';
import 'dash_card.dart';

class LinearProgressCard extends StatelessWidget {
  final String title;
  final CardState<List<ProgressItem>> state;

  const LinearProgressCard({
    super.key,
    required this.title,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return DashCard<List<ProgressItem>>(
      title: title,
      state: state,
      builder: (items) => Column(
        children: items
            .map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _ProgressRow(item: item),
                ))
            .toList(),
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  final ProgressItem item;

  const _ProgressRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon badge
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: item.color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(item.icon, size: 18, color: item.color),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 105,
          child: Text(
            item.label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4A4F6A),
            ),
          ),
        ),
        // LinearPercentIndicator
        Expanded(
          child: LinearPercentIndicator(
            percent: item.percent,
            lineHeight: 10,
            backgroundColor: const Color(0xFFEAECF4),
            progressColor: item.color,
            barRadius: const Radius.circular(6),
            padding: EdgeInsets.zero,
            animation: true,
            animationDuration: 800,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '${item.current}/${item.total}',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF8A8FA8),
          ),
        ),
      ],
    );
  }
}
