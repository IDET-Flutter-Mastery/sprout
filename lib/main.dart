import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/home_menu_screen.dart';
import 'theme/app_theme.dart';

/// -----------------------------------------------------------------------
/// main.dart — DONE, no edits needed.
/// -----------------------------------------------------------------------
/// ProviderScope wraps the whole app once, here at the root — this is the
/// "kitchen" every provider's cached value lives in. Every ref.watch /
/// ref.read anywhere below this needs it to exist.
/// -----------------------------------------------------------------------
void main() {
  runApp(
    const ProviderScope(
      child: SproutApp(),
    ),
  );
}

class SproutApp extends StatelessWidget {
  const SproutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sprout',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomeMenuScreen(),
    );
  }
}
