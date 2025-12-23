import 'challenge_category.dart';

class Challenge {
  final String id;
  final String title;
  final ChallengeCategory category;
  bool isCompleted;

  Challenge({
    required this.id,
    required this.title,
    required this.category,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category.name,
        'isCompleted': isCompleted,
      };

  factory Challenge.fromJson(Map<String, dynamic> json) => Challenge(
        id: json['id'],
        title: json['title'],
        category: ChallengeCategory.values.firstWhere(
          (e) => e.name == json['category'],
          orElse: () => ChallengeCategory.courage,
        ),
        isCompleted: json['isCompleted'] ?? false,
      );

  static List<Challenge> getDefaultChallenges() {
    return [
      // Courage (8 challenges)
      Challenge(
        id: 'courage_1',
        title: 'Feed a crocodile by hand',
        category: ChallengeCategory.courage,
      ),
      Challenge(
        id: 'courage_2',
        title: 'Ride a camel without a saddle',
        category: ChallengeCategory.courage,
      ),
      Challenge(
        id: 'courage_3',
        title: 'Enter a pharaoh\'s tomb',
        category: ChallengeCategory.courage,
      ),
      Challenge(
        id: 'courage_4',
        title: 'Try local street food',
        category: ChallengeCategory.courage,
      ),
      Challenge(
        id: 'courage_5',
        title: 'Spend a night in the desert under the stars',
        category: ChallengeCategory.courage,
      ),
      Challenge(
        id: 'courage_6',
        title: 'Climb to the top of a pyramid',
        category: ChallengeCategory.courage,
      ),
      Challenge(
        id: 'courage_7',
        title: 'Explore an underground catacomb',
        category: ChallengeCategory.courage,
      ),
      Challenge(
        id: 'courage_8',
        title: 'Touch a mummy at the museum',
        category: ChallengeCategory.courage,
      ),
      Challenge(
        id: 'courage_9',
        title: 'Try scuba diving in Red Sea',
        category: ChallengeCategory.courage,
      ),
      Challenge(
        id: 'courage_10',
        title: 'Walk through Cairo at night alone',
        category: ChallengeCategory.courage,
      ),
      Challenge(
        id: 'courage_11',
        title: 'Eat falafel from street vendor',
        category: ChallengeCategory.courage,
      ),
      Challenge(
        id: 'courage_12',
        title: 'Ride a horse to the pyramids',
        category: ChallengeCategory.courage,
      ),

      // Friendliness (8 challenges)
      Challenge(
        id: 'friendliness_1',
        title: 'Take a photo with a local Egyptian',
        category: ChallengeCategory.friendliness,
      ),
      Challenge(
        id: 'friendliness_2',
        title: 'Learn 5 words in Arabic',
        category: ChallengeCategory.friendliness,
      ),
      Challenge(
        id: 'friendliness_3',
        title: 'Treat a local to tea',
        category: ChallengeCategory.friendliness,
      ),
      Challenge(
        id: 'friendliness_4',
        title: 'Chat with a bazaar merchant',
        category: ChallengeCategory.friendliness,
      ),
      Challenge(
        id: 'friendliness_5',
        title: 'Help a tourist find their way',
        category: ChallengeCategory.friendliness,
      ),
      Challenge(
        id: 'friendliness_6',
        title: 'Exchange contacts with a traveler',
        category: ChallengeCategory.friendliness,
      ),
      Challenge(
        id: 'friendliness_7',
        title: 'Share a meal with strangers',
        category: ChallengeCategory.friendliness,
      ),
      Challenge(
        id: 'friendliness_8',
        title: 'Teach someone a phrase in your language',
        category: ChallengeCategory.friendliness,
      ),
      Challenge(
        id: 'friendliness_9',
        title: 'Join a local for prayer at mosque',
        category: ChallengeCategory.friendliness,
      ),
      Challenge(
        id: 'friendliness_10',
        title: 'Help translate for someone',
        category: ChallengeCategory.friendliness,
      ),
      Challenge(
        id: 'friendliness_11',
        title: 'Give a small gift to a local child',
        category: ChallengeCategory.friendliness,
      ),
      Challenge(
        id: 'friendliness_12',
        title: 'Attend a local celebration',
        category: ChallengeCategory.friendliness,
      ),
      Challenge(
        id: 'friendliness_13',
        title: 'Share travel tips with another tourist',
        category: ChallengeCategory.friendliness,
      ),

      // Adventure (8 challenges)
      Challenge(
        id: 'adventure_1',
        title: 'Get lost in the bazaar labyrinths',
        category: ChallengeCategory.adventure,
      ),
      Challenge(
        id: 'adventure_2',
        title: 'Find a secret spot in Cairo',
        category: ChallengeCategory.adventure,
      ),
      Challenge(
        id: 'adventure_3',
        title: 'Take a Nile boat ride at sunset',
        category: ChallengeCategory.adventure,
      ),
      Challenge(
        id: 'adventure_4',
        title: 'Visit a place not in guidebooks',
        category: ChallengeCategory.adventure,
      ),
      Challenge(
        id: 'adventure_5',
        title: 'Navigate somewhere without a map',
        category: ChallengeCategory.adventure,
      ),
      Challenge(
        id: 'adventure_6',
        title: 'Visit 3 places in one day',
        category: ChallengeCategory.adventure,
      ),
      Challenge(
        id: 'adventure_7',
        title: 'Take a hot air balloon ride',
        category: ChallengeCategory.adventure,
      ),
      Challenge(
        id: 'adventure_8',
        title: 'Explore ancient ruins at dawn',
        category: ChallengeCategory.adventure,
      ),
      Challenge(
        id: 'adventure_9',
        title: 'Go sandboarding in the desert',
        category: ChallengeCategory.adventure,
      ),
      Challenge(
        id: 'adventure_10',
        title: 'Snorkel at coral reefs',
        category: ChallengeCategory.adventure,
      ),
      Challenge(
        id: 'adventure_11',
        title: 'Ride a quad bike through sand dunes',
        category: ChallengeCategory.adventure,
      ),
      Challenge(
        id: 'adventure_12',
        title: 'Watch sunrise from mountain top',
        category: ChallengeCategory.adventure,
      ),

      // Charisma (8 challenges)
      Challenge(
        id: 'charisma_1',
        title: 'Bargain at bazaar and get a discount',
        category: ChallengeCategory.charisma,
      ),
      Challenge(
        id: 'charisma_2',
        title: 'Tell a joke to a local',
        category: ChallengeCategory.charisma,
      ),
      Challenge(
        id: 'charisma_3',
        title: 'Give a speech in Arabic',
        category: ChallengeCategory.charisma,
      ),
      Challenge(
        id: 'charisma_4',
        title: 'Start a conversation with a stranger',
        category: ChallengeCategory.charisma,
      ),
      Challenge(
        id: 'charisma_5',
        title: 'Convince a guide to show secret spot',
        category: ChallengeCategory.charisma,
      ),
      Challenge(
        id: 'charisma_6',
        title: 'Make someone laugh in another language',
        category: ChallengeCategory.charisma,
      ),
      Challenge(
        id: 'charisma_7',
        title: 'Get invited to a local\'s home',
        category: ChallengeCategory.charisma,
      ),
      Challenge(
        id: 'charisma_8',
        title: 'Negotiate free entrance somewhere',
        category: ChallengeCategory.charisma,
      ),
      Challenge(
        id: 'charisma_9',
        title: 'Make friends with hotel staff',
        category: ChallengeCategory.charisma,
      ),
      Challenge(
        id: 'charisma_10',
        title: 'Get upgrade to better room/seat',
        category: ChallengeCategory.charisma,
      ),
      Challenge(
        id: 'charisma_11',
        title: 'Lead a group tour impromptu',
        category: ChallengeCategory.charisma,
      ),
      Challenge(
        id: 'charisma_12',
        title: 'Charm a restaurant owner for recipe',
        category: ChallengeCategory.charisma,
      ),

      // Creativity (8 challenges)
      Challenge(
        id: 'creativity_1',
        title: 'Draw a pyramid sketch',
        category: ChallengeCategory.creativity,
      ),
      Challenge(
        id: 'creativity_2',
        title: 'Create unique photo of attraction',
        category: ChallengeCategory.creativity,
      ),
      Challenge(
        id: 'creativity_3',
        title: 'Write a story about ancient Egypt',
        category: ChallengeCategory.creativity,
      ),
      Challenge(
        id: 'creativity_4',
        title: 'Make a sand sculpture',
        category: ChallengeCategory.creativity,
      ),
      Challenge(
        id: 'creativity_5',
        title: 'Compose a poem about Egypt',
        category: ChallengeCategory.creativity,
      ),
      Challenge(
        id: 'creativity_6',
        title: 'Create a travel photo collage',
        category: ChallengeCategory.creativity,
      ),
      Challenge(
        id: 'creativity_7',
        title: 'Paint a scene from your journey',
        category: ChallengeCategory.creativity,
      ),
      Challenge(
        id: 'creativity_8',
        title: 'Make a video montage of your trip',
        category: ChallengeCategory.creativity,
      ),
      Challenge(
        id: 'creativity_9',
        title: 'Design your own hieroglyphics',
        category: ChallengeCategory.creativity,
      ),
      Challenge(
        id: 'creativity_10',
        title: 'Create a travel journal with drawings',
        category: ChallengeCategory.creativity,
      ),
      Challenge(
        id: 'creativity_11',
        title: 'Make jewelry from local materials',
        category: ChallengeCategory.creativity,
      ),
      Challenge(
        id: 'creativity_12',
        title: 'Photograph all 7 colors of sunset',
        category: ChallengeCategory.creativity,
      ),
      Challenge(
        id: 'creativity_13',
        title: 'Cook traditional Egyptian dish',
        category: ChallengeCategory.creativity,
      ),

      // Surprise (8 challenges)
      Challenge(
        id: 'surprise_1',
        title: 'Steal a banana from a monkey',
        category: ChallengeCategory.surprise,
      ),
      Challenge(
        id: 'surprise_2',
        title: 'Swim in the Nile',
        category: ChallengeCategory.surprise,
      ),
      Challenge(
        id: 'surprise_3',
        title: 'Try on traditional Egyptian attire',
        category: ChallengeCategory.surprise,
      ),
      Challenge(
        id: 'surprise_4',
        title: 'Dance with locals',
        category: ChallengeCategory.surprise,
      ),
      Challenge(
        id: 'surprise_5',
        title: 'Do something you\'ve never done',
        category: ChallengeCategory.surprise,
      ),
      Challenge(
        id: 'surprise_6',
        title: 'Try exotic Egyptian fruit',
        category: ChallengeCategory.surprise,
      ),
      Challenge(
        id: 'surprise_7',
        title: 'Sing a song in public place',
        category: ChallengeCategory.surprise,
      ),
      Challenge(
        id: 'surprise_8',
        title: 'Learn a traditional Egyptian dance',
        category: ChallengeCategory.surprise,
      ),
      Challenge(
        id: 'surprise_9',
        title: 'Get henna tattoo from local artist',
        category: ChallengeCategory.surprise,
      ),
      Challenge(
        id: 'surprise_10',
        title: 'Smoke shisha for the first time',
        category: ChallengeCategory.surprise,
      ),
      Challenge(
        id: 'surprise_11',
        title: 'Attend fortune telling session',
        category: ChallengeCategory.surprise,
      ),
      Challenge(
        id: 'surprise_12',
        title: 'Sleep on a felucca boat',
        category: ChallengeCategory.surprise,
      ),
      Challenge(
        id: 'surprise_13',
        title: 'Find a hidden oasis in desert',
        category: ChallengeCategory.surprise,
      ),
    ];
  }
}
