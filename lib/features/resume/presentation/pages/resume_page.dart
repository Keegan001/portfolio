import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/utils/responsive_utils.dart';
import 'package:portfolio/core/widgets/animated_button.dart';
import 'package:portfolio/core/widgets/footer.dart';
import 'package:portfolio/core/widgets/navigation_bar.dart';
import 'package:portfolio/features/home/presentation/widgets/skill_chip.dart';
import 'package:portfolio/features/resume/presentation/widgets/education_card.dart';
import 'package:portfolio/features/resume/presentation/widgets/experience_card.dart';

class ResumePage extends StatelessWidget {
  const ResumePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomNavigationBar(currentRoute: AppConstants.resumeRoute),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(context),
                    _buildExperienceSection(context),
                    _buildEducationSection(context),
                    _buildSkillsSection(context),
                    _buildCertificationsSection(context),
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
            'My Resume',
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
              'Here\'s a summary of my professional experience, education, and skills. You can also download a PDF version of my resume.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ResponsiveUtils.getFontSize(context, 16),
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 32),
          AnimatedButton(
            text: 'Download Resume',
            icon: Icons.download,
            onPressed: () {
              // TODO: Implement resume download
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceSection(BuildContext context) {
    return Container(
      padding: ResponsiveUtils.getScreenPadding(context).copyWith(
        top: 60,
        bottom: 60,
      ),
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Text(
            'Work Experience',
            style: TextStyle(
              fontSize: ResponsiveUtils.getFontSize(context, 32),
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
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
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: AppConstants.experience.length,
            separatorBuilder: (context, index) => const SizedBox(height: 24),
            itemBuilder: (context, index) {
              final experience = AppConstants.experience[index];
              return ExperienceCard(
                company: experience['company'],
                position: experience['position'],
                duration: experience['duration'],
                description: experience['description'],
                achievements: List<String>.from(experience['achievements']),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEducationSection(BuildContext context) {
    return Container(
      padding: ResponsiveUtils.getScreenPadding(context).copyWith(
        top: 60,
        bottom: 60,
      ),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Text(
            'Education',
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
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: AppConstants.education.length,
            separatorBuilder: (context, index) => const SizedBox(height: 24),
            itemBuilder: (context, index) {
              final education = AppConstants.education[index];
              return EducationCard(
                institution: education['institution'],
                degree: education['degree'],
                duration: education['duration'],
                description: education['description'],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    return Container(
      padding: ResponsiveUtils.getScreenPadding(context).copyWith(
        top: 60,
        bottom: 60,
      ),
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Text(
            'Skills',
            style: TextStyle(
              fontSize: ResponsiveUtils.getFontSize(context, 32),
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
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
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: AppConstants.skills
                .map((skill) => SkillChip(skill: skill))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationsSection(BuildContext context) {
    return Container(
      padding: ResponsiveUtils.getScreenPadding(context).copyWith(
        top: 60,
        bottom: 60,
      ),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Text(
            'Certifications',
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
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: AppConstants.certifications.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final certification = AppConstants.certifications[index];
              return ListTile(
                leading: Icon(
                  Icons.verified,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  certification['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                subtitle: Text(
                  '${certification['issuer']} • ${certification['date']}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.open_in_new),
                  onPressed: () {
                    // TODO: Open certification URL
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
} 