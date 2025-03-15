import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/utils/responsive_utils.dart';
import 'package:portfolio/core/widgets/animated_card.dart';
import 'package:portfolio/core/widgets/navigation_bar.dart';
import 'package:portfolio/core/widgets/section_title.dart';
import 'package:portfolio/features/contact/presentation/widgets/contact_form.dart';
import 'package:portfolio/features/contact/presentation/widgets/contact_info_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomNavigationBar(currentRoute: AppConstants.contactRoute),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(context),
                    _buildContactSection(context),
                    _buildSocialSection(context),
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
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getScreenPadding(context).horizontal,
        vertical: 64,
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Get In Touch',
            subtitle: 'Feel free to reach out to me for any inquiries or collaboration opportunities.',
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getScreenPadding(context).horizontal,
        vertical: 32,
      ),
      child: isMobile
          ? Column(
              children: [
                _buildContactInfo(context),
                const SizedBox(height: 32),
                _buildContactForm(context),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildContactInfo(context),
                ),
                const SizedBox(width: 64),
                Expanded(
                  flex: 3,
                  child: _buildContactForm(context),
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
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 24),
        ContactInfoCard(
          icon: Icons.email,
          title: 'Email',
          value: 'contact@example.com',
          onTap: () {
            // Launch email app
          },
        ),
        const SizedBox(height: 16),
        ContactInfoCard(
          icon: Icons.phone,
          title: 'Phone',
          value: '+1 (123) 456-7890',
          onTap: () {
            // Launch phone app
          },
        ),
        const SizedBox(height: 16),
        ContactInfoCard(
          icon: Icons.location_on,
          title: 'Location',
          value: 'New York, NY, USA',
          onTap: () {
            // Launch maps app
          },
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Send Me a Message',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 24),
        const ContactForm(),
      ],
    );
  }

  Widget _buildSocialSection(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getScreenPadding(context).horizontal,
        vertical: 64,
      ),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Text(
            'Connect With Me',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Follow me on social media to stay updated with my latest projects and activities.',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _buildSocialButton(
                context,
                'GitHub',
                FontAwesomeIcons.github,
                AppConstants.githubUrl,
              ),
              _buildSocialButton(
                context,
                'LinkedIn',
                FontAwesomeIcons.linkedin,
                AppConstants.linkedinUrl,
              ),
              _buildSocialButton(
                context,
                'Twitter',
                FontAwesomeIcons.twitter,
                AppConstants.twitterUrl,
              ),
              _buildSocialButton(
                context,
                'Instagram',
                FontAwesomeIcons.instagram,
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
    String name,
    IconData icon,
    String url,
  ) {
    return AnimatedCard(
      onTap: () {
        // Launch URL
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              icon,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 16),
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 