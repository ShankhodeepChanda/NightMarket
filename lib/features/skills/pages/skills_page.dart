import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_page.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderPage(
      title: 'Skills',
      icon: Icons.work_outline,
      subtitle: 'Find student services or offer your own skills.',
    );
  }
}
