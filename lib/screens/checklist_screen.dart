import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../providers/app_provider.dart';
import 'scam_warnings_screen.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize checklist after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<AppProvider>(context, listen: false);
      if (provider.checklistItems.isEmpty) {
        provider.initializeChecklist();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    
    final completedCount = provider.completedChecklistCount;
    final totalCount = provider.totalChecklistCount;
    final percentage = provider.completionPercentage;

    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFF1C1C24),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: const Color(0xFF232332),
        border: null,
        middle: const Text(
          'My Checklist',
          style: TextStyle(color: CupertinoColors.white),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.exclamationmark_shield,
            color: CupertinoColors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => const ScamWarningsScreen(),
              ),
            );
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Progress section
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF232332),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Trip Progress',
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$completedCount/$totalCount',
                        style: const TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 12,
                      child: LinearProgressIndicator(
                        value: percentage,
                        backgroundColor: const Color(0xFF1C1C24),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          CupertinoColors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${(percentage * 100).toStringAsFixed(0)}% Complete',
                    style: const TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Checklist items
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: provider.checklistItems.length,
                itemBuilder: (context, index) {
                  final item = provider.checklistItems[index];
                  final place = provider.places.firstWhere(
                    (p) => p.id == item.placeId,
                  );
                  return _ChecklistItemCard(
                    item: item,
                    placeName: place.name,
                    placeEmoji: place.imageEmoji,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChecklistItemCard extends StatelessWidget {
  final dynamic item;
  final String placeName;
  final String placeEmoji;

  const _ChecklistItemCard({
    required this.item,
    required this.placeName,
    required this.placeEmoji,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF232332),
        borderRadius: BorderRadius.circular(12),
        border: item.isCompleted
            ? Border.all(color: CupertinoColors.white, width: 2)
            : null,
      ),
      child: Row(
        children: [
          // Checkbox
          GestureDetector(
            onTap: () {
              if (!item.isCompleted) {
                _showPhotoOptions(context, provider, item.id);
              } else {
                provider.toggleChecklistItem(item.id);
              }
            },
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: item.isCompleted
                    ? CupertinoColors.white
                    : const Color(0xFF1C1C24),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: item.isCompleted
                      ? CupertinoColors.white
                      : const Color(0xFF9E9E9E),
                  width: 2,
                ),
              ),
              child: item.isCompleted
                  ? const Icon(
                      CupertinoIcons.check_mark,
                      size: 18,
                      color: Color(0xFF1C1C24),
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          // Emoji
          Text(
            placeEmoji,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(width: 12),
          // Title and date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placeName,
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    decoration: item.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                if (item.completedAt != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Visited on ${_formatDate(item.completedAt!)}',
                      style: const TextStyle(
                        color: Color(0xFF9E9E9E),
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Photo indicator with tap to view
          if (item.photoPath != null)
            GestureDetector(
              onTap: () => _showPhotoPreview(context, item.photoPath!),
              child: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(
                  CupertinoIcons.photo_fill,
                  color: CupertinoColors.white,
                  size: 24,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showPhotoPreview(BuildContext context, String photoPath) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        final size = MediaQuery.of(context).size;
        return Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: size.width * 0.9,
              maxHeight: size.height * 0.8,
            ),
            child: CupertinoAlertDialog(
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: size.height * 0.6,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(photoPath),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Закрыть'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _pickImage(BuildContext context, AppProvider provider, String itemId, ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        // Update the checklist item with photo path
        provider.updateChecklistItemPhoto(itemId, image.path);
        provider.toggleChecklistItem(itemId);
        
        if (context.mounted) {
          _showSuccessMessage(context);
        }
      }
    } catch (e) {
      if (context.mounted) {
        String errorMessage = 'Failed to pick image: $e';
        
        // Check for camera not available error
        if (e.toString().contains('camera_access_denied') || 
            e.toString().contains('Camera not found') ||
            e.toString().toLowerCase().contains('camera')) {
          errorMessage = source == ImageSource.camera 
              ? 'Камера недоступна на симуляторе.\nИспользуйте реальное устройство или выберите фото из галереи.'
              : 'Не удалось получить доступ к галерее.';
        }
        
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Ошибка'),
            content: Text(errorMessage),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }
    }
  }

  void _showPhotoOptions(BuildContext context, AppProvider provider, String itemId) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Mark as Completed'),
        message: const Text('Would you like to add a photo?'),
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Take Photo'),
            onPressed: () {
              Navigator.pop(context);
              _pickImage(context, provider, itemId, ImageSource.camera);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Choose from Library'),
            onPressed: () {
              Navigator.pop(context);
              _pickImage(context, provider, itemId, ImageSource.gallery);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Skip Photo'),
            onPressed: () {
              Navigator.pop(context);
              provider.toggleChecklistItem(itemId);
              _showSuccessMessage(context);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _showSuccessMessage(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('🎉'),
        content: const Text('Place marked as visited!'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Great!'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
