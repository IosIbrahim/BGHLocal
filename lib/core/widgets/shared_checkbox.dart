import 'package:flutter/material.dart';

import '../theme/color_manager.dart';
  
import '../theme/style_manager.dart';
import '../theme/theme.dart';

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({
    super.key,
    required this.title,
    this.initialValue = false,
    this.onChanged,
  });

  final String title;
  final bool initialValue;
  final Function(bool)? onChanged;

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.scale(
          scale: 0.90,
          child: Checkbox(
            value: isChecked,
            onChanged: (val) {
              if (val != null) {
                setState(() {
                  isChecked = val;
                });
                widget.onChanged?.call(val);
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s4),
            ),
            activeColor: ColorManager.colorBlue09,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: AppPadding.p2),
            child: Text(
              widget.title,
              style: getRegularStyle(
                color: ColorManager.colorBlack12,
                fontSize: AppSize.s16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
