import 'package:flutter/material.dart';
import 'package:josequal_papers/core/views/screens/details_screen.dart';
import 'package:josequal_papers/core/views/screens/favorites_screen.dart';
import 'package:josequal_papers/core/views/screens/home_screen.dart';
import 'package:josequal_papers/core/views/screens/search_screen.dart';

class AppRouter {
  AppRouter._();

  static final Map<String, WidgetBuilder> router = {
    HomeScreen.id : (context) => const HomeScreen(),
    SearchScreen.id: (context) => const SearchScreen(),
    DetailsScreen.id:(context) =>  const DetailsScreen(),
    FavoritesScreen.id:(context) => const FavoritesScreen(),
  };

}
