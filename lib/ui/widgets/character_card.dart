import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/character_model.dart';
import 'package:rick_and_morty/ui/pages/character_page.dart';
import 'package:rick_and_morty/ui/theme/colors.dart';
import 'package:rick_and_morty/ui/theme/text_styles.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback onFavoritePressed;
  final bool isFavorite;

  const CharacterCard({
    super.key,
    required this.character,
    required this.onFavoritePressed,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.backgroundColorBlack
          : AppColors.backgroundColor,
      elevation: 2.0,
      child: ListTile(
        leading: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              image: DecorationImage(
                image: NetworkImage(character.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: Text(
          character.name,
          style: AppTextStyles.headline2(context),
        ),
        subtitle: Text(
          character.status != 'unknown'
              ? '${character.status} - ${character.species}'
              : character.species,
          style: AppTextStyles.subtitle,
        ),
        trailing: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: IconButton(
            key: ValueKey<bool>(isFavorite),
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              size: 30,
              color: AppColors.secondary,
            ),
            onPressed: onFavoritePressed,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CharacterPage(character: character),
            ),
          );
        },
      ),
    );
  }
}
