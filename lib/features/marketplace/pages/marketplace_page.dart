import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_page.dart';

class MarketplacePage extends StatelessWidget {
  const MarketplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderPage(
      title: 'Marketplace',
      icon: Icons.storefront_outlined,
      subtitle: 'Buy and sell products with fellow students.',
    );
  }
}
