import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/character_model.dart';
import 'package:rick_and_morty/models/database_sqlite/db_helper.dart';

class FavoriteCharacters extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Character> _favorites = [];

  List<Character> get favorites => _favorites;

  FavoriteCharacters() {
    loadFavorites();
  }

  // Метод для загрузки избранных из базы данных
  Future<void> loadFavorites() async {
    _favorites = await _dbHelper.getFavorites();
    notifyListeners();
  }

  // Добавление в избранное
  Future<void> addToFavorites(Character character) async {
    if (!await _dbHelper.isFavorite(character.id)) {
      await _dbHelper.insertFavorite(character);
      await loadFavorites();
    }
  }

  // Удаление из избранного
  Future<void> removeFromFavorites(Character character) async {
    await _dbHelper.deleteFavorite(character.id);
    await loadFavorites();
  }

  // Проверка, находится ли персонаж в избранном
  Future<bool> isFavorite(Character character) async {
    return await _dbHelper.isFavorite(character.id);
  }
}
