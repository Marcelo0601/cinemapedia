import 'dart:developer';

import 'package:cinemapedia/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  final currentIndex;
  const CustomBottomNavigation({super.key, this.currentIndex});

  // int getCurrentIndex(context) {
  // final  location = GoRouterState.of(context).matchedLocation;
  //   switch (location) {
  //     case "/":
  //       return 0;
  //     case "/categories":
  //       return 1;
  //     case "/favorites":
  //       return 2;
  //     default:
  //       return 0;
  //   }
  // }

  // void OnTapped(BuildContext context, index) {
  //   switch (index) {
  //     case 0:
  //       context.go("/");
  //       break;
  //     case 1:
  //       context.go("/");
  //       break;
  //     case 2:
  //       context.go("/favorites");
  //       break;
  //     default:
  //   }
  // }

  void OnTappedItem(BuildContext context, int value) {
    switch (value) {
      case 0:
        GoRouter.of(context).go("/home/0");
        break;
      case 1:
        GoRouter.of(context).go("/home/1");
        break;
      case 2:
        GoRouter.of(context).go("/home/2");
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (value) => OnTappedItem(context, value),
        currentIndex: currentIndex,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_max),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.label_outline), label: "Categories"),
          BottomNavigationBarItem(
              icon: Icon(Icons.label_outline), label: "Favorites"),
        ]);
  }
}
