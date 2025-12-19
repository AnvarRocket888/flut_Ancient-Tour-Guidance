import 'package:flutter/cupertino.dart';

enum ChallengeCategory {
  courage,
  friendliness,
  adventure,
  charisma,
  creativity,
  surprise,
}

extension ChallengeCategoryExtension on ChallengeCategory {
  String get name {
    switch (this) {
      case ChallengeCategory.courage:
        return 'Courage';
      case ChallengeCategory.friendliness:
        return 'Friendliness';
      case ChallengeCategory.adventure:
        return 'Adventure';
      case ChallengeCategory.charisma:
        return 'Charisma';
      case ChallengeCategory.creativity:
        return 'Creativity';
      case ChallengeCategory.surprise:
        return 'Surprise';
    }
  }

  Color get color {
    switch (this) {
      case ChallengeCategory.courage:
        return const Color(0xFFE74C3C); // Красный
      case ChallengeCategory.friendliness:
        return const Color(0xFFF39C12); // Оранжевый
      case ChallengeCategory.adventure:
        return const Color(0xFF3498DB); // Синий
      case ChallengeCategory.charisma:
        return const Color(0xFF9B59B6); // Фиолетовый
      case ChallengeCategory.creativity:
        return const Color(0xFFE91E63); // Розовый
      case ChallengeCategory.surprise:
        return const Color(0xFF2ECC71); // Зеленый
    }
  }

  String get icon {
    switch (this) {
      case ChallengeCategory.courage:
        return '🦁';
      case ChallengeCategory.friendliness:
        return '🤝';
      case ChallengeCategory.adventure:
        return '🗺️';
      case ChallengeCategory.charisma:
        return '✨';
      case ChallengeCategory.creativity:
        return '🎨';
      case ChallengeCategory.surprise:
        return '🎭';
    }
  }
}
