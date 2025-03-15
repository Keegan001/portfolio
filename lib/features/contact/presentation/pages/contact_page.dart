import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/utils/responsive_utils.dart';
import 'package:portfolio/core/utils/url_launcher_utils.dart';
import 'package:portfolio/core/widgets/animated_button.dart';
import 'package:portfolio/core/widgets/footer.dart';
import 'package:portfolio/core/widgets/navigation_bar.dart';
import 'package:portfolio/features/contact/presentation/widgets/contact_form.dart';
import 'package:portfolio/features/contact/presentation/widgets/contact_info_card.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomNavigationBar(currentRoute: AppConstants.contactRoute),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(context),
                    _buildContactSection(context),
                    _buildSocialSection(context),
                    const Footer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: ResponsiveUtils.getScreenPadding(context).copyWith(
        top: 60,
        bottom: 60,
      ),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Text(
            'Get In Touch',
            style: TextStyle(
              fontSize: ResponsiveUtils.getFontSize(context, 40),
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: ResponsiveUtils.isMobile(context) ? double.infinity : 600,
            child: Text(
              'Have a project in mind or want to discuss a potential collaboration? Feel free to reach out to me using the contact form below or through my social media channels.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ResponsiveUtils.getFontSize(context, 16),
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    
    return Container(
      padding: ResponsiveUtils.getScreenPadding(context).copyWith(
        top: 60,
        bottom: 60,
      ),
      color: Theme.of(context).colorScheme.background,
      child: isMobile
          ? Column(
              children: [
                _buildContactInfo(context),
                const SizedBox(height: 40),
                const ContactForm(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildContactInfo(context),
                ),
                const SizedBox(width: 40),
                const Expanded(
                  flex: 3,
                  child: ContactForm(),
                ),
              ],
            ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: TextStyle(
            fontSize: ResponsiveUtils.getFontSize(context, 24),
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 24),
        ContactInfoCard(
          icon: Icons.email,
          title: 'Email',
          value: AppConstants.email,
          onTap: () => UrlLauncherUtils.launchEmail(AppConstants.email),
        ),
        const SizedBox(height: 16),
        ContactInfoCard(
          icon: Icons.phone,
          title: 'Phone',
          value: AppConstants.phone,
          onTap: () => UrlLauncherUtils.launchPhone(AppConstants.phone),
        ),
        const SizedBox(height: 16),
        ContactInfoCard(
          icon: Icons.location_on,
          title: 'Location',
          value: AppConstants.location,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSocialSection(BuildContext context) {
    return Container(
      padding: ResponsiveUtils.getScreenPadding(context).copyWith(
        top: 60,
        bottom: 60,
      ),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Text(
            'Connect With Me',
            style: TextStyle(
              fontSize: ResponsiveUtils.getFontSize(context, 32),
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialButton(
                context,
                FontAwesomeIcons.github,
                'GitHub',
                AppConstants.githubUrl,
              ),
              const SizedBox(width: 24),
              _buildSocialButton(
                context,
                FontAwesomeIcons.linkedin,
                'LinkedIn',
                AppConstants.linkedinUrl,
              ),
              const SizedBox(width: 24),
              _buildSocialButton(
                context,
                FontAwesomeIcons.twitter,
                'Twitter',
                AppConstants.twitterUrl,
              ),
              const SizedBox(width: 24),
              _buildSocialButton(
                context,
                FontAwesomeIcons.instagram,
                'Instagram',
                AppConstants.instagramUrl,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(
    BuildContext context,
    IconData icon,
    String label,
    String url,
  ) {
    return Column(
      children: [
        InkWell(
          onTap: () => UrlLauncherUtils.launchURL(url),
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: FaIcon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
} 