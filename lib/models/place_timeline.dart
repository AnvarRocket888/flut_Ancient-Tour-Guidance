class TimelineEvent {
  final String year;
  final String title;
  final String description;
  final String emoji;

  TimelineEvent({
    required this.year,
    required this.title,
    required this.description,
    required this.emoji,
  });
}

class PlaceTimeline {
  final String placeId;
  final List<TimelineEvent> events;

  PlaceTimeline({
    required this.placeId,
    required this.events,
  });

  static Map<String, PlaceTimeline> getTimelines() {
    return {
      '1': PlaceTimeline(
        placeId: '1',
        events: [
          TimelineEvent(
            year: '2560 BC',
            title: 'Construction Begins',
            description: 'Pharaoh Khufu orders the construction of the Great Pyramid, employing thousands of workers.',
            emoji: '🏗️',
          ),
          TimelineEvent(
            year: '2540 BC',
            title: 'Pyramid Completed',
            description: 'After 20 years, the Great Pyramid stands 146.5 meters tall with 2.3 million stone blocks.',
            emoji: '👑',
          ),
          TimelineEvent(
            year: '443 BC',
            title: 'Herodotus Visits',
            description: 'Greek historian Herodotus writes the first detailed account of the pyramid.',
            emoji: '📜',
          ),
          TimelineEvent(
            year: '820 AD',
            title: 'Al-Ma\'mun\'s Tunnel',
            description: 'Caliph Al-Ma\'mun creates a tunnel searching for treasure, now the main tourist entrance.',
            emoji: '🕳️',
          ),
          TimelineEvent(
            year: '1798',
            title: 'Napoleon\'s Campaign',
            description: 'Napoleon Bonaparte visits and orders scientific studies of the pyramids.',
            emoji: '⚔️',
          ),
          TimelineEvent(
            year: '2007',
            title: 'New Wonder of World',
            description: 'The Great Pyramid is named one of the New Seven Wonders of the World.',
            emoji: '🌟',
          ),
        ],
      ),
      '2': PlaceTimeline(
        placeId: '2',
        events: [
          TimelineEvent(
            year: '2500 BC',
            title: 'Sphinx Carved',
            description: 'The Great Sphinx is carved from limestone bedrock during Pharaoh Khafre\'s reign.',
            emoji: '🦁',
          ),
          TimelineEvent(
            year: '1400 BC',
            title: 'Dream Stele',
            description: 'Thutmose IV places a granite stele between the paws after a prophetic dream.',
            emoji: '💤',
          ),
          TimelineEvent(
            year: '1817',
            title: 'Sand Excavation',
            description: 'Italian archaeologist Giovanni Caviglia begins clearing sand from the Sphinx.',
            emoji: '⛏️',
          ),
          TimelineEvent(
            year: '1925',
            title: 'Full Excavation',
            description: 'The Sphinx is fully excavated for the first time in modern history.',
            emoji: '🔍',
          ),
        ],
      ),
      '3': PlaceTimeline(
        placeId: '3',
        events: [
          TimelineEvent(
            year: '1858',
            title: 'Museum Founded',
            description: 'French archaeologist Auguste Mariette establishes the museum at Bulaq.',
            emoji: '🏛️',
          ),
          TimelineEvent(
            year: '1902',
            title: 'Moved to Tahrir',
            description: 'Museum relocated to its current location in Tahrir Square.',
            emoji: '🚚',
          ),
          TimelineEvent(
            year: '1922',
            title: 'Tutankhamun\'s Treasures',
            description: 'Howard Carter\'s discovery of King Tut\'s tomb brings thousands of artifacts.',
            emoji: '💎',
          ),
          TimelineEvent(
            year: '2011',
            title: 'Arab Spring',
            description: 'Museum protected by Egyptian citizens forming a human chain during protests.',
            emoji: '🛡️',
          ),
        ],
      ),
    };
  }
}
