# Portfolio Website

A modern portfolio website built with Flutter, featuring a responsive design, dark/light theme, and interactive elements.

## Features

- Responsive design that works on mobile, tablet, and desktop
- Dark and light theme support
- Interactive UI elements and animations
- Project showcase with detailed project pages
- Resume/CV section with experience, education, and skills
- Contact form with validation
- Memory card game for fun interaction
- Social media links

## Tech Stack

- Flutter for cross-platform development
- Provider for state management
- GoRouter for navigation
- Google Fonts for typography
- Lottie for animations
- Font Awesome for icons
- URL Launcher for external links

## Getting Started

1. **Clone the repository**

```bash
git clone https://github.com/yourusername/portfolio.git
cd portfolio
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Add required assets**

Make sure to add all the required images in the `assets/images/` directory as specified in the README.md file in that directory.

4. **Run the app**

```bash
flutter run -d chrome
```

## Project Structure

The project follows a clean architecture approach with feature-based organization:

```
lib/
  core/
    constants/
    theme/
    utils/
    widgets/
  features/
    home/
    projects/
    resume/
    contact/
    game/
  l10n/
  main.dart
```

## Customization

To customize this portfolio for your own use:

1. Update personal information in `lib/core/constants/app_constants.dart`
2. Replace project images and descriptions
3. Update resume information with your own experience and education
4. Add your own social media links
5. Customize the theme colors in `lib/core/theme/app_theme.dart`

## License

This project is open source and available under the MIT License.
