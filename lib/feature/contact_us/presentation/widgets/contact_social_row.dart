import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/core.dart';

class ContactSocialRow extends StatelessWidget {
  const ContactSocialRow({super.key});

  Future<void> _openUrl(BuildContext context, String urlString) async {
    final Uri uri = Uri.parse(urlString);
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        context.showErrorToast("Could not open link");
      }
    } catch (_) {
      if (context.mounted) {
        context.showErrorToast("Could not open link");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final socialItems = [
      _SocialItem(
        assetPath: ImageAssets.ic_linkedIn,
        url: AppConstants.linkedinUrl,
      ),
      _SocialItem(
        assetPath: ImageAssets.ic_faceBook,
        url: AppConstants.facebookUrl,
      ),
      _SocialItem(
        assetPath: ImageAssets.ic_instgram,
        url: AppConstants.instagramUrl,
      ),
      _SocialItem(
        assetPath: ImageAssets.ic_youtube,
        url: AppConstants.youtubeUrl,
      ),
      _SocialItem(
        assetPath: ImageAssets.ic_twitter,
        url: AppConstants.xTwitterUrl,
      ),
    ];

    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppPadding.p20,
        end: AppPadding.p20,
        bottom: AppPadding.p35,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: socialItems.map((item) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(end: AppPadding.p12),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.r8),
              onTap: () => _openUrl(context, item.url),
              child: Image.asset(
                item.assetPath,
                width: AppSize.s34,
                height: AppSize.s34,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const SizedBox(
                  width: AppSize.s34,
                  height: AppSize.s34,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _SocialItem {
  final String assetPath;
  final String url;

  const _SocialItem({
    required this.assetPath,
    required this.url,
  });
}
