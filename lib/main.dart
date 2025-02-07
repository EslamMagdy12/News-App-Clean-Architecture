import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/config/route/app_route.dart';
import 'package:news_app_clean_architecture/config/theme/app_theme.dart';
import 'package:news_app_clean_architecture/features/news/presentation/cubit/remote/article_cubit.dart';
import 'package:news_app_clean_architecture/core/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(); // Ensure all dependencies are initialized
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      title: 'News App',
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: AppRoutes.login,
    );
  }
}
