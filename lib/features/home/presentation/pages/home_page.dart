import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/utils/responsive_utils.dart';
import 'package:portfolio/core/widgets/animated_button.dart';
import 'package:portfolio/core/widgets/animated_card.dart';
import 'package:portfolio/core/widgets/footer.dart';
import 'package:portfolio/core/widgets/model_viewer.dart';
import 'package:portfolio/core/widgets/navigation_bar.dart';
import 'package:portfolio/core/widgets/parallax_container.dart';
import 'package:portfolio/features/home/presentation/widgets/project_card.dart';
import 'package:portfolio/features/home/presentation/widgets/skill_chip.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomNavigationBar(currentRoute: AppConstants.homeRoute),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeroSection(context),
                    _buildAboutSection(context),
                    _buildSkillsSection(context),
                    _buildProjectsSection(context),
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

  Widget _buildHeroSection(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      height: screenHeight * 0.8,
      width: double.infinity,
      padding: ResponsiveUtils.getScreenPadding(context),
      child: isMobile
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeroText(context),
                const SizedBox(height: 40),
                _buildHeroModel(context),
                const SizedBox(height: 40),
                _buildHeroButtons(context),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeroText(context),
                      const SizedBox(height: 40),
                      _buildHeroButtons(context),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: _buildHeroModel(context),
                ),
              ],
            ),
    );
  }

  Widget _buildHeroText(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, I\'m',
          style: TextStyle(
            fontSize: ResponsiveUtils.getFontSize(context, 24),
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppConstants.name,
          style: TextStyle(
            fontSize: ResponsiveUtils.getFontSize(context, 48),
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 50,
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Flutter Developer',
                textStyle: TextStyle(
                  fontSize: ResponsiveUtils.getFontSize(context, 24),
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'UI/UX Enthusiast',
                textStyle: TextStyle(
                  fontSize: ResponsiveUtils.getFontSize(context, 24),
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'Mobile App Developer',
                textStyle: TextStyle(
                  fontSize: ResponsiveUtils.getFontSize(context, 24),
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                speed: const Duration(milliseconds: 100),
              ),
            ],
            totalRepeatCount: 3,
            pause: const Duration(milliseconds: 1000),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: isMobile ? double.infinity : 500,
          child: Text(
            AppConstants.bio,
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: TextStyle(
              fontSize: ResponsiveUtils.getFontSize(context, 16),
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroModel(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: ModelViewer(
        modelPath: 'assets/models/developer.obj',
        backgroundColor: Colors.transparent,
      ),
    );
  }

  Widget _buildHeroButtons(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    
    return Row(
      mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        AnimatedButton(
          text: 'View Projects',
          icon: Icons.work,
          onPressed: () => context.go(AppConstants.projectsRoute),
        ),
        const SizedBox(width: 16),
        AnimatedButton(
          text: 'Contact Me',
          icon: Icons.email,
          isOutlined: true,
          onPressed: () => context.go(AppConstants.contactRoute),
        ),
      ],
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    
    return Container(
      padding: ResponsiveUtils.getScreenPadding(context),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            'About Me',
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
          isMobile
              ? Column(
                  children: [
                    _buildAboutImage(context),
                    const SizedBox(height: 32),
                    _buildAboutContent(context),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildAboutImage(context),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      flex: 3,
                      child: _buildAboutContent(context),
                    ),
                  ],
                ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildAboutImage(BuildContext context) {
    return ParallaxContainer(
      child: AnimatedCard(
        enableRotation: false,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/profile.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 400,
          ),
        ),
      ),
    );
  }

  Widget _buildAboutContent(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Who am I?',
          style: TextStyle(
            fontSize: ResponsiveUtils.getFontSize(context, 24),
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'I\'m ${AppConstants.name}, a passionate ${AppConstants.title} based in ${AppConstants.location}.',
          style: TextStyle(
            fontSize: ResponsiveUtils.getFontSize(context, 18),
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 16),
        Text(
          'With several years of experience in mobile app development, I specialize in creating beautiful, responsive, and feature-rich applications using Flutter. I have a strong foundation in software architecture, state management, and UI/UX design principles.',
          style: TextStyle(
            fontSize: ResponsiveUtils.getFontSize(context, 16),
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            height: 1.5,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 16),
        Text(
          'I\'m passionate about creating applications that not only look great but also provide an exceptional user experience. I enjoy solving complex problems and continuously learning new technologies to stay at the forefront of mobile development.',
          style: TextStyle(
            fontSize: ResponsiveUtils.getFontSize(context, 16),
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            height: 1.5,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 24),
        isMobile
            ? Center(
                child: AnimatedButton(
                  text: 'Download Resume',
                  icon: Icons.download,
                  onPressed: () => context.go(AppConstants.resumeRoute),
                ),
              )
            : AnimatedButton(
                text: 'Download Resume',
                icon: Icons.download,
                onPressed: () => context.go(AppConstants.resumeRoute),
              ),
      ],
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    return Container(
      padding: ResponsiveUtils.getScreenPadding(context),
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            'My Skills',
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
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
    return Container(
      padding: ResponsiveUtils.getScreenPadding(context),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            'Featured Projects',
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
          ResponsiveUtils.responsiveWrapper(
            context: context,
            mobile: _buildMobileProjectGrid(context),
            tablet: _buildTabletProjectGrid(context),
            desktop: _buildDesktopProjectGrid(context),
          ),
          const SizedBox(height: 32),
          AnimatedButton(
            text: 'View All Projects',
            icon: Icons.arrow_forward,
            onPressed: () => context.go(AppConstants.projectsRoute),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildMobileProjectGrid(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: AppConstants.projects.length > 2 ? 2 : AppConstants.projects.length,
      separatorBuilder: (context, index) => const SizedBox(height: 24),
      itemBuilder: (context, index) {
        final project = AppConstants.projects[index];
        return ProjectCard(
          title: project['title'],
          description: project['description'],
          imageUrl: project['imageUrl'],
          technologies: List<String>.from(project['technologies']),
          onTap: () => context.go('${AppConstants.projectsRoute}/$index'),
        );
      },
    );
  }

  Widget _buildTabletProjectGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 0.8,
      ),
      itemCount: AppConstants.projects.length > 4 ? 4 : AppConstants.projects.length,
      itemBuilder: (context, index) {
        final project = AppConstants.projects[index];
        return ProjectCard(
          title: project['title'],
          description: project['description'],
          imageUrl: project['imageUrl'],
          technologies: List<String>.from(project['technologies']),
          onTap: () => context.go('${AppConstants.projectsRoute}/$index'),
        );
      },
    );
  }

  Widget _buildDesktopProjectGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 0.8,
      ),
      itemCount: AppConstants.projects.length,
      itemBuilder: (context, index) {
        final project = AppConstants.projects[index];
        return ProjectCard(
          title: project['title'],
          description: project['description'],
          imageUrl: project['imageUrl'],
          technologies: List<String>.from(project['technologies']),
          onTap: () => context.go('${AppConstants.projectsRoute}/$index'),
        );
      },
    );
  }
} 