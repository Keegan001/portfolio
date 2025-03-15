import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/utils/page_transitions.dart';
import 'package:portfolio/features/contact/presentation/pages/contact_page.dart';
import 'package:portfolio/features/game/presentation/pages/game_page.dart';
import 'package:portfolio/features/home/presentation/pages/home_page.dart';
import 'package:portfolio/features/projects/presentation/pages/project_detail_page.dart';
import 'package:portfolio/features/projects/presentation/pages/projects_page.dart';
import 'package:portfolio/features/resume/presentation/pages/resume_page.dart';
import 'package:portfolio/features/splash/presentation/pages/splash_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppConstants.splashRoute,
  routes: [
    GoRoute(
      path: AppConstants.splashRoute,
      pageBuilder: (context, state) => FadeTransitionPage(
        child: const SplashPage(),
      ),
    ),
    GoRoute(
      path: AppConstants.homeRoute,
      pageBuilder: (context, state) => SlideTransitionPage(
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: AppConstants.projectsRoute,
      pageBuilder: (context, state) => SlideTransitionPage(
        child: const ProjectsPage(),
      ),
    ),
    GoRoute(
      path: '${AppConstants.projectsRoute}/:id',
      pageBuilder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '1') ?? 1;
        return SlideTransitionPage(
          child: ProjectDetailPage(projectId: id),
        );
      },
    ),
    GoRoute(
      path: AppConstants.resumeRoute,
      pageBuilder: (context, state) => SlideTransitionPage(
        child: const ResumePage(),
      ),
    ),
    GoRoute(
      path: AppConstants.contactRoute,
      pageBuilder: (context, state) => SlideTransitionPage(
        child: const ContactPage(),
      ),
    ),
    GoRoute(
      path: AppConstants.gameRoute,
      pageBuilder: (context, state) => ScaleTransitionPage(
        child: const GamePage(),
      ),
    ),
  ],
  errorBuilder: (context, state) => const HomePage(),
); 