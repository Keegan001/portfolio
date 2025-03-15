import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/utils/responsive_utils.dart';
import 'package:portfolio/core/utils/url_launcher_utils.dart';
import 'package:portfolio/core/widgets/animated_button.dart';
import 'package:portfolio/core/widgets/footer.dart';
import 'package:portfolio/core/widgets/navigation_bar.dart';
import 'package:portfolio/core/widgets/parallax_container.dart';

class ProjectDetailPage extends StatelessWidget {
  final int projectId;

  const ProjectDetailPage({
    Key? key,
    required this.projectId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final project = AppConstants.projects[projectId];
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomNavigationBar(currentRoute: AppConstants.projectsRoute),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(context, project),
                    _buildProjectDetails(context, project),
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

  Widget _buildHeader(BuildContext context, Map<String, dynamic> project) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(project['imageUrl']),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              project['title'],
              style: TextStyle(
                fontSize: ResponsiveUtils.getFontSize(context, 48),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
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
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: (project['technologies'] as List<String>)
                  .map(
                    (tech) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        tech,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectDetails(BuildContext context, Map<String, dynamic> project) {
    final isMobile = ResponsiveUtils.isMobile(context);
    
    return Container(
      padding: ResponsiveUtils.getScreenPadding(context).copyWith(
        top: 60,
        bottom: 60,
      ),
      color: Theme.of(context).colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Project Overview',
            style: TextStyle(
              fontSize: ResponsiveUtils.getFontSize(context, 32),
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            project['description'],
            style: TextStyle(
              fontSize: ResponsiveUtils.getFontSize(context, 16),
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'Key Features',
            style: TextStyle(
              fontSize: ResponsiveUtils.getFontSize(context, 24),
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 16),
          _buildFeaturesList(context),
          const SizedBox(height: 40),
          Text(
            'Project Gallery',
            style: TextStyle(
              fontSize: ResponsiveUtils.getFontSize(context, 24),
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 16),
          _buildGallery(context),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              AnimatedButton(
                text: 'View Live',
                icon: Icons.language,
                onPressed: () => UrlLauncherUtils.launchURL(project['liveUrl']),
              ),
              const SizedBox(width: 16),
              AnimatedButton(
                text: 'View Code',
                icon: FontAwesomeIcons.github,
                isOutlined: true,
                onPressed: () => UrlLauncherUtils.launchURL(project['githubUrl']),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesList(BuildContext context) {
    // Sample features for demonstration
    final features = [
      'User authentication and authorization',
      'Real-time data synchronization',
      'Offline support with local database',
      'Push notifications',
      'Responsive UI for different screen sizes',
      'Dark mode support',
    ];
    
    return Column(
      children: features
          .map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      feature,
                      style: TextStyle(
                        fontSize: ResponsiveUtils.getFontSize(context, 16),
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildGallery(BuildContext context) {
    // Sample gallery images for demonstration
    final galleryImages = [
      'assets/images/project1.jpg',
      'assets/images/project2.jpg',
      'assets/images/project3.jpg',
      'assets/images/project4.jpg',
    ];
    
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: galleryImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ParallaxContainer(
              direction: Axis.horizontal,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  galleryImages[index],
                  height: 250,
                  width: 350,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
} 