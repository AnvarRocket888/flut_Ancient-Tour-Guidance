import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/challenge_category.dart';
import '../models/challenge.dart';
import '../theme/app_colors.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  ChallengeCategory? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final challenges = provider.getChallengesByCategory(_selectedCategory);

    return CupertinoPageScaffold(
      backgroundColor: AppColors.primaryBg,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColors.secondaryBg,
        border: Border(
          bottom: BorderSide(
            color: AppColors.goldSecondary.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.back, color: AppColors.goldPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text(
          '🎮 Game Challenges',
          style: TextStyle(
            color: AppColors.goldPrimary,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Category Progress Bars
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.secondaryBg,
                      AppColors.secondaryBg.withValues(alpha: 0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.goldSecondary.withValues(alpha: 0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.goldPrimary.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Aspects',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...ChallengeCategory.values.map((category) {
                      final progress = provider.getCategoryProgress(category);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildProgressBar(
                          category.icon,
                          category.name,
                          progress,
                          category.color,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            // Category Filter
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCategoryChip(
                        'All',
                        null,
                        AppColors.goldPrimary,
                      ),
                      const SizedBox(width: 8),
                      ...ChallengeCategory.values.map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _buildCategoryChip(
                            '${category.icon} ${category.name}',
                            category,
                            category.color,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Challenges List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final challenge = challenges[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildChallengeItem(challenge, provider),
                    );
                  },
                  childCount: challenges.length,
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(
      String emoji, String label, double progress, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  emoji,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Text(
              '${progress.toInt()}%',
              style: TextStyle(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.primaryBg,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              FractionallySizedBox(
                widthFactor: progress / 100,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, color.withValues(alpha: 0.6)],
                    ),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String label, ChallengeCategory? category, Color color) {
    final isSelected = _selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [color, color.withValues(alpha: 0.7)],
                )
              : null,
          color: isSelected ? null : AppColors.secondaryBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? color
                : AppColors.goldSecondary.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? CupertinoColors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildChallengeItem(Challenge challenge, AppProvider provider) {
    return GestureDetector(
      onTap: () {
        provider.toggleChallenge(challenge.id);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.secondaryBg,
              AppColors.secondaryBg.withValues(alpha: 0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: challenge.isCompleted
                ? challenge.category.color
                : AppColors.goldSecondary.withValues(alpha: 0.2),
            width: challenge.isCompleted ? 2 : 1,
          ),
          boxShadow: challenge.isCompleted
              ? [
                  BoxShadow(
                    color: challenge.category.color.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Color indicator
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    challenge.category.color,
                    challenge.category.color.withValues(alpha: 0.5),
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: challenge.category.color.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            
            // Challenge text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    challenge.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                      decoration: challenge.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        challenge.category.icon,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        challenge.category.name,
                        style: TextStyle(
                          fontSize: 12,
                          color: challenge.category.color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Checkbox
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: challenge.isCompleted
                    ? LinearGradient(
                        colors: [
                          challenge.category.color,
                          challenge.category.color.withValues(alpha: 0.7),
                        ],
                      )
                    : null,
                color: challenge.isCompleted ? null : AppColors.primaryBg,
                border: Border.all(
                  color: challenge.isCompleted
                      ? challenge.category.color
                      : AppColors.goldSecondary.withValues(alpha: 0.3),
                  width: 2,
                ),
                boxShadow: challenge.isCompleted
                    ? [
                        BoxShadow(
                          color: challenge.category.color.withValues(alpha: 0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: challenge.isCompleted
                  ? const Icon(
                      CupertinoIcons.check_mark,
                      size: 16,
                      color: CupertinoColors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
