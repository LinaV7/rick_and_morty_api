import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/models/character_model.dart';
import 'package:rick_and_morty/utils/constants.dart';

class CharacterService {
  Future<List<Character>> getCharacters({int page = 1}) async {
    final response =
        await http.get(Uri.parse('${ApiConstants.characters}?page=$page'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<Character> characters = (data['results'] as List)
          .map((json) => Character.fromJson(json))
          .toList();
      return characters;
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
