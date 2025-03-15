import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/features/contact/presentation/pages/contact_page.dart';
import 'package:portfolio/features/game/presentation/pages/game_page.dart';
import 'package:portfolio/features/home/presentation/pages/home_page.dart';
import 'package:portfolio/features/projects/presentation/pages/project_detail_page.dart';
import 'package:portfolio/features/projects/presentation/pages/projects_page.dart';
import 'package:portfolio/features/resume/presentation/pages/resume_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppConstants.homeRoute,
    routes: [
      GoRoute(
        path: AppConstants.homeRoute,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppConstants.projectsRoute,
        builder: (context, state) => const ProjectsPage(),
      ),
      GoRoute(
        path: AppConstants.projectDetailRoute,
        builder: (context, state) {
          final projectId = int.parse(state.pathParameters['id'] ?? '0');
          return ProjectDetailPage(projectId: projectId);
        },
      ),
      GoRoute(
        path: AppConstants.resumeRoute,
        builder: (context, state) => const ResumePage(),
      ),
      GoRoute(
        path: AppConstants.contactRoute,
        builder: (context, state) => const ContactPage(),
      ),
      GoRoute(
        path: AppConstants.gameRoute,
        builder: (context, state) => const GamePage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '404',
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Page not found',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.go(AppConstants.homeRoute),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
} 