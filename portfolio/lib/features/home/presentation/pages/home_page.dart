import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/utils/responsive_utils.dart';
import 'package:portfolio/core/widgets/animated_card.dart';
import 'package:portfolio/core/widgets/navigation_bar.dart';
import 'package:portfolio/core/widgets/section_title.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomNavigationBar(currentRoute: AppConstants.homeRoute),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeroSection(context),
                    _buildAboutSection(context),
                    _buildSkillsSection(context),
                    _buildCallToAction(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: screenHeight * 0.8,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getScreenPadding(context).horizontal,
        vertical: 32,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      ),
      child: isMobile
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroContent(context),
                const SizedBox(height: 32),
                _buildHeroImage(context, screenWidth),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: _buildHeroContent(context),
                ),
                Expanded(
                  flex: 2,
                  child: _buildHeroImage(context, screenWidth * 0.4),
                ),
              ],
            ),
    );
  }

  Widget _buildHeroContent(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Hello, I\'m',
          style: TextStyle(
            fontSize: isMobile ? 18 : 24,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppConstants.name,
          style: TextStyle(
            fontSize: isMobile ? 36 : 64,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 16),
        DefaultTextStyle(
          style: TextStyle(
            fontSize: isMobile ? 20 : 32,
            fontWeight: FontWeight.w300,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Flutter Developer & UI/UX Designer',
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'Mobile App Developer',
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'Web Developer',
                speed: const Duration(milliseconds: 100),
              ),
            ],
            repeatForever: true,
            pause: const Duration(milliseconds: 1000),
            displayFullTextOnTap: true,
          ),
        ),
        const SizedBox(height: 24),
        DefaultTextStyle(
          style: TextStyle(
            fontSize: isMobile ? 16 : 18,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'I build beautiful, responsive, and user-friendly mobile and web applications using Flutter.',
                speed: const Duration(milliseconds: 50),
              ),
            ],
            totalRepeatCount: 1,
            displayFullTextOnTap: true,
          ),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            ElevatedButton(
              onPressed: () => context.go(AppConstants.projectsRoute),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              child: const Text(
                'View Projects',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            OutlinedButton(
              onPressed: () => context.go(AppConstants.contactRoute),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              child: Text(
                'Contact Me',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            _buildSocialButton(
              context,
              FontAwesomeIcons.github,
              AppConstants.githubUrl,
            ),
            const SizedBox(width: 16),
            _buildSocialButton(
              context,
              FontAwesomeIcons.linkedin,
              AppConstants.linkedinUrl,
            ),
            const SizedBox(width: 16),
            _buildSocialButton(
              context,
              FontAwesomeIcons.twitter,
              AppConstants.twitterUrl,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroImage(BuildContext context, double width) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.person,
          size: width * 0.6,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
        ),
      ),
    );
  }

  Widget _buildSocialButton(
    BuildContext context,
    IconData icon,
    String url,
  ) {
    return InkWell(
      onTap: () {
        // Launch URL
      },
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: FaIcon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getScreenPadding(context).horizontal,
        vertical: 64,
      ),
      child: Column(
        children: [
          const SectionTitle(title: 'About Me'),
          const SizedBox(height: 32),
          isMobile
              ? Column(
                  children: [
                    _buildAboutContent(context),
                    const SizedBox(height: 32),
                    _buildAboutStats(context),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: _buildAboutContent(context),
                    ),
                    const SizedBox(width: 64),
                    Expanded(
                      flex: 2,
                      child: _buildAboutStats(context),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildAboutContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Who I Am',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'I am a passionate Flutter developer with a strong focus on creating beautiful and functional user interfaces. With a background in both mobile and web development, I bring a unique perspective to every project.',
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'My journey in software development began several years ago, and I have since worked on a variety of projects ranging from small business applications to large-scale enterprise solutions. I am constantly learning and exploring new technologies to stay at the forefront of the industry.',
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'When I\'m not coding, you can find me exploring new design trends, contributing to open-source projects, or enjoying outdoor activities.',
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutStats(BuildContext context) {
    return Column(
      children: [
        _buildStatCard(
          context,
          '3+',
          'Years Experience',
          Icons.calendar_today,
        ),
        const SizedBox(height: 16),
        _buildStatCard(
          context,
          '20+',
          'Projects Completed',
          Icons.work,
        ),
        const SizedBox(height: 16),
        _buildStatCard(
          context,
          '10+',
          'Happy Clients',
          Icons.people,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String value,
    String label,
    IconData icon,
  ) {
    return AnimatedCard(
      child: Container(
        padding: const EdgeInsets.all(24),
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
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color:
                        Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
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
          const SectionTitle(title: 'My Skills'),
          const SizedBox(height: 32),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _buildSkillCard(context, 'Flutter', FontAwesomeIcons.mobile),
              _buildSkillCard(context, 'Dart', FontAwesomeIcons.code),
              _buildSkillCard(context, 'Firebase', FontAwesomeIcons.fire),
              _buildSkillCard(context, 'UI/UX Design', FontAwesomeIcons.penRuler),
              _buildSkillCard(context, 'Responsive Design', FontAwesomeIcons.mobileScreen),
              _buildSkillCard(context, 'State Management', FontAwesomeIcons.cubes),
              _buildSkillCard(context, 'RESTful APIs', FontAwesomeIcons.server),
              _buildSkillCard(context, 'Git', FontAwesomeIcons.github),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(BuildContext context, String skill, IconData icon) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final width = isMobile ? 150.0 : 200.0;

    return AnimatedCard(
      child: Container(
        width: width,
        padding: const EdgeInsets.all(24),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              icon,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              skill,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallToAction(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getScreenPadding(context).horizontal,
        vertical: 64,
      ),
      child: Column(
        children: [
          Text(
            'Interested in working together?',
            style: TextStyle(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Let\'s build something amazing together!',
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => context.go(AppConstants.contactRoute),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            child: const Text(
              'Contact Me',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 