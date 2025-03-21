import 'dart:convert';

class Character {
  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final CharacterLocation origin;
  final CharacterLocation location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json["id"] as int? ?? 0,
      name: json["name"] as String? ?? '',
      status: json["status"] as String? ?? '',
      species: json["species"] as String? ?? '',
      type: json["type"] as String? ?? '',
      gender: json["gender"] as String? ?? '',
      origin: CharacterLocation.fromJson(json["origin"] ?? {}),
      location: CharacterLocation.fromJson(json["location"] ?? {}),
      image: json["image"] as String? ?? '',
      episode: List<String>.from(
        (json["episode"] as List<dynamic>? ?? []).map((x) => x as String),
      ),
      url: json["url"] as String? ?? '',
      created:
          DateTime.tryParse(json["created"] as String? ?? '') ?? DateTime.now(),
    );
  }

  factory Character.empty() {
    return Character(
      id: 0,
      name: '',
      status: '',
      species: '',
      type: '',
      gender: '',
      origin: CharacterLocation.empty(),
      location: CharacterLocation.empty(),
      image: '',
      episode: [],
      url: '',
      created: DateTime.now(),
    );
  }

  // Преобразование объекта в Map для SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': jsonEncode(origin.toMap()),
      'location': jsonEncode(location.toMap()),
      'image': image,
      'episode': jsonEncode(episode),
      'url': url,
      'created': created.toIso8601String(),
    };
  }

  //Преобразование Map в объект
  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      id: map['id'] as int? ?? 0,
      name: map['name'] as String? ?? '',
      status: map['status'] as String? ?? '',
      species: map['species'] as String? ?? '',
      type: map['type'] as String? ?? '',
      gender: map['gender'] as String? ?? '',
      origin: CharacterLocation.fromMap(
        jsonDecode(map['origin'] as String? ?? '{}'),
      ),
      location: CharacterLocation.fromMap(
        jsonDecode(map['location'] as String? ?? '{}'),
      ),
      image: map['image'] as String? ?? '',
      episode: List<String>.from(
        jsonDecode(map['episode'] as String? ?? '[]'),
      ),
      url: map['url'] as String? ?? '',
      created:
          DateTime.tryParse(map['created'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

class CharacterLocation {
  CharacterLocation({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  factory CharacterLocation.fromJson(Map<String, dynamic> json) {
    return CharacterLocation(
      name: json["name"] as String? ?? '',
      url: json["url"] as String? ?? '',
    );
  }

  factory CharacterLocation.empty() {
    return CharacterLocation(
      name: '',
      url: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
    };
  }

  factory CharacterLocation.fromMap(Map<String, dynamic> map) {
    return CharacterLocation(
      name: map['name'] as String? ?? '',
      url: map['url'] as String? ?? '',
    );
  }
}
