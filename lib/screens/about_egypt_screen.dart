import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';

class AboutEgyptScreen extends StatelessWidget {
  const AboutEgyptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyles.backgroundGradient,
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.transparent,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: AppColors.secondaryBg.withValues(alpha: 0.9),
          border: Border(
            bottom: BorderSide(
              color: AppColors.goldSecondary.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          middle: Text('🇪🇬 About Egypt', style: AppStyles.titleSmall),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // Header Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: AppStyles.cardDecoration.copyWith(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.secondaryBg,
                          AppColors.primaryBg,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.glowGold.withValues(alpha: 0.3),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.goldPrimary,
                                AppColors.goldSecondary,
                              ],
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
                          child: const Text('🏛️', style: TextStyle(fontSize: 64)),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Land of Pharaohs',
                          style: TextStyle(
                            color: AppColors.goldPrimary,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: AppColors.glowGold,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '🌍 Transcontinental Wonder',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Overview Section
                  _SectionCard(
                    icon: '📜',
                    title: 'Overview',
                    children: [
                      _InfoText(
                        'Egypt is a transcontinental country spanning the northeast corner of Africa and southwest corner of Asia, connected by the Sinai Peninsula. With over 5,000 years of recorded history, it is home to some of the world\'s most ancient monuments and archaeological wonders.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Quick Facts
                  _SectionCard(
                    icon: '📊',
                    title: 'Quick Facts',
                    children: [
                      _FactRow(emoji: '🏛️', label: 'Capital', value: 'Cairo'),
                      _FactRow(emoji: '🗣️', label: 'Language', value: 'Arabic'),
                      _FactRow(emoji: '💰', label: 'Currency', value: 'Egyptian Pound (EGP)'),
                      _FactRow(emoji: '👥', label: 'Population', value: '~106 million'),
                      _FactRow(emoji: '📏', label: 'Area', value: '1,010,408 km²'),
                      _FactRow(emoji: '⏰', label: 'Time Zone', value: 'EET (UTC+2)'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // UNESCO Sites
                  _SectionCard(
                    icon: '🏆',
                    title: 'UNESCO World Heritage Sites',
                    children: [
                      _InfoText(
                        'Egypt is home to 7 UNESCO World Heritage Sites, showcasing its incredible historical and cultural legacy:',
                      ),
                      const SizedBox(height: 12),
                      _ListItem('🔺 Memphis and its Necropolis - The Pyramid Fields from Giza to Dahshur'),
                      _ListItem('🏛️ Ancient Thebes with its Necropolis'),
                      _ListItem('🗿 Nubian Monuments from Abu Simbel to Philae'),
                      _ListItem('⛪ Historic Cairo'),
                      _ListItem('🏜️ Abu Mena'),
                      _ListItem('⛰️ Saint Catherine Area'),
                      _ListItem('🐋 Wadi Al-Hitan (Whale Valley)'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Climate
                  _SectionCard(
                    icon: '🌡️',
                    title: 'Climate',
                    children: [
                      _InfoText(
                        'Egypt has a hot desert climate with two seasons:',
                      ),
                      const SizedBox(height: 12),
                      _ClimateCard(
                        season: '☀️ Hot Summer',
                        months: 'May - October',
                        temp: '25-35°C (77-95°F)',
                        description: 'Hot and dry with minimal rainfall',
                        color: AppColors.accentOrange,
                      ),
                      const SizedBox(height: 12),
                      _ClimateCard(
                        season: '🌤️ Mild Winter',
                        months: 'November - April',
                        temp: '10-20°C (50-68°F)',
                        description: 'Mild temperatures, ideal for tourism',
                        color: AppColors.bluePrimary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Ancient Wonders
                  _SectionCard(
                    icon: '✨',
                    title: 'Ancient Wonders',
                    children: [
                      _WonderCard(
                        emoji: '🔺',
                        title: 'The Great Pyramid of Giza',
                        subtitle: 'The only surviving Wonder of the Ancient World',
                        info: 'Built around 2560 BC, stands 146.5 meters tall',
                      ),
                      const SizedBox(height: 12),
                      _WonderCard(
                        emoji: '🦁',
                        title: 'The Great Sphinx',
                        subtitle: 'Mysterious guardian of the pyramids',
                        info: 'Carved from limestone, 73 meters long',
                      ),
                      const SizedBox(height: 12),
                      _WonderCard(
                        emoji: '🏛️',
                        title: 'Karnak Temple Complex',
                        subtitle: 'Largest religious building ever made',
                        info: 'Construction spanned 2,000 years',
                      ),
                      const SizedBox(height: 12),
                      _WonderCard(
                        emoji: '⚱️',
                        title: 'Valley of the Kings',
                        subtitle: 'Burial site of pharaohs',
                        info: '63 tombs including Tutankhamun\'s',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Culture & Traditions
                  _SectionCard(
                    icon: '🎭',
                    title: 'Culture & Traditions',
                    children: [
                      _CultureCard(
                        emoji: '🍽️',
                        title: 'Cuisine',
                        items: [
                          'Koshari - National dish',
                          'Ful medames - Fava bean stew',
                          'Mahshi - Stuffed vegetables',
                          'Basbousa - Sweet semolina cake',
                        ],
                      ),
                      const SizedBox(height: 12),
                      _CultureCard(
                        emoji: '🎨',
                        title: 'Arts & Crafts',
                        items: [
                          'Hieroglyphic art and calligraphy',
                          'Papyrus making',
                          'Traditional jewelry',
                          'Handwoven textiles',
                        ],
                      ),
                      const SizedBox(height: 12),
                      _CultureCard(
                        emoji: '🎵',
                        title: 'Music & Dance',
                        items: [
                          'Traditional folk music',
                          'Belly dancing',
                          'Tahtib stick dance',
                          'Nubian music',
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Travel Tips
                  _SectionCard(
                    icon: '💡',
                    title: 'Travel Tips',
                    children: [
                      _TipCard(
                        emoji: '👕',
                        title: 'Dress Code',
                        description: 'Dress modestly, especially when visiting religious sites. Lightweight, loose clothing is recommended for the heat.',
                      ),
                      const SizedBox(height: 12),
                      _TipCard(
                        emoji: '💧',
                        title: 'Stay Hydrated',
                        description: 'Drink plenty of bottled water. The desert climate can be very dehydrating.',
                      ),
                      const SizedBox(height: 12),
                      _TipCard(
                        emoji: '🕌',
                        title: 'Respect Customs',
                        description: 'Remove shoes when entering mosques. Ask permission before photographing locals.',
                      ),
                      const SizedBox(height: 12),
                      _TipCard(
                        emoji: '💵',
                        title: 'Bargaining',
                        description: 'Haggling is expected in markets (souks). Start at 50% of the asking price.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Best Time to Visit
                  _SectionCard(
                    icon: '📅',
                    title: 'Best Time to Visit',
                    children: [
                      _TimeCard(
                        period: '🌟 Peak Season',
                        months: 'October - April',
                        description: 'Perfect weather for sightseeing. Expect crowds and higher prices.',
                        color: AppColors.goldPrimary,
                      ),
                      const SizedBox(height: 12),
                      _TimeCard(
                        period: '🔥 Off Season',
                        months: 'May - September',
                        description: 'Very hot but fewer tourists. Better deals on accommodation.',
                        color: AppColors.accentOrange,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Footer
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: AppStyles.cardDecoration,
                    child: const Column(
                      children: [
                        Text(
                          '✨ 𓂀 Welcome to Egypt 𓂀 ✨',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.goldPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: AppColors.glowGold,
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Experience the magic of ancient civilization',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Section Card Widget
class _SectionCard extends StatelessWidget {
  final String icon;
  final String title;
  final List<Widget> children;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppStyles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                icon,
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.goldPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(color: AppColors.glowGold, blurRadius: 6),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

// Info Text Widget
class _InfoText extends StatelessWidget {
  final String text;

  const _InfoText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 15,
        height: 1.5,
      ),
    );
  }
}

// Fact Row Widget
class _FactRow extends StatelessWidget {
  final String emoji;
  final String label;
  final String value;

  const _FactRow({
    required this.emoji,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.goldSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// List Item Widget
class _ListItem extends StatelessWidget {
  final String text;

  const _ListItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '  ',
            style: TextStyle(
              color: AppColors.goldPrimary,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Climate Card Widget
class _ClimateCard extends StatelessWidget {
  final String season;
  final String months;
  final String temp;
  final String description;
  final Color color;

  const _ClimateCard({
    required this.season,
    required this.months,
    required this.temp,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.2),
            color.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            season,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            months,
            style: const TextStyle(
              color: AppColors.goldSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            temp,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// Wonder Card Widget
class _WonderCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final String info;

  const _WonderCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.secondaryBg,
            AppColors.primaryBg.withValues(alpha: 0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.goldSecondary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.goldPrimary, AppColors.goldSecondary],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: AppColors.glowGold, blurRadius: 8),
              ],
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 32)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.goldSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  info,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Culture Card Widget
class _CultureCard extends StatelessWidget {
  final String emoji;
  final String title;
  final List<String> items;

  const _CultureCard({
    required this.emoji,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accentTeal.withValues(alpha: 0.1),
            AppColors.bluePrimary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.accentTeal.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.accentTeal,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    const Text(
                      '  •  ',
                      style: TextStyle(
                        color: AppColors.goldPrimary,
                        fontSize: 14,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// Tip Card Widget
class _TipCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String description;

  const _TipCard({
    required this.emoji,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accentPink.withValues(alpha: 0.15),
            AppColors.goldSecondary.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.goldSecondary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.goldPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Time Card Widget
class _TimeCard extends StatelessWidget {
  final String period;
  final String months;
  final String description;
  final Color color;

  const _TimeCard({
    required this.period,
    required this.months,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.2),
            color.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            period,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            months,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
