import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/character_model.dart';
import 'package:rick_and_morty/ui/theme/text_styles.dart';
import 'package:rick_and_morty/ui/widgets/custom_text_with_icon.dart';

class CharacterPage extends StatelessWidget {
  final Character character;
  const CharacterPage({super.key, required this.character});

  IconData getGenderIcon(String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return Icons.male;
      case 'female':
        return Icons.female;
      default:
        return Icons.transgender;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                  height: height / 2, child: Image.network(character.image)),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextWithIcon(
                      text: character.name,
                      style: AppTextStyles.headline1(context),
                    ),
                    CustomTextWithIcon(
                      text: character.status != 'unknown'
                          ? '${character.status} - ${character.species}'
                          : character.species,
                      padding: const EdgeInsets.only(bottom: 10),
                      style: AppTextStyles.subtitle,
                    ),
                    CustomTextWithIcon(
                      text: 'Gender: ${character.gender}',
                      icon: getGenderIcon(character.gender),
                      padding: const EdgeInsets.only(top: 10),
                      style: AppTextStyles.headline3(context),
                    ),
                    if (character.type.isNotEmpty)
                      CustomTextWithIcon(
                        text: 'Type: ${character.type}',
                        icon: Icons.category,
                        padding: const EdgeInsets.only(top: 10),
                        style: AppTextStyles.headline3(context),
                      ),
                    if (character.origin.name.isNotEmpty)
                      CustomTextWithIcon(
                        text: 'Origin: ${character.origin.name}',
                        padding: const EdgeInsets.only(top: 10),
                        icon: Icons.my_location_rounded,
                        style: AppTextStyles.headline3(context),
                      ),
                    if (character.location.name.isNotEmpty)
                      CustomTextWithIcon(
                        text: 'Location: ${character.location.name}',
                        padding: const EdgeInsets.only(top: 10),
                        icon: Icons.location_on,
                        style: AppTextStyles.headline3(context),
                      ),
                    if (character.episode.isNotEmpty)
                      CustomTextWithIcon(
                        text: 'Episode: ${character.episode.length}',
                        padding: const EdgeInsets.only(top: 10),
                        icon: Icons.movie,
                        style: AppTextStyles.headline3(context),
                      ),
                    CustomTextWithIcon(
                      text: 'Created: ${character.created.toLocal()}',
                      padding: const EdgeInsets.only(top: 10),
                      style: AppTextStyles.subtitle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
