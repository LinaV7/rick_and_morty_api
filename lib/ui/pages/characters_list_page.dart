import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/models/character_model.dart';
import 'package:rick_and_morty/ui/theme/text_styles.dart';
import 'package:rick_and_morty/ui/widgets/character_card.dart';
import 'package:rick_and_morty/utils/character_service.dart';
import 'package:rick_and_morty/models/favorite_characters.dart';

class CharactersList extends StatefulWidget {
  const CharactersList({super.key});

  @override
  State<CharactersList> createState() => _CharactersListState();
}

class _CharactersListState extends State<CharactersList> {
  final CharacterService _characterService = CharacterService();
  final ScrollController _scrollController = ScrollController();
  List<Character> _characters = [];
  List<Character> _filteredCharacters = [];
  bool _isLoading = true;
  bool _isSearching = false;
  bool _isLoadingMore = false;
  int _page = 1;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCharacters();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreCharacters();
    }
  }

  // Загрузка первых персонажей
  Future<void> _loadCharacters() async {
    try {
      final characters = await _characterService.getCharacters(page: 1);
      setState(() {
        _characters = characters;
        _filteredCharacters = characters;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

// Подгрузка новых персонажей
  Future<void> _loadMoreCharacters() async {
    if (_isLoadingMore) return;
    setState(() {
      _isLoadingMore = true;
    });

    try {
      final newCharacters =
          await _characterService.getCharacters(page: _page + 1);
      setState(() {
        _characters.addAll(newCharacters);
        _filteredCharacters.addAll(newCharacters);
        _page++;
        _isLoadingMore = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingMore = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading more characters: $e')),
      );
    }
  }

  void _filterCharacters(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredCharacters = _characters;
      });
      return;
    }

    final lowerQuery = query.toLowerCase();

    setState(() {
      _filteredCharacters = _characters.where((character) {
        return character.name.toLowerCase().contains(lowerQuery) ||
            character.status.toLowerCase().contains(lowerQuery) ||
            character.species.toLowerCase().contains(lowerQuery) ||
            character.gender.toLowerCase().contains(lowerQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteCharacters = Provider.of<FavoriteCharacters>(context);

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  hintStyle: AppTextStyles.headline2(context),
                ),
                onChanged: _filterCharacters,
              )
            : const Text('Rick and Morty'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.cancel : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  _filterCharacters('');
                }
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _filteredCharacters.isEmpty
                ? Center(
                    child: Text(
                      'No characters found',
                      style: AppTextStyles.body(context),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount:
                        _filteredCharacters.length + (_isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= _filteredCharacters.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                        ); // Индикатор загрузки в конце списка
                      }
                      final character = _filteredCharacters[index];
                      return FutureBuilder<bool>(
                        future: favoriteCharacters.isFavorite(character),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CharacterCard(
                              character: character,
                              onFavoritePressed: () {},
                              isFavorite: false,
                            ); // Пока данные не загрузились
                          }
                          final isFavorite = snapshot.data!;
                          return CharacterCard(
                            character: character,
                            onFavoritePressed: () async {
                              if (isFavorite) {
                                await favoriteCharacters
                                    .removeFromFavorites(character);
                              } else {
                                await favoriteCharacters
                                    .addToFavorites(character);
                              }
                              setState(() {}); // Обновляем UI
                            },
                            isFavorite: isFavorite,
                          );
                        },
                      );
                    },
                  ),
      ),
    );
  }
}
