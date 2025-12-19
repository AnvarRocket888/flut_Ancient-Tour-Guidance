import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'scam_warnings_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final completionPercentage = provider.completionPercentage;

    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFF1C1C24),
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Color(0xFF232332),
        border: null,
        middle: Text(
          'Ancient Tour Guidance',
          style: TextStyle(color: CupertinoColors.white),
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
                  decoration: BoxDecoration(
                    color: const Color(0xFF232332),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        CupertinoIcons.location_solid,
                        size: 60,
                        color: CupertinoColors.white,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Explore Egypt',
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Your personal guide to ancient wonders',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Stats
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _StatItem(
                            label: 'Places',
                            value: '${provider.places.length}',
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: const Color(0xFF1C1C24),
                          ),
                          _StatItem(
                            label: 'Visited',
                            value: '${provider.completedChecklistCount}',
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: const Color(0xFF1C1C24),
                          ),
                          _StatItem(
                            label: 'Favorites',
                            value: '${provider.favoritePlaceIds.length}',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Progress
                if (completionPercentage > 0) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF232332),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Progress',
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 8,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1C1C24),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: completionPercentage / 100,
                              child: Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: CupertinoColors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${completionPercentage.toInt()}% Complete',
                          style: const TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                // Quick Actions
                const Text(
                  'Quick Actions',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _ActionCard(
                  icon: CupertinoIcons.shield_lefthalf_fill,
                  title: 'Safety Tips',
                  subtitle: 'Stay safe during your trip',
                  color: const Color(0xFFFF5252),
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
                  title: 'Travel Tips',
                  subtitle: 'Essential advice for tourists',
                  color: const Color(0xFFFFC107),
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text('Travel Tips'),
                        content: const Text(
                          '✈️ Essential Tips:\n\n'
                          '• Dress modestly, especially at religious sites\n'
                          '• Bring sunscreen and stay hydrated\n'
                          '• Book guided tours for major sites\n'
                          '• Learn basic Arabic phrases\n'
                          '• Carry small bills for tipping\n'
                          '• Avoid tap water - drink bottled water\n'
                          '• Visit early morning to avoid crowds',
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
                  title: 'Currency Guide',
                  subtitle: 'Exchange rates & payment tips',
                  color: const Color(0xFFFFA500),
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text('Currency Guide'),
                        content: const Text(
                          '💰 Egyptian Pound (EGP)\n\n'
                          '• 1 USD ≈ 30-31 EGP\n'
                          '• 1 EUR ≈ 33-34 EGP\n\n'
                          'Tips:\n'
                          '• Exchange at official banks\n'
                          '• Keep small bills for tipping\n'
                          '• Credit cards accepted at major hotels\n'
                          '• ATMs widely available in cities',
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
                  decoration: BoxDecoration(
                    color: const Color(0xFF232332),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.star_fill,
                            color: CupertinoColors.white,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Did You Know?',
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        'The Great Pyramid of Giza was the tallest man-made structure in the world for over 3,800 years! It was built around 2560 BC and remained the tallest until the Lincoln Cathedral was completed in 1311 AD.',
                        style: TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontSize: 14,
                          height: 1.5,
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF232332),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withAlpha(51),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
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
                      color: CupertinoColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              CupertinoIcons.chevron_right,
              color: Color(0xFF9E9E9E),
              size: 20,
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
          style: const TextStyle(
            color: CupertinoColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF9E9E9E),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
