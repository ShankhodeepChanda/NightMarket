import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderPage(
      title: 'Home',
      icon: Icons.home_outlined,
      subtitle: 'Your personalized Night Market feed will appear here.',
    );
  }
}
