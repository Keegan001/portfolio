import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/responsive_utils.dart';
import 'package:portfolio/core/widgets/flip_card.dart';
import 'package:portfolio/core/widgets/navigation_bar.dart';
import 'package:portfolio/core/widgets/scroll_animation.dart';
import 'package:portfolio/core/widgets/section_title.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ResumePage extends StatelessWidget {
  const ResumePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _downloadResume(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        icon: const Icon(Icons.download),
        label: const Text('Download CV'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const CustomNavigationBar(currentRoute: AppConstants.resumeRoute),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(context),
                    isMobile
                        ? Column(
                            children: [
                              _buildExperienceSection(context),
                              _buildEducationSection(context),
                              _buildSkillsSection(context),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: _buildExperienceSection(context),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    _buildEducationSection(context),
                                    _buildSkillsSection(context),
                                  ],
                                ),
                              ),
                            ],
                          ),
                    _buildCertificationsSection(context),
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
              title: 'Resume',
              subtitle: 'My education, work experience, and skills',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getScreenPadding(context).horizontal,
        vertical: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScrollAnimation(
            animationType: AnimationType.slideLeft,
            child: Text(
              'Work Experience',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ScrollAnimation(
            animationType: AnimationType.slideUp,
            delay: const Duration(milliseconds: 100),
            child: _buildExperienceCard(
              context,
              'Senior Flutter Developer',
              'Tech Solutions Inc.',
              '2021 - Present',
              'Led the development of multiple mobile applications using Flutter. Implemented clean architecture and BLoC pattern for state management. Mentored junior developers and conducted code reviews.',
            ),
          ),
          const SizedBox(height: 16),
          ScrollAnimation(
            animationType: AnimationType.slideUp,
            delay: const Duration(milliseconds: 200),
            child: _buildExperienceCard(
              context,
              'Flutter Developer',
              'Mobile Apps Co.',
              '2019 - 2021',
              'Developed and maintained cross-platform mobile applications using Flutter. Collaborated with designers to implement UI/UX designs. Integrated RESTful APIs and Firebase services.',
            ),
          ),
          const SizedBox(height: 16),
          ScrollAnimation(
            animationType: AnimationType.slideUp,
            delay: const Duration(milliseconds: 300),
            child: _buildExperienceCard(
              context,
              'Junior Mobile Developer',
              'Startup Innovations',
              '2018 - 2019',
              'Assisted in the development of mobile applications using Flutter and React Native. Implemented UI components and fixed bugs. Participated in daily stand-up meetings and sprint planning.',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(
    BuildContext context,
    String position,
    String company,
    String duration,
    String description,
  ) {
    return FlipCard(
      height: 220,
      flipOnHover: false,
      frontWidget: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    position,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    duration,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              company,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.touch_app),
                label: const Text('Tap to see details'),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                ),
              ),
            ),
          ],
        ),
      ),
      backWidget: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Key Responsibilities',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            _buildResponsibilityItem(context, 'Developed and maintained mobile applications'),
            _buildResponsibilityItem(context, 'Collaborated with cross-functional teams'),
            _buildResponsibilityItem(context, 'Implemented new features and fixed bugs'),
            _buildResponsibilityItem(context, 'Participated in code reviews'),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: null,
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Summary'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsibilityItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            size: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getScreenPadding(context).horizontal,
        vertical: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScrollAnimation(
            animationType: AnimationType.slideRight,
            child: Text(
              'Education',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ScrollAnimation(
            animationType: AnimationType.slideUp,
            delay: const Duration(milliseconds: 100),
            child: _buildEducationCard(
              context,
              'Master of Computer Science',
              'University of Technology',
              '2016 - 2018',
              'Specialized in Mobile Computing and Software Engineering. Graduated with distinction.',
            ),
          ),
          const SizedBox(height: 16),
          ScrollAnimation(
            animationType: AnimationType.slideUp,
            delay: const Duration(milliseconds: 200),
            child: _buildEducationCard(
              context,
              'Bachelor of Computer Science',
              'State University',
              '2012 - 2016',
              'Focused on Software Development and Database Management. Participated in various hackathons and coding competitions.',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationCard(
    BuildContext context,
    String degree,
    String institution,
    String duration,
    String description,
  ) {
    return Container(
      width: double.infinity,
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
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  degree,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  duration,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            institution,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getScreenPadding(context).horizontal,
        vertical: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScrollAnimation(
            animationType: AnimationType.slideRight,
            child: Text(
              'Skills',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ScrollAnimation(
            animationType: AnimationType.fadeIn,
            delay: const Duration(milliseconds: 100),
            child: _buildSkillCategory(
              context,
              'Programming Languages',
              ['Dart', 'JavaScript', 'TypeScript', 'Python', 'Java'],
            ),
          ),
          const SizedBox(height: 16),
          ScrollAnimation(
            animationType: AnimationType.fadeIn,
            delay: const Duration(milliseconds: 200),
            child: _buildSkillCategory(
              context,
              'Frameworks & Libraries',
              ['Flutter', 'React', 'Node.js', 'Express', 'Django'],
            ),
          ),
          const SizedBox(height: 16),
          ScrollAnimation(
            animationType: AnimationType.fadeIn,
            delay: const Duration(milliseconds: 300),
            child: _buildSkillCategory(
              context,
              'Tools & Technologies',
              ['Git', 'Firebase', 'AWS', 'Docker', 'CI/CD'],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCategory(
    BuildContext context,
    String category,
    List<String> skills,
  ) {
    return Container(
      width: double.infinity,
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
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) => _buildSkillChip(context, skill)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(BuildContext context, String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Text(
        skill,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildCertificationsSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getScreenPadding(context).horizontal,
        vertical: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScrollAnimation(
            animationType: AnimationType.slideLeft,
            child: Text(
              'Certifications',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 24),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: ResponsiveUtils.isMobile(context) ? 1 : 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: [
              ScrollAnimation(
                animationType: AnimationType.scale,
                delay: const Duration(milliseconds: 100),
                child: _buildCertificationCard(
                  context,
                  'Flutter Developer Certification',
                  'Google',
                  '2022',
                  FontAwesomeIcons.google,
                ),
              ),
              ScrollAnimation(
                animationType: AnimationType.scale,
                delay: const Duration(milliseconds: 200),
                child: _buildCertificationCard(
                  context,
                  'AWS Certified Developer',
                  'Amazon Web Services',
                  '2021',
                  FontAwesomeIcons.aws,
                ),
              ),
              ScrollAnimation(
                animationType: AnimationType.scale,
                delay: const Duration(milliseconds: 300),
                child: _buildCertificationCard(
                  context,
                  'Certified Scrum Master',
                  'Scrum Alliance',
                  '2020',
                  FontAwesomeIcons.screwdriverWrench,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationCard(
    BuildContext context,
    String title,
    String issuer,
    String year,
    IconData icon,
  ) {
    return Container(
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
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '$issuer • $year',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _downloadResume(BuildContext context) async {
    // In a real app, this would download the actual resume
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Resume downloaded successfully!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        action: SnackBarAction(
          label: 'View',
          textColor: Theme.of(context).colorScheme.onPrimary,
          onPressed: () {
            // Open the downloaded file
          },
        ),
      ),
    );
  }
} 