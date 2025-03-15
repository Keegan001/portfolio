import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/responsive_utils.dart';
import 'package:portfolio/core/widgets/flip_card.dart';
import 'package:portfolio/core/widgets/navigation_bar.dart';
import 'package:portfolio/core/widgets/scroll_animation.dart';
import 'package:portfolio/core/widgets/section_title.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomNavigationBar(currentRoute: AppConstants.projectsRoute),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(context),
                    _buildProjectsGrid(context),
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
              title: 'My Projects',
              subtitle: 'Here are some of my recent projects that showcase my skills and experience.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);
    
    // Determine number of columns based on screen size
    int crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getScreenPadding(context).horizontal,
        vertical: 32,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: isMobile ? 1.2 : 1,
        ),
        itemCount: demoProjects.length,
        itemBuilder: (context, index) {
          final project = demoProjects[index];
          return ScrollAnimation(
            animationType: AnimationType.slideUp,
            delay: Duration(milliseconds: 100 * index),
            child: _buildProjectCard(context, project),
          );
        },
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Project project) {
    return FlipCard(
      onTap: () => context.go('${AppConstants.projectsRoute}/${project.id}'),
      height: 350,
      frontWidget: _buildProjectFront(context, project),
      backWidget: _buildProjectBack(context, project),
    );
  }

  Widget _buildProjectFront(BuildContext context, Project project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Project Image
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(0.7),
                  AppColors.secondary.withOpacity(0.7),
                ],
              ),
            ),
            child: Center(
              child: Icon(
                project.icon,
                size: 64,
                color: Colors.white,
              ),
            ),
          ),
        ),
        // Project Info
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  project.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                // Technologies
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.technologies.map((tech) => _buildTechChip(context, tech)).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectBack(BuildContext context, Project project) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            project.icon,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            project.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Click to view project details',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => context.go('${AppConstants.projectsRoute}/${project.id}'),
            icon: const Icon(Icons.visibility),
            label: const Text('View Details'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechChip(BuildContext context, String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        tech,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class Project {
  final int id;
  final String title;
  final String description;
  final List<String> technologies;
  final IconData icon;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.technologies,
    required this.icon,
  });
}

final List<Project> demoProjects = [
  Project(
    id: 1,
    title: 'Portfolio Website',
    description: 'A responsive portfolio website built with Flutter Web.',
    technologies: ['Flutter', 'Dart', 'Web'],
    icon: FontAwesomeIcons.globe,
  ),
  Project(
    id: 2,
    title: 'E-Commerce App',
    description: 'A full-featured e-commerce application with payment integration.',
    technologies: ['Flutter', 'Firebase', 'Stripe'],
    icon: FontAwesomeIcons.cartShopping,
  ),
  Project(
    id: 3,
    title: 'Task Management',
    description: 'A productivity app for managing tasks and projects.',
    technologies: ['Flutter', 'Bloc', 'Hive'],
    icon: FontAwesomeIcons.listCheck,
  ),
  Project(
    id: 4,
    title: 'Weather App',
    description: 'A weather forecasting app with beautiful UI and animations.',
    technologies: ['Flutter', 'API', 'Animations'],
    icon: FontAwesomeIcons.cloudSun,
  ),
  Project(
    id: 5,
    title: 'Social Media App',
    description: 'A social networking platform with real-time messaging.',
    technologies: ['Flutter', 'Firebase', 'WebSockets'],
    icon: FontAwesomeIcons.users,
  ),
  Project(
    id: 6,
    title: 'Fitness Tracker',
    description: 'An app to track workouts, nutrition, and health metrics.',
    technologies: ['Flutter', 'HealthKit', 'Charts'],
    icon: FontAwesomeIcons.heartPulse,
  ),
]; 