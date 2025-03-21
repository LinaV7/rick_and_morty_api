import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/models/character_model.dart';
import 'package:rick_and_morty/ui/widgets/character_card.dart';
import 'package:rick_and_morty/models/favorite_characters.dart';
import 'package:rick_and_morty/ui/widgets/filters_widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<String> filters = ['All', 'Human', 'Alien'];
  final List<String> filters2 = ['All', 'Alive', 'Dead'];
  late String selectedFilter;
  late String selectedFilter2;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
    selectedFilter2 = filters2[0];
    // Загружаем избранное при открытии страницы
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FavoriteCharacters>(context, listen: false).loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteCharacters = Provider.of<FavoriteCharacters>(context);

    final filteredFavorites = favoriteCharacters.favorites.where((character) {
      final species = character.species.trim().toLowerCase();
      final status = character.status.trim().toLowerCase();

      final speciesMatch =
          selectedFilter == 'All' || species == selectedFilter.toLowerCase();
      final statusMatch =
          selectedFilter2 == 'All' || status == selectedFilter2.toLowerCase();

      return speciesMatch && statusMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            FiltersWidget(
              filters: filters,
              filters2: filters2,
              selectedFilter: selectedFilter,
              selectedFilter2: selectedFilter2,
              onFilterChanged: (newFilter) {
                setState(() {
                  selectedFilter = newFilter;
                });
              },
              onFilter2Changed: (newFilter) {
                setState(() {
                  selectedFilter2 = newFilter;
                });
              },
            ),
            Expanded(
              child: filteredFavorites.isEmpty
                  ? const Center(
                      child: Text('No favorites yet'),
                    )
                  : AnimatedList(
                      key: _listKey,
                      initialItemCount: filteredFavorites.length,
                      itemBuilder: (context, index, animation) {
                        if (index >= filteredFavorites.length) {
                          return Container();
                        }
                        final character = filteredFavorites[index];
                        return SizeTransition(
                          sizeFactor: animation,
                          child: CharacterCard(
                            character: character,
                            onFavoritePressed: () {
                              _removeCharacter(
                                  index, character, favoriteCharacters);
                            },
                            isFavorite: true,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeCharacter(
      int index, Character character, FavoriteCharacters favoriteCharacters) {
    _listKey.currentState!.removeItem(
      index,
      (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: CharacterCard(
            character: character,
            onFavoritePressed: () {},
            isFavorite: true,
          ),
        );
      },
      duration: const Duration(milliseconds: 300),
    );

    favoriteCharacters.removeFromFavorites(character);
  }
}
