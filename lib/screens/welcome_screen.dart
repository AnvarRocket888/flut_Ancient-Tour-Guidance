import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';
import 'scam_warnings_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final completionPercentage = provider.completionPercentage;

    return Container(
      decoration: AppStyles.backgroundGradient,
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.transparent,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: AppColors.secondaryBg.withOpacity(0.9),
          border: Border(bottom: BorderSide(color: AppColors.goldSecondary.withOpacity(0.3), width: 1)),
          middle: Text(
            '✨ Ancient Tour Guidance ✨',
            style: AppStyles.titleSmall,
          ),
        ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero section
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: AppStyles.cardDecoration,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [AppColors.bluePrimary, AppColors.blueSecondary],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.glowBlue,
                              blurRadius: 25,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          CupertinoIcons.location_solid,
                          size: 60,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '🏛️ Explore Egypt 🌟',
                        style: AppStyles.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '✨ Your personal guide to ancient wonders ✨',
                        textAlign: TextAlign.center,
                        style: AppStyles.bodyMedium.copyWith(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Stats
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.cardBg, AppColors.tertiaryBg],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.goldPrimary.withOpacity(0.3), width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _StatItem(
                              label: '📍 Places',
                              value: '${provider.places.length}',
                            ),
                            Container(
                              width: 2,
                              height: 40,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [AppColors.goldPrimary, AppColors.bluePrimary],
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.glowGold,
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                            ),
                            _StatItem(
                              label: '✅ Visited',
                              value: '${provider.completedChecklistCount}',
                            ),
                            Container(
                              width: 2,
                              height: 40,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [AppColors.goldPrimary, AppColors.bluePrimary],
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.glowGold,
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                            ),
                            _StatItem(
                              label: '⭐ Favorites',
                              value: '${provider.favoritePlaceIds.length}',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Progress
                if (completionPercentage > 0) ...[
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: AppStyles.cardDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.chart_bar_alt_fill,
                              color: AppColors.goldPrimary,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '📊 Your Progress',
                              style: AppStyles.titleMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 12,
                              decoration: BoxDecoration(
                                color: AppColors.primaryBg,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: AppColors.goldSecondary.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: completionPercentage / 100,
                              child: Container(
                                height: 12,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [AppColors.goldPrimary, AppColors.goldSecondary, AppColors.goldDark],
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: AppColors.glowGold,
                                      blurRadius: 15,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '✨ ${completionPercentage.toInt()}% Complete - Keep Going! 🎯',
                          style: AppStyles.bodyMedium.copyWith(
                            color: AppColors.textGold,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                // Quick Actions
                Text(
                  '⚡ Quick Actions',
                  style: AppStyles.titleMedium,
                ),
                const SizedBox(height: 12),
                _ActionCard(
                  icon: CupertinoIcons.shield_lefthalf_fill,
                  title: '🛡️ Safety Tips',
                  subtitle: 'Stay safe during your trip',
                  color: AppColors.accentPink,
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const ScamWarningsScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                _ActionCard(
                  icon: CupertinoIcons.lightbulb_fill,
                  title: '💡 Travel Tips',
                  subtitle: 'Essential advice for tourists',
                  color: const Color(0xFFFFC107),
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: Text('💡 Travel Tips', style: AppStyles.titleSmall),
                        content: Text(
                          '✈️ Essential Tips:\n\n'
                          '👔 Dress modestly at religious sites\n'
                          '☀️ Bring sunscreen & stay hydrated\n'
                          '🎫 Book guided tours for major sites\n'
                          '🗣️ Learn basic Arabic phrases\n'
                          '💵 Carry small bills for tipping\n'
                          '💧 Drink bottled water only\n'
                          '⏰ Visit early morning to avoid crowds',
                          style: AppStyles.bodyMedium,
                        ),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('Got it!'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                _ActionCard(
                  icon: CupertinoIcons.money_dollar_circle_fill,
                  title: '💰 Currency Guide',
                  subtitle: 'Exchange rates & payment tips',
                  color: AppColors.goldSecondary,
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: Text('💰 Currency Guide', style: AppStyles.titleSmall),
                        content: Text(
                          '💵 Egyptian Pound (EGP)\n\n'
                          '💱 Exchange Rates:\n'
                          '• 1 USD ≈ 30-31 EGP\n'
                          '• 1 EUR ≈ 33-34 EGP\n\n'
                          '✨ Tips:\n'
                          '🏦 Exchange at official banks\n'
                          '💵 Keep small bills for tipping\n'
                          '💳 Credit cards at major hotels\n'
                          '🏧 ATMs widely available in cities',
                          style: AppStyles.bodyMedium,
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
                const SizedBox(height: 24),
                // Did you know section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: AppStyles.cardDecoration.copyWith(
                    border: Border.all(color: AppColors.bluePrimary.withOpacity(0.5), width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [AppColors.goldPrimary, AppColors.goldSecondary],
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.glowGold,
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            child: const Icon(
                              CupertinoIcons.star_fill,
                              color: AppColors.primaryBg,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '💡 Did You Know?',
                            style: AppStyles.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '🏛️ The Great Pyramid of Giza was the tallest man-made structure in the world for over 3,800 years! ⏳ It was built around 2560 BC and remained the tallest until the Lincoln Cathedral was completed in 1311 AD. ✨',
                        style: AppStyles.bodyMedium.copyWith(
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: AppStyles.cardDecoration.copyWith(
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: AppColors.shadowDark,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.5), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppStyles.bodySmall.copyWith(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.goldPrimary, AppColors.goldSecondary],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.glowGold,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Icon(
                CupertinoIcons.chevron_right,
                color: AppColors.primaryBg,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppStyles.titleMedium.copyWith(
            fontSize: 26,
            shadows: [
              const Shadow(
                color: AppColors.glowGold,
                blurRadius: 20,
              ),
              const Shadow(
                color: AppColors.glowBlue,
                blurRadius: 15,
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: AppStyles.bodySmall.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
