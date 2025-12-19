import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../providers/app_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';
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

    return Container(
      decoration: AppStyles.backgroundGradient,
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.transparent,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: AppColors.secondaryBg.withValues(alpha: 0.9),
          border: Border(bottom: BorderSide(color: AppColors.goldSecondary.withValues(alpha: 0.3), width: 1)),
          middle: Text(
            '✅ My Checklist',
            style: AppStyles.titleSmall,
          ),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.accentPink, AppColors.goldSecondary],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.glowGold,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Icon(
                CupertinoIcons.exclamationmark_shield_fill,
                color: AppColors.textPrimary,
                size: 20,
              ),
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
              decoration: AppStyles.cardDecoration,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '🎯 Trip Progress',
                        style: AppStyles.titleSmall,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.goldPrimary, AppColors.goldSecondary],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.glowGold,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Text(
                          '$completedCount/$totalCount',
                          style: const TextStyle(
                            color: AppColors.primaryBg,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 16,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.secondaryBg,
                                  AppColors.primaryBg,
                                ],
                              ),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: percentage,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [AppColors.goldPrimary, AppColors.goldSecondary],
                                ),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.glowGold,
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '✨ ${(percentage * 100).toStringAsFixed(0)}% Complete ✨',
                    style: TextStyle(
                      color: AppColors.goldPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      shadows: const [
                        Shadow(
                          color: AppColors.glowGold,
                          blurRadius: 8,
                        ),
                      ],
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
    )
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

    return GestureDetector(
      onTap: () {
        if (!item.isCompleted) {
          _showPhotoOptions(context, provider, item.id);
        } else {
          // When tapping completed item, show visit statistics
          _showVisitStatistics(context, provider);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: item.isCompleted 
              ? [AppColors.goldSecondary.withValues(alpha: 0.2), AppColors.bluePrimary.withValues(alpha: 0.2)]
              : [AppColors.secondaryBg, AppColors.primaryBg],
          ),
          borderRadius: BorderRadius.circular(16),
          border: item.isCompleted
              ? Border.all(color: AppColors.goldPrimary, width: 2)
              : Border.all(color: AppColors.goldSecondary.withValues(alpha: 0.3), width: 1),
          boxShadow: item.isCompleted ? const [
            BoxShadow(
              color: AppColors.glowGold,
              blurRadius: 12,
            ),
          ] : null,
        ),
        child: Row(
          children: [
            // Checkbox
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: item.isCompleted
                    ? const LinearGradient(
                        colors: [AppColors.goldPrimary, AppColors.goldSecondary],
                      )
                    : null,
                color: item.isCompleted ? null : AppColors.primaryBg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: item.isCompleted
                      ? AppColors.goldPrimary
                      : AppColors.goldSecondary.withValues(alpha: 0.5),
                  width: 2,
                ),
                boxShadow: item.isCompleted ? const [
                  BoxShadow(
                    color: AppColors.glowGold,
                    blurRadius: 8,
                  ),
                ] : null,
              ),
              child: item.isCompleted
                  ? const Icon(
                      CupertinoIcons.check_mark,
                      size: 20,
                      color: AppColors.primaryBg,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            // Emoji
            Text(
              placeEmoji,
              style: const TextStyle(fontSize: 36),
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
                      color: item.isCompleted ? AppColors.goldPrimary : AppColors.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      decoration: item.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                      shadows: item.isCompleted ? const [
                        Shadow(
                          color: AppColors.glowGold,
                          blurRadius: 4,
                        ),
                      ] : null,
                    ),
                  ),
                  if (item.completedAt != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        '✅ Visited on ${_formatDate(item.completedAt!)}',
                        style: const TextStyle(
                          color: AppColors.goldSecondary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Photo indicator
            if (item.photoPath != null)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.accentPink, AppColors.goldSecondary],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.glowGold,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Icon(
                  CupertinoIcons.photo_fill,
                  color: AppColors.textPrimary,
                  size: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showVisitStatistics(BuildContext context, AppProvider provider) {
    final place = provider.places.firstWhere((p) => p.id == item.placeId);
    
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.secondaryBg, AppColors.primaryBg],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.goldPrimary,
                width: 2,
              ),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.glowGold,
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.goldPrimary, AppColors.goldSecondary],
                    ),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        placeEmoji,
                        style: const TextStyle(fontSize: 40),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '✨ Visit Complete!',
                              style: const TextStyle(
                                color: AppColors.primaryBg,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              placeName,
                              style: const TextStyle(
                                color: AppColors.primaryBg,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Photo section
                if (item.photoPath != null)
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryBg,
                    ),
                    child: ClipRRect(
                      child: Image.file(
                        File(item.photoPath!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                // Statistics
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Visit date and time
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.goldSecondary.withValues(alpha: 0.2),
                              AppColors.bluePrimary.withValues(alpha: 0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.goldSecondary.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [AppColors.goldPrimary, AppColors.goldSecondary],
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                CupertinoIcons.calendar,
                                color: AppColors.textPrimary,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '📅 Visited On',
                                    style: TextStyle(
                                      color: AppColors.goldSecondary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _formatDateTime(item.completedAt!),
                                    style: const TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Place information
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.bluePrimary.withValues(alpha: 0.2),
                              AppColors.accentTeal.withValues(alpha: 0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.bluePrimary.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [AppColors.bluePrimary, AppColors.accentTeal],
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.info_circle_fill,
                                    color: AppColors.textPrimary,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  '🏛️ About',
                                  style: TextStyle(
                                    color: AppColors.bluePrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              place.description,
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 14,
                                height: 1.5,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Uncheck button
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.accentPink, Color(0xFFFF6B6B)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.accentPink,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                '❌ Uncheck',
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            provider.toggleChecklistItem(item.id);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Close button
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.goldPrimary, AppColors.goldSecondary],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.glowGold,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                '✨ Close',
                                style: TextStyle(
                                  color: AppColors.primaryBg,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDateTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '${date.day}/${date.month}/${date.year} at $hour:$minute';
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
