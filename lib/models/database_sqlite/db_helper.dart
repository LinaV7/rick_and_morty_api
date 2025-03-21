import 'dart:convert';
import 'package:path/path.dart';
import 'package:rick_and_morty/models/character_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'favorites.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites(
        id INTEGER PRIMARY KEY,
        name TEXT,
        status TEXT,
        species TEXT,
        type TEXT,
        gender TEXT,
        origin TEXT,
        location TEXT,
        image TEXT,
        episode TEXT,
        url TEXT,
        created TEXT
      )
    ''');
  }

  Future<void> insertFavorite(Character character) async {
    final db = await database;
    await db.insert(
      'favorites',
      {
        'id': character.id,
        'name': character.name,
        'status': character.status,
        'species': character.species,
        'type': character.type,
        'gender': character.gender,
        'origin': jsonEncode(character.origin.toMap()),
        'location': jsonEncode(character.location.toMap()),
        'image': character.image,
        'episode': jsonEncode(character.episode),
        'url': character.url,
        'created': character.created.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavorite(int id) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Character>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');

    return maps.map((map) {
      return Character(
        id: map['id'],
        name: map['name'],
        status: map['status'],
        species: map['species'],
        type: map['type'],
        gender: map['gender'],
        origin: CharacterLocation.fromJson(jsonDecode(map['origin'])),
        location: CharacterLocation.fromJson(jsonDecode(map['location'])),
        image: map['image'],
        episode: List<String>.from(jsonDecode(map['episode'] ?? '[]')),
        url: map['url'],
        created: DateTime.parse(map['created']),
      );
    }).toList();
  }

  Future<bool> isFavorite(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty;
  }
}
