import 'package:flutter/material.dart';
import 'package:rick_and_morty/ui/pages/characters_list_page.dart';
import 'package:rick_and_morty/ui/pages/favorites_page.dart';
import 'package:rick_and_morty/ui/pages/settings_page.dart';
import 'package:rick_and_morty/ui/theme/colors.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const CharactersList(),
    const FavoritesPage(),
    const SettingsPage(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page,
          selectedItemColor: AppColors.selectedNavBarColor,
          unselectedItemColor: AppColors.unselectedNavBarColor,
          backgroundColor: AppColors.backgroundColor,
          iconSize: 28,
          onTap: updatePage,
          items: [
            // HOME
            BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: bottomBarBorderWidth,
                          color: _page == 0
                              ? AppColors.selectedNavBarColor
                              : AppColors.backgroundColor)),
                ),
                child: const Icon(Icons.home_outlined),
              ),
              label: 'Home',
            ),
            // FAVORITES
            BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: bottomBarBorderWidth,
                          color: _page == 1
                              ? AppColors.selectedNavBarColor
                              : AppColors.backgroundColor)),
                ),
                child: const Icon(Icons.favorite_outline),
              ),
              label: 'Favorites',
            ),
            // SETTINGS
            BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: bottomBarBorderWidth,
                          color: _page == 2
                              ? AppColors.selectedNavBarColor
                              : AppColors.backgroundColor)),
                ),
                child: const Icon(Icons.settings),
              ),
              label: 'Settings',
            ),
          ]),
    );
  }
}
