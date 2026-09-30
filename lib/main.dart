import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initialize();
  runApp(const NightMarketApp());
}
