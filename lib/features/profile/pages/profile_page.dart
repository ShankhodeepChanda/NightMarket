import 'package:flutter/material.dart';
import 'package:night_market/core/services/auth_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_outline, size: 80, color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          Text('Profile', style: theme.textTheme.headlineMedium),
          const SizedBox(height: 8),
          const Text('View and edit your Night Market profile.'),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () async {
              await AuthService().signOut();
            },
            child: const Text('Sign Out'),
          )
        ],
      ),
    );
  }
}
