import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';
import '../models/place.dart';
import '../models/checklist_item.dart';
import '../models/scam_warning.dart';
import '../models/challenge.dart';
import '../models/challenge_category.dart';
import '../models/artifact.dart';
import '../models/fortune_reward.dart';

class AppProvider extends ChangeNotifier {
  final List<Place> _places = _generatePlaces();
  final List<ChecklistItem> _checklistItems = [];
  final List<ScamWarning> _scamWarnings = _generateScamWarnings();
  final Set<String> _favoritePlaceIds = {};
  List<Challenge> _challenges = Challenge.getDefaultChallenges();
  List<Artifact> _artifacts = Artifact.getDefaultArtifacts();
  DateTime? _lastFortuneSpinDate;
  FortuneReward? _todayFortuneReward;
  bool _isInitialized = false;

  List<Place> get places => _places;
  List<ChecklistItem> get checklistItems => _checklistItems;
  List<ScamWarning> get scamWarnings => _scamWarnings;
  Set<String> get favoritePlaceIds => _favoritePlaceIds;
  List<Challenge> get challenges => _challenges;
  List<Artifact> get artifacts => _artifacts;
  DateTime? get lastFortuneSpinDate => _lastFortuneSpinDate;
  FortuneReward? get todayFortuneReward => _todayFortuneReward;

  bool get canSpinFortuneWheel {
    if (_lastFortuneSpinDate == null) return true;
    final now = DateTime.now();
    return now.year != _lastFortuneSpinDate!.year ||
        now.month != _lastFortuneSpinDate!.month ||
        now.day != _lastFortuneSpinDate!.day;
  }

  List<Artifact> get unlockedArtifacts =>
      _artifacts.where((a) => a.isUnlocked).toList();

  List<Artifact> get lockedArtifacts =>
      _artifacts.where((a) => !a.isUnlocked).toList();

  int getArtifactCountByRarity(ArtifactRarity rarity) {
    return _artifacts.where((a) => a.rarity == rarity && a.isUnlocked).length;
  }

  int getTotalArtifactsByRarity(ArtifactRarity rarity) {
    return _artifacts.where((a) => a.rarity == rarity).length;
  }

  List<Place> get favoritePlaces =>
      _places.where((place) => _favoritePlaceIds.contains(place.id)).toList();

  int get completedChecklistCount =>
      _checklistItems.where((item) => item.isCompleted).length;

  int get totalChecklistCount => _checklistItems.length;

  double get completionPercentage {
    if (_checklistItems.isEmpty) return 0.0;
    return (completedChecklistCount / totalChecklistCount) * 100;
  }

  // Challenge methods
  int getCompletedChallengesCount(ChallengeCategory? category) {
    if (category == null) {
      return _challenges.where((c) => c.isCompleted).length;
    }
    return _challenges
        .where((c) => c.category == category && c.isCompleted)
        .length;
  }

  int getTotalChallengesCount(ChallengeCategory? category) {
    if (category == null) {
      return _challenges.length;
    }
    return _challenges.where((c) => c.category == category).length;
  }

  double getCategoryProgress(ChallengeCategory category) {
    final total = getTotalChallengesCount(category);
    if (total == 0) return 0.0;
    final completed = getCompletedChallengesCount(category);
    return (completed / total) * 100;
  }

  List<Challenge> getChallengesByCategory(ChallengeCategory? category) {
    if (category == null) {
      // Перемешиваем задания по цветам
      final shuffled = List<Challenge>.from(_challenges);
      shuffled.sort((a, b) {
        // Сортируем по индексу категории, чтобы цвета чередовались
        final aIndex = ChallengeCategory.values.indexOf(a.category);
        final bIndex = ChallengeCategory.values.indexOf(b.category);
        return aIndex.compareTo(bIndex);
      });
      // Создаем финальный перемешанный список
      final result = <Challenge>[];
      final categories = ChallengeCategory.values.toList();
      int maxPerCategory = (shuffled.length / categories.length).ceil();

      for (int i = 0; i < maxPerCategory; i++) {
        for (var cat in categories) {
          final items = shuffled.where((c) => c.category == cat).toList();
          if (i < items.length) {
            result.add(items[i]);
          }
        }
      }
      return result;
    }
    return _challenges.where((c) => c.category == category).toList();
  }

  void toggleChallenge(String challengeId) {
    final challenge = _challenges.firstWhere((c) => c.id == challengeId);
    challenge.isCompleted = !challenge.isCompleted;

    // Chance to unlock artifact when completing challenge
    if (challenge.isCompleted && Random().nextDouble() < 0.3) {
      _unlockRandomArtifact();
    }

    _saveData();
    notifyListeners();
  }

  void _unlockRandomArtifact() {
    final locked = _artifacts.where((a) => !a.isUnlocked).toList();
    if (locked.isEmpty) return;

    // Weighted random selection by rarity
    final rand = Random();
    final roll = rand.nextDouble() * 100;

    ArtifactRarity targetRarity;
    if (roll < 50) {
      targetRarity = ArtifactRarity.common;
    } else if (roll < 75) {
      targetRarity = ArtifactRarity.rare;
    } else if (roll < 90) {
      targetRarity = ArtifactRarity.epic;
    } else {
      targetRarity = ArtifactRarity.legendary;
    }

    final candidates = locked.where((a) => a.rarity == targetRarity).toList();
    if (candidates.isEmpty) {
      // Fallback to any locked artifact
      final artifact = locked[rand.nextInt(locked.length)];
      artifact.isUnlocked = true;
    } else {
      final artifact = candidates[rand.nextInt(candidates.length)];
      artifact.isUnlocked = true;
    }
  }

  FortuneReward spinFortuneWheel() {
    if (!canSpinFortuneWheel) {
      return _todayFortuneReward!;
    }

    final rewards = FortuneReward.getAllRewards();
    final random = Random();
    _todayFortuneReward = rewards[random.nextInt(rewards.length)];
    _lastFortuneSpinDate = DateTime.now();

    // Small chance to unlock artifact
    if (random.nextDouble() < 0.15) {
      _unlockRandomArtifact();
    }

    _saveData();
    notifyListeners();
    return _todayFortuneReward!;
  }

  void unlockArtifact(String artifactId) {
    final artifact = _artifacts.firstWhere((a) => a.id == artifactId);
    artifact.isUnlocked = true;
    _saveData();
    notifyListeners();
  }

  Future<void> loadData() async {
    if (_isInitialized) return;

    final prefs = await SharedPreferences.getInstance();

    // Load checklist items
    final checklistJson = prefs.getString('checklist_items');
    if (checklistJson != null) {
      final List<dynamic> decoded = json.decode(checklistJson);
      _checklistItems.clear();
      for (var itemData in decoded) {
        _checklistItems.add(
          ChecklistItem(
            id: itemData['id'],
            placeId: itemData['placeId'],
            title: itemData['title'],
            isCompleted: itemData['isCompleted'] ?? false,
            photoPath: itemData['photoPath'],
            completedAt: itemData['completedAt'] != null
                ? DateTime.parse(itemData['completedAt'])
                : null,
          ),
        );
      }
    }

    // Load favorites
    final favoritesJson = prefs.getString('favorites');
    if (favoritesJson != null) {
      final List<dynamic> decoded = json.decode(favoritesJson);
      _favoritePlaceIds.clear();
      _favoritePlaceIds.addAll(decoded.cast<String>());
    }

    // Load challenges
    final challengesJson = prefs.getString('challenges');
    if (challengesJson != null) {
      final List<dynamic> decoded = json.decode(challengesJson);
      final loadedChallenges = decoded
          .map((data) => Challenge.fromJson(data))
          .toList();

      // Check if we need to migrate (old challenges count vs new count)
      final defaultChallenges = Challenge.getDefaultChallenges();
      if (loadedChallenges.length != defaultChallenges.length) {
        // Migration needed - use new challenges but preserve completion status by ID
        _challenges = defaultChallenges.map((newChallenge) {
          final oldChallenge = loadedChallenges.firstWhere(
            (old) => old.id == newChallenge.id,
            orElse: () => newChallenge,
          );
          return Challenge(
            id: newChallenge.id,
            title: newChallenge.title,
            category: newChallenge.category,
            isCompleted: oldChallenge.isCompleted,
          );
        }).toList();
        // Save migrated data immediately
        _saveData();
      } else {
        // Check if any challenge has Russian text (migration needed)
        final hasRussianText = loadedChallenges.any(
          (c) => c.title.contains(RegExp(r'[а-яА-ЯёЁ]')),
        );

        if (hasRussianText) {
          // Migration needed - replace with English versions
          _challenges = defaultChallenges.map((newChallenge) {
            final oldChallenge = loadedChallenges.firstWhere(
              (old) => old.id == newChallenge.id,
              orElse: () => newChallenge,
            );
            return Challenge(
              id: newChallenge.id,
              title: newChallenge.title,
              category: newChallenge.category,
              isCompleted: oldChallenge.isCompleted,
            );
          }).toList();
          // Save migrated data immediately
          _saveData();
        } else {
          _challenges = loadedChallenges;
        }
      }
    }

    // Load artifacts
    final artifactsJson = prefs.getString('artifacts');
    if (artifactsJson != null) {
      final List<dynamic> decoded = json.decode(artifactsJson);
      _artifacts = decoded.map((data) => Artifact.fromJson(data)).toList();
    }

    // Load fortune wheel data
    final fortuneDateStr = prefs.getString('last_fortune_spin');
    if (fortuneDateStr != null) {
      _lastFortuneSpinDate = DateTime.parse(fortuneDateStr);
    }

    final fortuneRewardStr = prefs.getString('today_fortune_reward');
    if (fortuneRewardStr != null && canSpinFortuneWheel == false) {
      final data = json.decode(fortuneRewardStr);
      final rewards = FortuneReward.getAllRewards();
      _todayFortuneReward = rewards.firstWhere(
        (r) => r.title == data['title'],
        orElse: () => rewards[0],
      );
    }

    _isInitialized = true;
    notifyListeners();
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();

    // Save checklist items
    final checklistData = _checklistItems
        .map(
          (item) => {
            'id': item.id,
            'placeId': item.placeId,
            'title': item.title,
            'isCompleted': item.isCompleted,
            'photoPath': item.photoPath,
            'completedAt': item.completedAt?.toIso8601String(),
          },
        )
        .toList();
    await prefs.setString('checklist_items', json.encode(checklistData));

    // Save favorites
    await prefs.setString('favorites', json.encode(_favoritePlaceIds.toList()));

    // Save challenges
    final challengesData = _challenges.map((c) => c.toJson()).toList();
    await prefs.setString('challenges', json.encode(challengesData));

    // Save artifacts
    final artifactsData = _artifacts.map((a) => a.toJson()).toList();
    await prefs.setString('artifacts', json.encode(artifactsData));

    // Save fortune wheel data
    if (_lastFortuneSpinDate != null) {
      await prefs.setString(
        'last_fortune_spin',
        _lastFortuneSpinDate!.toIso8601String(),
      );
    }

    if (_todayFortuneReward != null) {
      await prefs.setString(
        'today_fortune_reward',
        json.encode({
          'title': _todayFortuneReward!.title,
          'emoji': _todayFortuneReward!.emoji,
          'description': _todayFortuneReward!.description,
        }),
      );
    }
  }

  void toggleFavorite(String placeId) {
    if (_favoritePlaceIds.contains(placeId)) {
      _favoritePlaceIds.remove(placeId);
    } else {
      _favoritePlaceIds.add(placeId);
    }
    _saveData();
    notifyListeners();
  }

  bool isFavorite(String placeId) {
    return _favoritePlaceIds.contains(placeId);
  }

  void addChecklistItem(ChecklistItem item) {
    _checklistItems.add(item);
    _saveData();
    notifyListeners();
  }

  void toggleChecklistItem(String itemId) {
    final item = _checklistItems.firstWhere((item) => item.id == itemId);
    item.isCompleted = !item.isCompleted;
    item.completedAt = item.isCompleted ? DateTime.now() : null;
    _saveData();
    notifyListeners();
  }

  void updateChecklistItemPhoto(String itemId, String photoPath) {
    final item = _checklistItems.firstWhere((item) => item.id == itemId);
    item.photoPath = photoPath;
    _saveData();
    notifyListeners();
  }

  void initializeChecklist() {
    if (_checklistItems.isEmpty) {
      for (var place in _places) {
        _checklistItems.add(
          ChecklistItem(
            id: 'checklist_${place.id}',
            placeId: place.id,
            title: 'Visit ${place.name}',
          ),
        );
      }
      _saveData();
      notifyListeners();
    }
  }

  static List<Place> _generatePlaces() {
    return [
      Place(
        id: '1',
        name: 'Great Pyramid of Giza',
        description:
            'The Great Pyramid of Giza is the oldest and largest of the three pyramids in the Giza pyramid complex. Built as a tomb for Pharaoh Khufu, it\'s one of the Seven Wonders of the Ancient World and the only one still standing. The pyramid was constructed over 20 years using approximately 2.3 million stone blocks.',
        location: 'Giza Necropolis, Giza',
        category: 'Historical Site',
        imageEmoji: '🏛️',
        latitude: 29.9792,
        longitude: 31.1342,
        estimatedTimeMinutes: 120,
        bestTimeToVisit: 'Early morning (7-9 AM) to avoid crowds and heat',
        tips: [
          'Arrive early to beat the crowds and heat',
          'Wear comfortable shoes for walking on sandy terrain',
          'Bring water and sun protection',
          'Consider hiring a licensed guide for historical context',
          'Don\'t forget your camera for stunning photos',
        ],
        scamWarnings: [
          'Camel/horse ride scams - agree on price before riding',
          'Fake tour guides offering unauthorized services',
          'Overpriced souvenirs near entrance',
          'Photography fees that aren\'t official',
        ],
      ),
      Place(
        id: '2',
        name: 'Sphinx',
        description:
            'The Great Sphinx of Giza is a limestone statue with the head of a human and the body of a lion. Standing at 73 meters long and 20 meters high, it\'s one of the largest and oldest statues in the world. The Sphinx faces directly from west to east and is believed to have been built during the reign of Pharaoh Khafre.',
        location: 'Giza Necropolis, Giza',
        category: 'Historical Site',
        imageEmoji: '🦁',
        latitude: 29.9753,
        longitude: 31.1376,
        estimatedTimeMinutes: 45,
        bestTimeToVisit: 'Morning or late afternoon for best lighting',
        tips: [
          'Best viewed from the viewing platform',
          'Combine visit with Giza Pyramids tour',
          'Great photo opportunities from different angles',
          'Visit the small temple between the paws',
        ],
        scamWarnings: [
          'Photo scammers charging for pictures',
          'Fake "special access" tours',
          'Overpriced refreshments nearby',
        ],
      ),
      Place(
        id: '3',
        name: 'Egyptian Museum',
        description:
            'The Museum of Egyptian Antiquities houses an extensive collection of ancient Egyptian artifacts. With over 120,000 items, including the treasures of Tutankhamun, it\'s one of the most important museums in the world for Egyptology. The museum offers a comprehensive journey through Egyptian history from prehistoric times to the Greco-Roman period.',
        location: 'Tahrir Square, Cairo',
        category: 'Museum',
        imageEmoji: '🏺',
        latitude: 30.0478,
        longitude: 31.2336,
        estimatedTimeMinutes: 180,
        bestTimeToVisit: 'Weekday mornings for fewer crowds',
        tips: [
          'Allow at least 3 hours for a thorough visit',
          'Audio guides are recommended',
          'The Tutankhamun collection is a must-see',
          'Photography is not allowed inside',
          'Get tickets in advance online',
        ],
        scamWarnings: [
          'Unlicensed guides outside the museum',
          'Ticket resellers at inflated prices',
          'Fake "museum tour packages"',
        ],
      ),
      Place(
        id: '4',
        name: 'Karnak Temple',
        description:
            'The Karnak Temple Complex is one of the largest ancient religious sites in the world. Built over 2,000 years by multiple pharaohs, it covers over 200 acres and features the Great Hypostyle Hall with 134 massive columns. The temple was dedicated to the Theban triad of Amun, Mut, and Khonsu.',
        location: 'Luxor',
        category: 'Historical Site',
        imageEmoji: '⛩️',
        latitude: 25.7188,
        longitude: 32.6573,
        estimatedTimeMinutes: 150,
        bestTimeToVisit: 'Late afternoon for sound and light show',
        tips: [
          'Visit the Hypostyle Hall at different times for lighting',
          'Bring water - it can get very hot',
          'The sound and light show is worth attending',
          'Wear comfortable walking shoes',
          'Early morning visits are cooler',
        ],
        scamWarnings: [
          'Unlicensed guides at entrance',
          'Inflated prices for souvenirs',
          'Fake "special access" areas',
        ],
      ),
      Place(
        id: '5',
        name: 'Valley of the Kings',
        description:
            'The Valley of the Kings served as the burial ground for pharaohs and powerful nobles of the New Kingdom. This archaeological site contains 63 tombs, including the famous tomb of Tutankhamun. The tombs feature elaborate wall paintings and hieroglyphics depicting the journey to the afterlife.',
        location: 'West Bank, Luxor',
        category: 'Historical Site',
        imageEmoji: '⚰️',
        latitude: 25.7402,
        longitude: 32.6014,
        estimatedTimeMinutes: 120,
        bestTimeToVisit: 'Early morning (6-8 AM) before it gets too hot',
        tips: [
          'Tickets allow entry to 3 tombs - choose wisely',
          'Tutankhamun\'s tomb requires separate ticket',
          'Photography is prohibited inside tombs',
          'Bring flashlight for better viewing',
          'Dress modestly and comfortably',
        ],
        scamWarnings: [
          'Taxi overcharging for return trips',
          'Fake tomb entry tickets',
          'Unauthorized photography fees',
        ],
      ),
      Place(
        id: '6',
        name: 'Abu Simbel Temples',
        description:
            'The Abu Simbel temples are two massive rock-cut temples built by Pharaoh Ramesses II. The larger temple features four colossal statues of Ramesses II, each 20 meters high. These temples were relocated in the 1960s to save them from flooding by Lake Nasser, a remarkable feat of modern engineering.',
        location: 'Aswan Governorate',
        category: 'Historical Site',
        imageEmoji: '🗿',
        latitude: 22.3372,
        longitude: 31.6258,
        estimatedTimeMinutes: 90,
        bestTimeToVisit:
            'Early morning or late afternoon for cooler temperatures',
        tips: [
          'Most visitors fly from Aswan or take early morning bus',
          'Twice yearly, sun rays illuminate inner sanctuary',
          'Bring sun protection and water',
          'Allow time for photography',
          'Visit early to avoid tour groups',
        ],
        scamWarnings: [
          'Overpriced tour packages',
          'Fake guide credentials',
          'Inflated transport costs',
        ],
      ),
      Place(
        id: '7',
        name: 'Philae Temple',
        description:
            'The Philae Temple complex was dedicated to the goddess Isis and was one of the last places where ancient Egyptian religion was practiced. The temple was relocated to Agilkia Island to save it from flooding after the construction of the Aswan Dam. It features beautiful reliefs and a sound and light show.',
        location: 'Agilkia Island, Aswan',
        category: 'Historical Site',
        imageEmoji: '🛕',
        latitude: 24.0256,
        longitude: 32.8846,
        estimatedTimeMinutes: 90,
        bestTimeToVisit: 'Late afternoon for sound and light show',
        tips: [
          'Reach by boat from Aswan - enjoy the Nile views',
          'Evening sound and light show is spectacular',
          'Beautiful island setting for photography',
          'Combine with Aswan Dam visit',
        ],
        scamWarnings: [
          'Boat operators overcharging',
          'Fake show tickets',
          'Souvenir price inflation',
        ],
      ),
      Place(
        id: '8',
        name: 'Khan el-Khalili Bazaar',
        description:
            'Khan el-Khalili is a famous bazaar and souq in historic Cairo. Dating back to 1382, this bustling marketplace offers traditional crafts, jewelry, spices, and souvenirs. It\'s a must-visit for experiencing authentic Egyptian market culture and finding unique handmade items.',
        location: 'Islamic Cairo',
        category: 'Market',
        imageEmoji: '🏪',
        latitude: 30.0475,
        longitude: 31.2625,
        estimatedTimeMinutes: 120,
        bestTimeToVisit: 'Evening when it\'s most lively',
        tips: [
          'Bargaining is expected and part of the experience',
          'Start with offering 50% of asking price',
          'Keep valuables secure in crowded areas',
          'Try traditional tea at El Fishawi cafe',
          'Best time is evening when locals shop',
        ],
        scamWarnings: [
          'Aggressive salespeople - be firm but polite',
          'Overpriced items for tourists',
          'Fake antiques sold as genuine',
          'Pickpockets in crowded areas',
          'Bait and switch tactics in some shops',
        ],
      ),
      Place(
        id: '9',
        name: 'Siwa Oasis',
        description:
            'Siwa Oasis is a stunning desert oasis near the Libyan border. Known for its unique culture, salt lakes, and ancient ruins including the Temple of the Oracle where Alexander the Great was declared a god. The oasis offers natural hot springs, palm groves, and traditional Siwan architecture.',
        location: 'Western Desert',
        category: 'Natural Site',
        imageEmoji: '🏜️',
        latitude: 29.2030,
        longitude: 25.5195,
        estimatedTimeMinutes: 360,
        bestTimeToVisit: 'October to April for pleasant weather',
        tips: [
          'Plan for 2-3 days to fully experience',
          'Try the natural hot springs at Cleopatra\'s Bath',
          'Desert safari and sandboarding available',
          'Visit Shali fortress ruins',
          'Try local dates - Siwa is famous for them',
        ],
        scamWarnings: [
          'Overpriced safari tours',
          'Accommodation price inflation',
          'Fake desert tour operators',
        ],
      ),
      Place(
        id: '10',
        name: 'Alexandria Library',
        description:
            'The Bibliotheca Alexandrina is a modern commemoration of the ancient Library of Alexandria. This stunning contemporary building houses millions of books and serves as a major cultural center. It features museums, planetarium, and beautiful architecture blending ancient and modern design.',
        location: 'Alexandria',
        category: 'Cultural Center',
        imageEmoji: '📚',
        latitude: 31.2084,
        longitude: 29.9094,
        estimatedTimeMinutes: 120,
        bestTimeToVisit: 'Any time, air-conditioned interior',
        tips: [
          'Guided tours available in multiple languages',
          'Visit the planetarium and museums',
          'Free reading room access with ID',
          'Beautiful architecture for photography',
          'Combine with Corniche waterfront walk',
        ],
        scamWarnings: ['Unlicensed tour guides outside', 'Fake ticket sellers'],
      ),
    ];
  }

  static List<ScamWarning> _generateScamWarnings() {
    return [
      ScamWarning(
        id: 'scam_1',
        title: 'Camel and Horse Ride Scams',
        description:
            'Vendors offer cheap camel or horse rides at tourist sites but demand exorbitant fees when you want to get off or return.',
        category: 'Transportation',
        severity: 'high',
        preventionTips: [
          'Agree on total price before riding, including return',
          'Get price in writing if possible',
          'Only use official tour operators',
          'Avoid unsolicited offers',
          'Know the going rate (50-100 EGP for short rides)',
        ],
      ),
      ScamWarning(
        id: 'scam_2',
        title: 'Fake Tour Guides',
        description:
            'Unlicensed individuals pose as official tour guides and provide poor service or demand extra fees.',
        category: 'Tours',
        severity: 'high',
        preventionTips: [
          'Only hire guides with official ID badges',
          'Book through reputable tour companies',
          'Check guide reviews online',
          'Agree on price and services beforehand',
          'Official guides have Ministry of Tourism ID',
        ],
      ),
      ScamWarning(
        id: 'scam_3',
        title: 'Papyrus and Souvenir Scams',
        description:
            'Shops sell fake papyrus (banana leaf) or low-quality items at inflated prices claiming they are authentic.',
        category: 'Shopping',
        severity: 'medium',
        preventionTips: [
          'Shop at recommended stores with certificates',
          'Learn to identify real papyrus (thicker, doesn\'t tear easily)',
          'Always bargain - start at 40-50% of asking price',
          'Avoid shops with aggressive salespeople',
          'Compare prices at multiple shops',
        ],
      ),
      ScamWarning(
        id: 'scam_4',
        title: 'Restaurant Bill Padding',
        description:
            'Some restaurants add items you didn\'t order or charge inflated prices for tourists.',
        category: 'Dining',
        severity: 'medium',
        preventionTips: [
          'Check menu prices before ordering',
          'Ask about service charges and taxes',
          'Review bill carefully before paying',
          'Take photo of menu prices',
          'Eat where locals eat',
        ],
      ),
      ScamWarning(
        id: 'scam_5',
        title: 'Taxi Overcharging',
        description:
            'Taxi drivers refuse to use meter or quote inflated prices, especially from airports.',
        category: 'Transportation',
        severity: 'medium',
        preventionTips: [
          'Use Uber or Careem (safer and priced)',
          'Insist on meter or agree price before entering',
          'Know approximate prices for common routes',
          'Have small bills ready',
          'Use official airport taxis with fixed rates',
        ],
      ),
      ScamWarning(
        id: 'scam_6',
        title: 'Closed Today Scam',
        description:
            'People tell you a site is closed and offer alternative tour services. The site is actually open.',
        category: 'Tours',
        severity: 'high',
        preventionTips: [
          'Verify information at official source',
          'Check site hours online beforehand',
          'Ignore random people offering help',
          'Go directly to site entrance',
          'Trust your hotel/official tour operator',
        ],
      ),
      ScamWarning(
        id: 'scam_7',
        title: 'Photography Fees Scam',
        description:
            'People demand money after taking your photo or for appearing in your photos.',
        category: 'General',
        severity: 'low',
        preventionTips: [
          'Don\'t accept unsolicited photo services',
          'Ask permission before photographing people',
          'Be aware of your surroundings when taking photos',
          'Keep camera secure',
          'Know official photography rules at sites',
        ],
      ),
      ScamWarning(
        id: 'scam_8',
        title: 'Money Exchange Scams',
        description:
            'Short-changing, counterfeit bills, or unfavorable rates at unofficial exchange locations.',
        category: 'Money',
        severity: 'high',
        preventionTips: [
          'Use official banks or ATMs',
          'Count money carefully before leaving counter',
          'Check bills for authenticity',
          'Know current exchange rate',
          'Avoid street money changers',
        ],
      ),
      ScamWarning(
        id: 'scam_9',
        title: 'Free Gift Scam',
        description:
            'Someone gives you a "free gift" (bracelet, papyrus, etc.) then demands payment.',
        category: 'General',
        severity: 'medium',
        preventionTips: [
          'Refuse unsolicited gifts politely but firmly',
          'Nothing is actually free at tourist sites',
          'Walk away if pressured',
          'Don\'t feel obligated to accept anything',
          'Keep hands in pockets in crowded areas',
        ],
      ),
      ScamWarning(
        id: 'scam_10',
        title: 'Hotel/Restaurant Recommendations',
        description:
            'Taxi drivers or guides insist on taking you to specific hotels or restaurants for commission.',
        category: 'Accommodation',
        severity: 'medium',
        preventionTips: [
          'Book accommodation in advance',
          'Insist on your chosen destination',
          'Ignore claims that your hotel is closed/bad',
          'Research restaurants beforehand',
          'Trust verified reviews over recommendations',
        ],
      ),
    ];
  }
}
