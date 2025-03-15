import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/theme/theme_provider.dart';
import 'package:portfolio/core/utils/responsive_utils.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomNavigationBar extends StatelessWidget {
  final String currentRoute;

  const CustomNavigationBar({
    Key? key,
    required this.currentRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getScreenPadding(context).horizontal,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: isMobile
          ? _buildMobileNavBar(context, themeProvider)
          : _buildDesktopNavBar(context, themeProvider),
    );
  }

  Widget _buildDesktopNavBar(BuildContext context, ThemeProvider themeProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(context),
        Row(
          children: [
            _buildNavItem(
              context,
              'Home',
              AppConstants.homeRoute,
              currentRoute == AppConstants.homeRoute,
            ),
            _buildNavItem(
              context,
              'Projects',
              AppConstants.projectsRoute,
              currentRoute == AppConstants.projectsRoute,
            ),
            _buildNavItem(
              context,
              'Resume',
              AppConstants.resumeRoute,
              currentRoute == AppConstants.resumeRoute,
            ),
            _buildNavItem(
              context,
              'Contact',
              AppConstants.contactRoute,
              currentRoute == AppConstants.contactRoute,
            ),
            _buildNavItem(
              context,
              'Game',
              AppConstants.gameRoute,
              currentRoute == AppConstants.gameRoute,
            ),
            const SizedBox(width: 16),
            _buildThemeToggle(context, themeProvider),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileNavBar(BuildContext context, ThemeProvider themeProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(context),
        Row(
          children: [
            _buildThemeToggle(context, themeProvider),
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                _showMobileMenu(context);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLogo(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(AppConstants.homeRoute),
      child: Row(
        children: [
          Text(
            AppConstants.name.split(' ')[0],
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            ' ${AppConstants.name.split(' ')[1]}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String title,
    String route,
    bool isActive,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () => context.go(route),
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isActive
                ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isActive
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context, ThemeProvider themeProvider) {
    return IconButton(
      icon: Icon(
        themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      onPressed: () {
        themeProvider.setThemeMode(
          themeProvider.isDarkMode ? ThemeMode.light : ThemeMode.dark,
        );
      },
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMobileMenuItem(
                context,
                'Home',
                AppConstants.homeRoute,
                Icons.home,
              ),
              _buildMobileMenuItem(
                context,
                'Projects',
                AppConstants.projectsRoute,
                Icons.work,
              ),
              _buildMobileMenuItem(
                context,
                'Resume',
                AppConstants.resumeRoute,
                Icons.description,
              ),
              _buildMobileMenuItem(
                context,
                'Contact',
                AppConstants.contactRoute,
                Icons.contact_mail,
              ),
              _buildMobileMenuItem(
                context,
                'Game',
                AppConstants.gameRoute,
                Icons.games,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileMenuItem(
    BuildContext context,
    String title,
    String route,
    IconData icon,
  ) {
    final isActive = currentRoute == route;

    return ListTile(
      leading: Icon(
        icon,
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        context.go(route);
      },
    );
  }
} 