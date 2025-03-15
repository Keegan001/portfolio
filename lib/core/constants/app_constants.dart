class AppConstants {
  // Personal Information
  static const String name = 'John Doe';
  static const String title = 'Flutter Developer';
  static const String email = 'john.doe@example.com';
  static const String phone = '+1 (123) 456-7890';
  static const String location = 'New York, USA';
  static const String bio = 'Passionate Flutter developer with expertise in creating beautiful, responsive, and feature-rich applications. Experienced in building cross-platform mobile apps and web applications using Flutter.';
  
  // Social Media Links
  static const String githubUrl = 'https://github.com/johndoe';
  static const String linkedinUrl = 'https://linkedin.com/in/johndoe';
  static const String twitterUrl = 'https://twitter.com/johndoe';
  static const String instagramUrl = 'https://instagram.com/johndoe';
  
  // Skills
  static const List<String> skills = [
    'Flutter',
    'Dart',
    'Firebase',
    'RESTful APIs',
    'State Management',
    'UI/UX Design',
    'Git',
    'Clean Architecture',
    'Test-Driven Development',
    'Responsive Design',
  ];
  
  // Projects
  static const List<Map<String, dynamic>> projects = [
    {
      'title': 'E-Commerce App',
      'description': 'A full-featured e-commerce application with product catalog, cart, payment integration, and order tracking.',
      'technologies': ['Flutter', 'Firebase', 'Stripe', 'Provider'],
      'imageUrl': 'assets/images/project1.jpg',
      'githubUrl': 'https://github.com/johndoe/ecommerce-app',
      'liveUrl': 'https://ecommerce-app.example.com',
    },
    {
      'title': 'Task Management App',
      'description': 'A productivity app for managing tasks, setting reminders, and tracking progress with beautiful UI and smooth animations.',
      'technologies': ['Flutter', 'Hive', 'BLoC', 'Local Notifications'],
      'imageUrl': 'assets/images/project2.jpg',
      'githubUrl': 'https://github.com/johndoe/task-manager',
      'liveUrl': 'https://task-manager.example.com',
    },
    {
      'title': 'Weather App',
      'description': 'A weather forecasting app with beautiful visualizations, location-based weather data, and 7-day forecasts.',
      'technologies': ['Flutter', 'OpenWeather API', 'Geolocator', 'Lottie Animations'],
      'imageUrl': 'assets/images/project3.jpg',
      'githubUrl': 'https://github.com/johndoe/weather-app',
      'liveUrl': 'https://weather-app.example.com',
    },
    {
      'title': 'Social Media App',
      'description': 'A social networking app with user profiles, posts, comments, likes, and real-time messaging.',
      'technologies': ['Flutter', 'Firebase', 'Cloud Functions', 'GetX'],
      'imageUrl': 'assets/images/project4.jpg',
      'githubUrl': 'https://github.com/johndoe/social-media-app',
      'liveUrl': 'https://social-app.example.com',
    },
  ];
  
  // Experience
  static const List<Map<String, dynamic>> experience = [
    {
      'company': 'Tech Solutions Inc.',
      'position': 'Senior Flutter Developer',
      'duration': 'Jan 2022 - Present',
      'description': 'Leading a team of Flutter developers to build and maintain multiple mobile applications. Implementing best practices, code reviews, and mentoring junior developers.',
      'achievements': [
        'Reduced app loading time by 40% through code optimization',
        'Implemented CI/CD pipeline for automated testing and deployment',
        'Migrated legacy apps to Flutter, resulting in 60% code reduction',
      ],
    },
    {
      'company': 'Mobile Innovations LLC',
      'position': 'Flutter Developer',
      'duration': 'Mar 2020 - Dec 2021',
      'description': 'Developed and maintained multiple Flutter applications for clients across various industries. Collaborated with designers and backend developers to deliver high-quality applications.',
      'achievements': [
        'Built 5+ production-ready Flutter applications',
        'Implemented complex animations and custom UI components',
        'Integrated third-party services and APIs',
      ],
    },
    {
      'company': 'StartUp Studio',
      'position': 'Junior Mobile Developer',
      'duration': 'Jun 2018 - Feb 2020',
      'description': 'Started as a native Android developer and transitioned to Flutter. Worked on various mobile applications and contributed to the company\'s internal libraries.',
      'achievements': [
        'Successfully transitioned from native Android to Flutter development',
        'Contributed to open-source Flutter packages',
        'Developed and published 3 apps on Google Play Store',
      ],
    },
  ];
  
  // Education
  static const List<Map<String, dynamic>> education = [
    {
      'institution': 'University of Technology',
      'degree': 'Master of Computer Science',
      'duration': '2016 - 2018',
      'description': 'Specialized in Mobile Computing and Software Engineering',
    },
    {
      'institution': 'State University',
      'degree': 'Bachelor of Science in Computer Science',
      'duration': '2012 - 2016',
      'description': 'Graduated with honors. Focused on Software Development and Algorithms',
    },
  ];
  
  // Certifications
  static const List<Map<String, dynamic>> certifications = [
    {
      'name': 'Flutter Development Bootcamp',
      'issuer': 'App Brewery',
      'date': 'Jan 2020',
      'url': 'https://example.com/cert1',
    },
    {
      'name': 'Firebase for Flutter',
      'issuer': 'Google',
      'date': 'Mar 2021',
      'url': 'https://example.com/cert2',
    },
    {
      'name': 'Advanced Dart Programming',
      'issuer': 'Udemy',
      'date': 'Nov 2021',
      'url': 'https://example.com/cert3',
    },
  ];
  
  // App Routes
  static const String homeRoute = '/';
  static const String projectsRoute = '/projects';
  static const String projectDetailRoute = '/projects/:id';
  static const String resumeRoute = '/resume';
  static const String contactRoute = '/contact';
  static const String gameRoute = '/game';
} 