import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/responsive_utils.dart';
import 'package:portfolio/core/widgets/animated_card.dart';
import 'package:portfolio/core/widgets/navigation_bar.dart';
import 'package:portfolio/core/widgets/scroll_animation.dart';
import 'package:portfolio/core/widgets/section_title.dart';
import 'package:portfolio/features/contact/presentation/widgets/contact_form.dart';
import 'package:portfolio/features/contact/presentation/widgets/contact_info_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    _buildMapSection(context),
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
      child: ScrollAnimation(
        animationType: AnimationType.fadeIn,
        duration: const Duration(milliseconds: 800),
        child: Column(
          children: [
            const SectionTitle(
              title: 'Get In Touch',
              subtitle: 'Feel free to reach out to me for any inquiries or collaboration opportunities.',
            ),
          ],
        ),
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
                ScrollAnimation(
                  animationType: AnimationType.slideLeft,
                  child: _buildContactInfo(context),
                ),
                const SizedBox(height: 32),
                ScrollAnimation(
                  animationType: AnimationType.slideRight,
                  child: _buildContactForm(context),
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: ScrollAnimation(
                    animationType: AnimationType.slideLeft,
                    child: _buildContactInfo(context),
                  ),
                ),
                const SizedBox(width: 64),
                Expanded(
                  flex: 3,
                  child: ScrollAnimation(
                    animationType: AnimationType.slideRight,
                    child: _buildContactForm(context),
                  ),
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
        ScrollAnimation(
          animationType: AnimationType.fadeIn,
          delay: const Duration(milliseconds: 100),
          child: ContactInfoCard(
            icon: Icons.email,
            title: 'Email',
            value: AppConstants.email,
            onTap: () => _launchUrl('mailto:${AppConstants.email}'),
          ),
        ),
        const SizedBox(height: 16),
        ScrollAnimation(
          animationType: AnimationType.fadeIn,
          delay: const Duration(milliseconds: 200),
          child: ContactInfoCard(
            icon: Icons.phone,
            title: 'Phone',
            value: AppConstants.phone,
            onTap: () => _launchUrl('tel:${AppConstants.phone}'),
          ),
        ),
        const SizedBox(height: 16),
        ScrollAnimation(
          animationType: AnimationType.fadeIn,
          delay: const Duration(milliseconds: 300),
          child: ContactInfoCard(
            icon: Icons.location_on,
            title: 'Location',
            value: AppConstants.location,
            onTap: () => _launchUrl('https://maps.google.com/?q=${AppConstants.location}'),
          ),
        ),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Office Hours',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              _buildOfficeHoursRow(context, 'Monday - Friday', '9:00 AM - 5:00 PM'),
              const SizedBox(height: 8),
              _buildOfficeHoursRow(context, 'Saturday', '10:00 AM - 2:00 PM'),
              const SizedBox(height: 8),
              _buildOfficeHoursRow(context, 'Sunday', 'Closed'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOfficeHoursRow(BuildContext context, String day, String hours) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Text(
          hours,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        ),
      ),
      child: Column(
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
          const SizedBox(height: 8),
          Text(
            'I\'ll get back to you as soon as possible.',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 24),
          const ContactForm(),
        ],
      ),
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
      color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      child: ScrollAnimation(
        animationType: AnimationType.fadeIn,
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
                ScrollAnimation(
                  animationType: AnimationType.scale,
                  delay: const Duration(milliseconds: 100),
                  child: _buildSocialButton(
                    context,
                    'GitHub',
                    FontAwesomeIcons.github,
                    AppConstants.githubUrl,
                  ),
                ),
                ScrollAnimation(
                  animationType: AnimationType.scale,
                  delay: const Duration(milliseconds: 200),
                  child: _buildSocialButton(
                    context,
                    'LinkedIn',
                    FontAwesomeIcons.linkedin,
                    AppConstants.linkedinUrl,
                  ),
                ),
                ScrollAnimation(
                  animationType: AnimationType.scale,
                  delay: const Duration(milliseconds: 300),
                  child: _buildSocialButton(
                    context,
                    'Twitter',
                    FontAwesomeIcons.twitter,
                    AppConstants.twitterUrl,
                  ),
                ),
                ScrollAnimation(
                  animationType: AnimationType.scale,
                  delay: const Duration(milliseconds: 400),
                  child: _buildSocialButton(
                    context,
                    'Instagram',
                    FontAwesomeIcons.instagram,
                    AppConstants.instagramUrl,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(
    BuildContext context,
    String name,
    IconData icon,
    String url,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        ),
      ),
      child: InkWell(
        onTap: () => _launchUrl(url),
        borderRadius: BorderRadius.circular(16),
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
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapSection(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      color: Theme.of(context).colorScheme.surface,
      child: Stack(
        children: [
          // Placeholder for a map
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            child: Center(
              child: Icon(
                Icons.map,
                size: 100,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              ),
            ),
          ),
          // Overlay with location info
          Positioned(
            top: 32,
            left: 32,
            child: Container(
              padding: const EdgeInsets.all(24),
              width: 300,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'My Location',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          AppConstants.location,
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => _launchUrl('https://maps.google.com/?q=${AppConstants.location}'),
                    icon: const Icon(Icons.directions),
                    label: const Text('Get Directions'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // Handle error
      debugPrint('Could not launch $urlString');
    }
  }
} 