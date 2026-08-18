import 'package:flutter/material.dart';

import '../core/constants/app_strings.dart';
import 'routes.dart';

class SmartMenuApp extends StatelessWidget {
  const SmartMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3B7D5A)),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
