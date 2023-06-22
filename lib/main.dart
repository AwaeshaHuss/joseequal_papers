import 'package:flutter/material.dart';
import 'package:josequal_papers/core/controllers/controllers.dart';
import 'package:josequal_papers/core/views/screens/home_screen.dart';
import 'package:josequal_papers/utils/utils.dart';
import 'package:provider/provider.dart';

main() {
  runApp(ChangeNotifierProvider(
      create: (context) => WallPapersController(), child: const SequalApp()));
}

class SequalApp extends StatelessWidget {
  const SequalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConsts.appTitle,
      theme: AppThemes.lightTheme,
      routes: AppRouter.router,
      initialRoute: HomeScreen.id,
    );
  }
}
