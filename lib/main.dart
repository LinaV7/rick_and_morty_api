import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/models/favorite_characters.dart';
import 'package:rick_and_morty/models/provider/theme_provider.dart';
import 'package:rick_and_morty/ui/pages/bottom_nav_bar.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => FavoriteCharacters(),
          ),
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ),
        ],
        child: const RickAndMorty(),
      ),
    );

class RickAndMorty extends StatelessWidget {
  const RickAndMorty({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Rick and Morty',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomBar();
  }
}
