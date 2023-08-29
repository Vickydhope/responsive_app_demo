import 'package:flutter/material.dart';
import 'package:responsive_app_demo/app/config/themes/app_theme.dart';
import 'package:responsive_app_demo/app/features/dashboard/presentation/view/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive App ',
      theme: AppTheme.basic,
      home: DashboardPage(),
    );
  }
}
