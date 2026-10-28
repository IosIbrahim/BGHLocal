import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/core.dart';
import '../widgets/contact_header_card.dart';
import '../widgets/contact_item_card.dart';
import '../widgets/contact_social_row.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  Future<void> _makePhoneCall(BuildContext context, String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      final launched = await launchUrl(uri);
      if (!launched && context.mounted) {
        context.showErrorToast("Could not launch dialer");
      }
    } catch (_) {
      if (context.mounted) {
        context.showErrorToast("Could not launch dialer");
      }
    }
  }

  Future<void> _sendEmail(BuildContext context, String emailAddress) async {
    final Uri uri = Uri(scheme: 'mailto', path: emailAddress);
    try {
      final launched = await launchUrl(uri);
      if (!launched && context.mounted) {
        context.showErrorToast("Could not launch email client");
      }
    } catch (_) {
      if (context.mounted) {
        context.showErrorToast("Could not launch email client");
      }
    }
  }

  Future<void> _openLocation(BuildContext context, String locationUrl) async {
    final Uri uri = Uri.parse(locationUrl);
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        context.showErrorToast("Could not open location");
      }
    } catch (_) {
      if (context.mounted) {
        context.showErrorToast("Could not open location");
      }
    }
  }

  void _showPhoneOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.r20),
        ),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p20,
              vertical: AppPadding.p16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: AppSize.s40,
                    height: AppSize.s4,
                    decoration: BoxDecoration(
                      color: ColorManager.colorGrayD2,
                      borderRadius: BorderRadius.circular(AppRadius.r2),
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s16),
                Text(
                  AppStrings.contact_phone_title.tr(),
                  style: getBoldStyle(
                    color: ColorManager.colorBlue09,
                    fontSize: FontSize.size18,
                  ),
                ),
                const SizedBox(height: AppSize.s12),
                ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: ColorManager.colorBlue09,
                  ),
                  title: Text(
                    AppConstants.contactPhone1,
                    style: getBoldStyle(
                      color: ColorManager.colorBlue09,
                      fontSize: FontSize.size16,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    _makePhoneCall(context, AppConstants.contactPhone1);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: ColorManager.colorBlue09,
                  ),
                  title: Text(
                    AppConstants.contactPhone2,
                    style: getBoldStyle(
                      color: ColorManager.colorBlue09,
                      fontSize: FontSize.size16,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    _makePhoneCall(context, AppConstants.contactPhone2);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic =
        LanguageManager.getCurrentLanguage(context) == ARABIC;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: ColorManager.colorGrayF3,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: ColorManager.colorGrayF3,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          centerTitle: true,
          elevation: 0,
          backgroundColor: ColorManager.colorGrayF3,
          title: Text(
            AppStrings.contact_us_title.tr(),
            style: getBoldStyle(
              color: ColorManager.colorBlack18,
              fontSize: FontSize.size20,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              isArabic ? Icons.arrow_forward : Icons.arrow_back,
              color: ColorManager.colorBlack18,
              size: 24,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Top Header Card ──────────────────────────────
                const ContactHeaderCard(),

                // ── Section Title: Contact Details ───────────────
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: AppPadding.p20,
                    end: AppPadding.p20,
                    top: AppPadding.p18,
                    bottom: AppPadding.p8,
                  ),
                  child: Text(
                    AppStrings.contact_details.tr(),
                    style: getBoldStyle(
                      color: ColorManager.colorBlue09,
                      fontSize: FontSize.size18,
                    ),
                  ),
                ),

                // ── Card 1: Unified Number ───────────────────────
                ContactItemCard(
                  iconPath: ImageAssets.ic_contact_phone,
                  title: AppStrings.short_unified_number.tr(),
                  value: isArabic
                      ? "${AppConstants.unifiedNumberTel}+"
                      : AppConstants.unifiedNumber,
                  onTap: () => _makePhoneCall(
                    context,
                    AppConstants.unifiedNumberTel,
                  ),
                ),

                // ── Card 2: Email ────────────────────────────────
                ContactItemCard(
                  iconPath: ImageAssets.ic_contact_email,
                  title: AppStrings.contact_email_label.tr(),
                  value: AppConstants.contactEmail,
                  onTap: () => _sendEmail(
                    context,
                    AppConstants.contactEmail,
                  ),
                ),

                // ── Card 3: Phone ────────────────────────────────
                ContactItemCard(
                  iconPath: ImageAssets.ic_contact_phone,
                  title: AppStrings.contact_phone_title.tr(),
                  value: isArabic
                      ? AppConstants.contactPhonesDisplayAr
                      : AppConstants.contactPhonesDisplayEn,
                  onTap: () => _showPhoneOptions(context),
                ),

                // ── Card 4: Locations ────────────────────────────
                ContactItemCard(
                  iconPath: ImageAssets.ic_contact_location,
                  value: AppStrings.our_locations.tr(),
                  isSingleTitle: true,
                  onTap: () => _openLocation(
                    context,
                    AppConstants.contactLocationUrl,
                  ),
                ),

                // ── Section Title: Contact Details (Social) ──────
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: AppPadding.p20,
                    end: AppPadding.p20,
                    top: AppPadding.p20,
                    bottom: AppPadding.p14,
                  ),
                  child: Text(
                    AppStrings.contact_details.tr(),
                    style: getBoldStyle(
                      color: ColorManager.colorBlue09,
                      fontSize: FontSize.size18,
                    ),
                  ),
                ),

                // ── Social Icons Row ─────────────────────────────
                const ContactSocialRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
