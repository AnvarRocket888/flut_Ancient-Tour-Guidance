class Place {
  final String id;
  final String name;
  final String description;
  final String location;
  final String category;
  final String imageEmoji;
  final List<String> tips;
  final List<String> scamWarnings;
  final double latitude;
  final double longitude;
  final int estimatedTimeMinutes;
  final String bestTimeToVisit;

  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.category,
    required this.imageEmoji,
    required this.tips,
    required this.scamWarnings,
    required this.latitude,
    required this.longitude,
    required this.estimatedTimeMinutes,
    required this.bestTimeToVisit,
  });
}
