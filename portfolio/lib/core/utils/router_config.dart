import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/features/contact/presentation/pages/contact_page.dart';
import 'package:portfolio/features/game/presentation/pages/game_page.dart';
import 'package:portfolio/features/home/presentation/pages/home_page.dart';
import 'package:portfolio/features/projects/presentation/pages/project_detail_page.dart';
import 'package:portfolio/features/projects/presentation/pages/projects_page.dart';
import 'package:portfolio/features/resume/presentation/pages/resume_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter routerConfig = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppConstants.homeRoute,
  debugLogDiagnostics: true,
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
      path: '${AppConstants.projectsRoute}/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '1') ?? 1;
        return ProjectDetailPage(projectId: id);
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
  errorBuilder: (context, state) {
    if (kDebugMode) {
      print('Navigation error: ${state.error}');
    }
    return const HomePage();
  },
  redirect: (context, state) {
    // Add any redirect logic here if needed
    return null; // No redirect
  },
); 