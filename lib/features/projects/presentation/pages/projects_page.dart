import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/utils/responsive_utils.dart';
import 'package:portfolio/core/widgets/footer.dart';
import 'package:portfolio/core/widgets/navigation_bar.dart';
import 'package:portfolio/features/home/presentation/widgets/project_card.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomNavigationBar(currentRoute: AppConstants.projectsRoute),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(context),
                    _buildProjectsGrid(context),
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
            'My Projects',
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
              'Here are some of the projects I\'ve worked on. Each project showcases different skills and technologies I\'ve mastered over the years.',
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

  Widget _buildProjectsGrid(BuildContext context) {
    return Container(
      padding: ResponsiveUtils.getScreenPadding(context).copyWith(
        top: 40,
        bottom: 60,
      ),
      color: Theme.of(context).colorScheme.background,
      child: ResponsiveUtils.responsiveWrapper(
        context: context,
        mobile: _buildMobileProjectGrid(context),
        tablet: _buildTabletProjectGrid(context),
        desktop: _buildDesktopProjectGrid(context),
      ),
    );
  }

  Widget _buildMobileProjectGrid(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: AppConstants.projects.length,
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