enum RewardType {
  mysticalQuest,
  artifactHint,
  cosmicWisdom,
  travelerBlessing,
  ancientCurse,
}

class FortuneReward {
  final String title;
  final String emoji;
  final String description;
  final RewardType type;

  FortuneReward({
    required this.title,
    required this.emoji,
    required this.description,
    required this.type,
  });

  static List<FortuneReward> getAllRewards() {
    return [
      // Mystical Quests
      FortuneReward(
        title: 'The Sphinx\'s Riddle',
        emoji: '🦁',
        description: 'Ask 3 strangers an interesting question today',
        type: RewardType.mysticalQuest,
      ),
      FortuneReward(
        title: 'Pharaoh\'s Challenge',
        emoji: '👑',
        description: 'Visit a place you\'ve never been in the city',
        type: RewardType.mysticalQuest,
      ),
      FortuneReward(
        title: 'Anubis\' Trial',
        emoji: '🐕',
        description: 'Help someone find their way today',
        type: RewardType.mysticalQuest,
      ),
      FortuneReward(
        title: 'Ra\'s Blessing',
        emoji: '☀️',
        description: 'Watch the sunrise or sunset at a historic site',
        type: RewardType.mysticalQuest,
      ),

      // Artifact Hints
      FortuneReward(
        title: 'Ancient Whispers',
        emoji: '🔮',
        description: 'A rare artifact awaits discovery nearby...',
        type: RewardType.artifactHint,
      ),
      FortuneReward(
        title: 'Treasure Map',
        emoji: '🗺️',
        description: 'Complete 3 challenges to unlock a legendary item',
        type: RewardType.artifactHint,
      ),

      // Cosmic Wisdom
      FortuneReward(
        title: 'Thoth\'s Knowledge',
        emoji: '📚',
        description: 'Today is perfect for learning something new',
        type: RewardType.cosmicWisdom,
      ),
      FortuneReward(
        title: 'Isis\' Insight',
        emoji: '✨',
        description: 'Trust your intuition in unexpected situations',
        type: RewardType.cosmicWisdom,
      ),
      FortuneReward(
        title: 'Pyramid Power',
        emoji: '🔺',
        description: 'Your energy is aligned with adventure today',
        type: RewardType.cosmicWisdom,
      ),

      // Blessings
      FortuneReward(
        title: 'Nile\'s Fortune',
        emoji: '💧',
        description: 'Luck flows your way like the mighty Nile',
        type: RewardType.travelerBlessing,
      ),
      FortuneReward(
        title: 'Hathor\'s Joy',
        emoji: '💃',
        description: 'Music and celebration surround your path',
        type: RewardType.travelerBlessing,
      ),

      // Playful Curses
      FortuneReward(
        title: 'Sand Storm Warning',
        emoji: '🌪️',
        description: 'Beware of tourist traps today! Stay vigilant.',
        type: RewardType.ancientCurse,
      ),
      FortuneReward(
        title: 'Mummy\'s Revenge',
        emoji: '🧟',
        description: 'Your bargaining skills will be tested at bazaar',
        type: RewardType.ancientCurse,
      ),
    ];
  }
}
