enum ArtifactRarity {
  common,
  rare,
  epic,
  legendary,
}

extension ArtifactRarityExtension on ArtifactRarity {
  String get name {
    switch (this) {
      case ArtifactRarity.common:
        return 'Common';
      case ArtifactRarity.rare:
        return 'Rare';
      case ArtifactRarity.epic:
        return 'Epic';
      case ArtifactRarity.legendary:
        return 'Legendary';
    }
  }

  String get color {
    switch (this) {
      case ArtifactRarity.common:
        return '#95A5A6'; // Grey
      case ArtifactRarity.rare:
        return '#3498DB'; // Blue
      case ArtifactRarity.epic:
        return '#9B59B6'; // Purple
      case ArtifactRarity.legendary:
        return '#F39C12'; // Gold
    }
  }

  String get emoji {
    switch (this) {
      case ArtifactRarity.common:
        return '⚪️';
      case ArtifactRarity.rare:
        return '🔵';
      case ArtifactRarity.epic:
        return '🟣';
      case ArtifactRarity.legendary:
        return '🟡';
    }
  }
}

class Artifact {
  final String id;
  final String name;
  final String emoji;
  final ArtifactRarity rarity;
  final String description;
  final String legend;
  final DateTime? unlockedAt;
  bool isUnlocked;

  Artifact({
    required this.id,
    required this.name,
    required this.emoji,
    required this.rarity,
    required this.description,
    required this.legend,
    this.isUnlocked = false,
    this.unlockedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'emoji': emoji,
        'rarity': rarity.name,
        'description': description,
        'legend': legend,
        'isUnlocked': isUnlocked,
        'unlockedAt': unlockedAt?.toIso8601String(),
      };

  factory Artifact.fromJson(Map<String, dynamic> json) => Artifact(
        id: json['id'],
        name: json['name'],
        emoji: json['emoji'],
        rarity: ArtifactRarity.values.firstWhere(
          (e) => e.name == json['rarity'],
          orElse: () => ArtifactRarity.common,
        ),
        description: json['description'],
        legend: json['legend'],
        isUnlocked: json['isUnlocked'] ?? false,
        unlockedAt: json['unlockedAt'] != null
            ? DateTime.parse(json['unlockedAt'])
            : null,
      );

  static List<Artifact> getDefaultArtifacts() {
    return [
      // Legendary (3)
      Artifact(
        id: 'legendary_1',
        name: 'Eye of Horus Amulet',
        emoji: '👁️',
        rarity: ArtifactRarity.legendary,
        description: 'Ancient protection symbol',
        legend:
            'Said to grant the bearer divine sight and protection from evil. Worn by pharaohs in battle.',
      ),
      Artifact(
        id: 'legendary_2',
        name: 'Scarab of Eternity',
        emoji: '🪲',
        rarity: ArtifactRarity.legendary,
        description: 'Symbol of rebirth and sun',
        legend:
            'Legend says it was used in the mummification of Tutankhamun, granting eternal life.',
      ),
      Artifact(
        id: 'legendary_3',
        name: 'Ankh of Life',
        emoji: '☥',
        rarity: ArtifactRarity.legendary,
        description: 'Key to immortality',
        legend:
            'The gods held this symbol to unlock the gates between life and death.',
      ),

      // Epic (4)
      Artifact(
        id: 'epic_1',
        name: 'Golden Serpent Crown',
        emoji: '🐍',
        rarity: ArtifactRarity.epic,
        description: 'Royal uraeus diadem',
        legend:
            'Worn by queens of Egypt, it symbolized sovereignty and divine authority.',
      ),
      Artifact(
        id: 'epic_2',
        name: 'Papyrus of Secrets',
        emoji: '📜',
        rarity: ArtifactRarity.epic,
        description: 'Ancient wisdom scroll',
        legend:
            'Contains spells from the Book of the Dead, written by temple priests.',
      ),
      Artifact(
        id: 'epic_3',
        name: 'Nefertiti\'s Mirror',
        emoji: '🪞',
        rarity: ArtifactRarity.epic,
        description: 'Queen\'s bronze mirror',
        legend:
            'The mirror of Egypt\'s most beautiful queen, said to reveal true beauty.',
      ),
      Artifact(
        id: 'epic_4',
        name: 'Osiris Statue',
        emoji: '🗿',
        rarity: ArtifactRarity.epic,
        description: 'God of the afterlife',
        legend:
            'Placed in tombs to guide souls to the underworld and ensure safe passage.',
      ),

      // Rare (6)
      Artifact(
        id: 'rare_1',
        name: 'Canopic Jar',
        emoji: '🏺',
        rarity: ArtifactRarity.rare,
        description: 'Organ preservation vessel',
        legend:
            'Used to store organs during mummification, protected by four guardian gods.',
      ),
      Artifact(
        id: 'rare_2',
        name: 'Lotus Flower Charm',
        emoji: '🪷',
        rarity: ArtifactRarity.rare,
        description: 'Symbol of creation',
        legend:
            'Represents rebirth and the sun, worn for spiritual awakening.',
      ),
      Artifact(
        id: 'rare_3',
        name: 'Djed Pillar Pendant',
        emoji: '⚱️',
        rarity: ArtifactRarity.rare,
        description: 'Stability and strength',
        legend:
            'Represents the spine of Osiris, grants the bearer unwavering strength.',
      ),
      Artifact(
        id: 'rare_4',
        name: 'Cat Goddess Bastet',
        emoji: '🐱',
        rarity: ArtifactRarity.rare,
        description: 'Protection deity',
        legend:
            'Goddess of home and fertility, brings joy and wards off evil spirits.',
      ),
      Artifact(
        id: 'rare_5',
        name: 'Falcon Wing Brooch',
        emoji: '🦅',
        rarity: ArtifactRarity.rare,
        description: 'Horus symbol',
        legend:
            'Represents the sky god Horus, grants vision and swift decision-making.',
      ),
      Artifact(
        id: 'rare_6',
        name: 'Pyramid Stone',
        emoji: '🔺',
        rarity: ArtifactRarity.rare,
        description: 'Builder\'s token',
        legend:
            'Fragment from the Great Pyramid, carries the energy of ancient builders.',
      ),

      // Common (7)
      Artifact(
        id: 'common_1',
        name: 'Clay Tablet',
        emoji: '🧱',
        rarity: ArtifactRarity.common,
        description: 'Ancient writing practice',
        legend: 'Used by scribes to practice hieroglyphics in temple schools.',
      ),
      Artifact(
        id: 'common_2',
        name: 'Palm Leaf Fan',
        emoji: '🍃',
        rarity: ArtifactRarity.common,
        description: 'Royal servant\'s tool',
        legend: 'Used to cool the pharaoh during hot desert days.',
      ),
      Artifact(
        id: 'common_3',
        name: 'Bronze Coin',
        emoji: '🪙',
        rarity: ArtifactRarity.common,
        description: 'Marketplace currency',
        legend: 'Common trade coin from the Ptolemaic period.',
      ),
      Artifact(
        id: 'common_4',
        name: 'Wooden Anklet',
        emoji: '💍',
        rarity: ArtifactRarity.common,
        description: 'Common jewelry',
        legend: 'Worn by everyday Egyptians for decoration.',
      ),
      Artifact(
        id: 'common_5',
        name: 'Reed Basket',
        emoji: '🧺',
        rarity: ArtifactRarity.common,
        description: 'Carrying vessel',
        legend: 'Used to transport goods along the Nile.',
      ),
      Artifact(
        id: 'common_6',
        name: 'Oil Lamp',
        emoji: '🪔',
        rarity: ArtifactRarity.common,
        description: 'Light source',
        legend: 'Illuminated homes and temples after sunset.',
      ),
      Artifact(
        id: 'common_7',
        name: 'Nile Water Jar',
        emoji: '⚱️',
        rarity: ArtifactRarity.common,
        description: 'Water container',
        legend: 'Carried sacred Nile water for daily rituals.',
      ),
    ];
  }
}
