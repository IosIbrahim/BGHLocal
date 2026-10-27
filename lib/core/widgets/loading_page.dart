import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../resources/app_strings.dart';
import '../theme/theme.dart';

BuildContext? _dialogContext;

void showLoadingDialog(BuildContext context) {
  if (_dialogContext != null) return;

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      _dialogContext = dialogContext;
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Center(
          child: LoadingAnimationWidget.fourRotatingDots(
            color: AppColors.primaryBlue,
            size: AppIconSize.i60,
          ),
        ),
      );
    },
  );
}

void showConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  required VoidCallback onConfirmed,
  VoidCallback? onCancelled,
}) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 3,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    if (onCancelled != null) onCancelled();
                  },
                  child: const Text(
                    "Cancel",
                    style:
                        TextStyle(color: AppColors.errorRed, fontSize: 16),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onConfirmed();
                  },
                  child: const Text(
                    "Confirm",
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

void showErrorDialog(BuildContext context,
    {String? message, VoidCallback? onPressed}) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.r20),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.r20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: AppRadius.r2,
              blurRadius: AppRadius.r8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error,
                  color: AppColors.errorRed,
                  size: AppIconSize.i40,
                ),
                const SizedBox(width: AppGap.g8),
                Text("Error",
                    style: getBoldStyle(
                        color: AppColors.primaryBlue,
                        fontSize: FontSize.size20)),
              ],
            ),
            const SizedBox(height: AppGap.g16),
            Text(message ?? '',
                style: getRegularStyle(
                    color: AppColors.colorBlack0D,
                    fontSize: FontSize.size16)),
            const SizedBox(height: AppGap.g24),
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text("Close",
                  style: getBoldStyle(
                      color: AppColors.primaryBlue,
                      fontSize: FontSize.size18)),
            ),
          ],
        ),
      ),
    ),
  );
}

void showSuccessDialog(BuildContext context,
    {String? message, VoidCallback? onPressed}) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.r20),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.r20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: AppRadius.r2,
              blurRadius: AppRadius.r8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: AppIconSize.i40,
                ),
                const SizedBox(width: AppGap.g8),
                Text(
                  AppStrings.success.tr(),
                  style: getBoldStyle(
                    color: Colors.green,
                    fontSize: FontSize.size20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppGap.g16),
            Text(
              message ?? '',
              style: getRegularStyle(
                color: AppColors.colorBlack0D,
                fontSize: FontSize.size16,
              ),
            ),
            const SizedBox(height: AppGap.g24),
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text(
                "Ok",
                style: getBoldStyle(
                  color: Colors.green,
                  fontSize: FontSize.size18,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void dismissLoadingDialog() {
  if (_dialogContext != null) {
    Navigator.of(_dialogContext!, rootNavigator: true).pop();
    _dialogContext = null;
  }
}

bool isLoadingDialogShowing() => _dialogContext != null;
