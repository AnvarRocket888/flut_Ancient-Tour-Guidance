import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';
import 'scam_warnings_screen.dart';
import 'checklist_screen.dart';
import 'challenges_screen.dart';
import 'fortune_wheel_screen.dart';
import 'artifact_collection_screen.dart';
import 'web_view_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final completionPercentage = provider.completionPercentage;
    final completedCount = provider.completedChecklistCount;
    final totalCount = provider.totalChecklistCount;
    final favoritesCount = provider.favoritePlaceIds.length;

    return Container(
      decoration: AppStyles.backgroundGradient,
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.transparent,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: AppColors.secondaryBg.withValues(alpha: 0.9),
          border: Border(bottom: BorderSide(color: AppColors.goldSecondary.withValues(alpha: 0.3), width: 1)),
          middle: Text(
            '👤 My Profile',
            style: AppStyles.titleSmall,
          ),
        ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              // Avatar
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.goldPrimary, AppColors.goldSecondary],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.glowGold,
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBg,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '🧳',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '✨ Egypt Explorer ✨',
                style: AppStyles.titleMedium,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.accentPink, AppColors.goldSecondary],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.glowGold,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Text(
                  '🎭 Adventure Traveler',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Stats cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: CupertinoIcons.checkmark_circle_fill,
                        value: '$completedCount',
                        label: 'Visited',
                        gradient: const LinearGradient(
                          colors: [AppColors.goldPrimary, AppColors.goldSecondary],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        icon: CupertinoIcons.heart_fill,
                        value: '$favoritesCount',
                        label: 'Favorites',
                        gradient: const LinearGradient(
                          colors: [AppColors.accentPink, AppColors.goldSecondary],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        icon: CupertinoIcons.location_fill,
                        value: '${provider.places.length}',
                        label: 'Places',
                        gradient: const LinearGradient(
                          colors: [AppColors.bluePrimary, AppColors.accentTeal],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Progress section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: AppStyles.cardDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🎯 Trip Progress',
                      style: AppStyles.titleSmall,
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
                              widthFactor: completionPercentage,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '✨ ${(completionPercentage * 100).toStringAsFixed(0)}% Complete',
                          style: const TextStyle(
                            color: AppColors.goldPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            shadows: [
                              Shadow(
                                color: AppColors.glowGold,
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '$completedCount / $totalCount 📍',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Menu items
              _MenuItem(
                icon: CupertinoIcons.sparkles,
                title: '🔮 Fortune Wheel',
                subtitle: 'Daily mystical quest from ancient gods',
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const FortuneWheelScreen(),
                    ),
                  );
                },
              ),
              _MenuItem(
                icon: CupertinoIcons.cube_box_fill,
                title: '🏺 Artifact Collection',
                subtitle: 'Discover legendary Egyptian treasures',
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const ArtifactCollectionScreen(),
                    ),
                  );
                },
              ),
              _MenuItem(
                icon: CupertinoIcons.game_controller_solid,
                title: '🎮 Game Challenges',
                subtitle: 'Complete quests and level up skills',
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const ChallengesScreen(),
                    ),
                  );
                },
              ),
              _MenuItem(
                icon: CupertinoIcons.checkmark_circle_fill,
                title: 'My Checklist',
                subtitle: 'Track visited places',
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const ChecklistScreen(),
                    ),
                  );
                },
              ),
              _MenuItem(
                icon: CupertinoIcons.exclamationmark_shield_fill,
                title: 'Safety Tips',
                subtitle: 'Scam warnings & prevention',
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const ScamWarningsScreen(),
                    ),
                  );
                },
              ),
              _MenuItem(
                icon: CupertinoIcons.globe,
                title: '🌐 Open Google',
                subtitle: 'Browse the web',
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const WebViewScreen(
                        url: 'https://www.google.com',
                        title: '🌐 Google',
                      ),
                    ),
                  );
                },
              ),
              _MenuItem(
                icon: CupertinoIcons.info_circle_fill,
                title: 'About Egypt',
                subtitle: 'Travel information',
                onTap: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text('About Egypt'),
                      content: const Text(
                        'Egypt is a transcontinental country spanning the northeast corner of Africa and southwest corner of Asia. It is home to some of the world\'s most ancient monuments and archaeological sites.',
                      ),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text('OK'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    )
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Gradient gradient;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.glowGold,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.textPrimary,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: AppColors.glowGold,
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: AppStyles.cardDecoration,
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
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
              child: Icon(
                icon,
                color: AppColors.textPrimary,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        color: AppColors.goldSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(
              CupertinoIcons.chevron_right,
              color: AppColors.goldPrimary,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
