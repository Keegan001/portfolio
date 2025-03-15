import 'package:flutter/material.dart';
import 'package:portfolio/core/utils/responsive_utils.dart';
import 'package:portfolio/core/widgets/animated_card.dart';

class ExperienceCard extends StatelessWidget {
  final String company;
  final String position;
  final String duration;
  final String description;
  final List<String> achievements;

  const ExperienceCard({
    Key? key,
    required this.company,
    required this.position,
    required this.duration,
    required this.description,
    required this.achievements,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    
    return AnimatedCard(
      enableRotation: false,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        position,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.getFontSize(context, 20),
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        company,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.getFontSize(context, 16),
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    duration,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(
                fontSize: ResponsiveUtils.getFontSize(context, 16),
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
                height: 1.5,
              ),
            ),
            if (achievements.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Key Achievements:',
                style: TextStyle(
                  fontSize: ResponsiveUtils.getFontSize(context, 16),
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 8),
              ...achievements.map(
                (achievement) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.arrow_right,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          achievement,
                          style: TextStyle(
                            fontSize: ResponsiveUtils.getFontSize(context, 14),
                            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 