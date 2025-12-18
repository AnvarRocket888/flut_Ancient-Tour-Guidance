class ScamWarning {
  final String id;
  final String title;
  final String description;
  final String category;
  final String severity; // 'high', 'medium', 'low'
  final List<String> preventionTips;

  ScamWarning({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.severity,
    required this.preventionTips,
  });
}
