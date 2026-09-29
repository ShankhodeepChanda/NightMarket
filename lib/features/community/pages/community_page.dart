import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_page.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderPage(
      title: 'Community',
      icon: Icons.school_outlined,
      subtitle: 'Discover colleges, clubs, and campus events.',
    );
  }
}
