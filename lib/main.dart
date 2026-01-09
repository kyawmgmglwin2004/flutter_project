import 'package:flutter/material.dart';
import 'package:ntt/core/route/app_route.dart';
import 'package:ntt/core/theme/app_theme.dart';
import 'package:ntt/feature/Facility/facility_index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.root,
      routes: {
        AppRoute.root : (context) => const Searchpage() ,
      },
      theme: AppTheme.lightTheme,

       );
  }
}
