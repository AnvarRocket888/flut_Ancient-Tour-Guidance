class ChecklistItem {
  final String id;
  final String placeId;
  final String title;
  bool isCompleted;
  String? photoPath;
  DateTime? completedAt;

  ChecklistItem({
    required this.id,
    required this.placeId,
    required this.title,
    this.isCompleted = false,
    this.photoPath,
    this.completedAt,
  });
}
