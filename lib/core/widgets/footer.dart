import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/utils/responsive_utils.dart';
import 'package:portfolio/core/utils/url_launcher_utils.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getScreenPadding(context).horizontal,
        vertical: 32,
      ),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          isMobile
              ? _buildMobileFooter(context)
              : _buildDesktopFooter(context),
          const SizedBox(height: 24),
          Text(
            '© ${DateTime.now().year} ${AppConstants.name}. All rights reserved.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(context),
        _buildSocialLinks(context),
        _buildContactInfo(context),
      ],
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      children: [
        _buildLogo(context),
        const SizedBox(height: 24),
        _buildSocialLinks(context),
        const SizedBox(height: 24),
        _buildContactInfo(context),
      ],
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppConstants.name.split(' ')[0],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              ' ${AppConstants.name.split(' ')[1]}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          AppConstants.title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(
          context,
          FontAwesomeIcons.github,
          AppConstants.githubUrl,
        ),
        const SizedBox(width: 16),
        _buildSocialIcon(
          context,
          FontAwesomeIcons.linkedin,
          AppConstants.linkedinUrl,
        ),
        const SizedBox(width: 16),
        _buildSocialIcon(
          context,
          FontAwesomeIcons.twitter,
          AppConstants.twitterUrl,
        ),
        const SizedBox(width: 16),
        _buildSocialIcon(
          context,
          FontAwesomeIcons.instagram,
          AppConstants.instagramUrl,
        ),
      ],
    );
  }

  Widget _buildSocialIcon(BuildContext context, IconData icon, String url) {
    return InkWell(
      onTap: () => UrlLauncherUtils.launchURL(url),
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: FaIcon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildContactItem(
          context,
          Icons.email,
          AppConstants.email,
          () => UrlLauncherUtils.launchEmail(AppConstants.email),
        ),
        const SizedBox(height: 8),
        _buildContactItem(
          context,
          Icons.phone,
          AppConstants.phone,
          () => UrlLauncherUtils.launchPhone(AppConstants.phone),
        ),
        const SizedBox(height: 8),
        _buildContactItem(
          context,
          Icons.location_on,
          AppConstants.location,
          () {},
        ),
      ],
    );
  }

  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String text,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 