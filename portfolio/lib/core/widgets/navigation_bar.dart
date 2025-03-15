import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/theme_provider.dart';
import 'package:portfolio/core/utils/responsive_utils.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomNavigationBar extends StatefulWidget {
  final String currentRoute;

  const CustomNavigationBar({
    Key? key,
    required this.currentRoute,
  }) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels > 20 && !_isScrolled) {
          setState(() {
            _isScrolled = true;
          });
        } else if (notification.metrics.pixels <= 20 && _isScrolled) {
          setState(() {
            _isScrolled = false;
          });
        }
        return false;
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.getScreenPadding(context).horizontal,
          vertical: _isScrolled ? 12 : 16,
        ),
        decoration: BoxDecoration(
          color: _isScrolled 
              ? Theme.of(context).colorScheme.surface.withOpacity(0.95)
              : Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(_isScrolled ? 0.1 : 0.05),
              blurRadius: _isScrolled ? 10 : 5,
              offset: Offset(0, _isScrolled ? 2 : 1),
            ),
          ],
          borderRadius: _isScrolled 
              ? const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                )
              : BorderRadius.zero,
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: isMobile
              ? _buildMobileNavBar(context, themeProvider)
              : _buildDesktopNavBar(context, themeProvider),
        ),
      ),
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
              widget.currentRoute == AppConstants.homeRoute,
              Icons.home_outlined,
              Icons.home,
            ),
            _buildNavItem(
              context,
              'Projects',
              AppConstants.projectsRoute,
              widget.currentRoute == AppConstants.projectsRoute,
              Icons.work_outline,
              Icons.work,
            ),
            _buildNavItem(
              context,
              'Resume',
              AppConstants.resumeRoute,
              widget.currentRoute == AppConstants.resumeRoute,
              Icons.description_outlined,
              Icons.description,
            ),
            _buildNavItem(
              context,
              'Contact',
              AppConstants.contactRoute,
              widget.currentRoute == AppConstants.contactRoute,
              Icons.mail_outline,
              Icons.mail,
            ),
            _buildNavItem(
              context,
              'Game',
              AppConstants.gameRoute,
              widget.currentRoute == AppConstants.gameRoute,
              Icons.games_outlined,
              Icons.games,
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
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: AppColors.blueGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              AppConstants.name.split(' ')[0],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
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
    IconData inactiveIcon,
    IconData activeIcon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
            border: Border.all(
              color: isActive
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isActive ? activeIcon : inactiveIcon,
                size: 18,
                color: isActive
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: isActive
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context, ThemeProvider themeProvider) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: IconButton(
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return RotationTransition(
              turns: animation,
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          },
          child: Icon(
            themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            key: ValueKey<bool>(themeProvider.isDarkMode),
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        onPressed: () {
          themeProvider.setThemeMode(
            themeProvider.isDarkMode ? ThemeMode.light : ThemeMode.dark,
          );
        },
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Menu',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
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
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Close Menu',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
    final isActive = widget.currentRoute == route;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive
              ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
              : Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          context.go(route);
        },
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
            fontSize: 16,
          ),
        ),
        trailing: isActive
            ? Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.primary,
              )
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
    );
  }
} 