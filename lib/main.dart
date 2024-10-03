import 'package:flutter/material.dart';
import 'package:grocery/core/models/product/product_viewmodel.dart';
import 'package:grocery/core/models/tools_viewmodel.dart';
import 'package:grocery/views/auth/splash.dart';
import 'package:provider/provider.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/on_generate_route.dart';
import 'core/themes/app_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductVM(),
        ),
        ChangeNotifierProvider(
          create: (context) => ToolsVM(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'eGrocery',
        theme: AppTheme.defaultTheme,
        onGenerateRoute: RouteGenerator.onGenerate,
        initialRoute: AppRoutes.introScreen,
        home: const SplashScreen(),
      ),
    );
  }
}
