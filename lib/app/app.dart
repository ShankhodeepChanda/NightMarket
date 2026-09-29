import 'package:flutter/material.dart';

import '../features/community/pages/community_page.dart';
import '../features/home/pages/home_page.dart';
import '../features/marketplace/pages/marketplace_page.dart';
import '../features/profile/pages/profile_page.dart';
import '../features/skills/pages/skills_page.dart';
import 'theme/app_theme.dart';

/// The root widget of the Night Market application.
///
/// Configures the app's theme, navigation structure, and persistent
/// bottom navigation bar.
class NightMarketApp extends StatelessWidget {
  const NightMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Night Market',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const MainScaffold(),
    );
  }
}

/// Main scaffold with persistent bottom navigation.
class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  static const List<Widget> _pages = [
    HomePage(),
    MarketplacePage(),
    CommunityPage(),
    SkillsPage(),
    ProfilePage(),
  ];

  static const List<({IconData icon, String label})> _navItems = [
    (icon: Icons.home_outlined, label: 'Home'),
    (icon: Icons.storefront_outlined, label: 'Market'),
    (icon: Icons.school_outlined, label: 'Community'),
    (icon: Icons.work_outline, label: 'Skills'),
    (icon: Icons.person_outline, label: 'Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_navItems[_currentIndex].label),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: _navItems
            .map(
              (item) => BottomNavigationBarItem(
                icon: Icon(item.icon),
                label: item.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
