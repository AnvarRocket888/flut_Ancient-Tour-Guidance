import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/place.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';
import 'place_detail_screen.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final places = provider.places.where((place) {
      final matchesSearch =
          place.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              place.location.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' ||
          place.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    final categories = ['All', ...provider.places.map((p) => p.category).toSet()];

    return Container(
      decoration: AppStyles.backgroundGradient,
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.transparent,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: AppColors.secondaryBg.withValues(alpha: 0.9),
          border: Border(bottom: BorderSide(color: AppColors.goldSecondary.withValues(alpha: 0.3), width: 1)),
          middle: Text(
            '📍 Discover Places',
            style: AppStyles.titleSmall,
          ),
        ),
      child: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: AppStyles.cardDecoration,
                child: CupertinoSearchTextField(
                  style: AppStyles.bodyLarge,
                  placeholderStyle: AppStyles.bodySmall,
                  itemColor: AppColors.goldPrimary,
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
            ),
            // Category filter
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category == _selectedCategory;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: isSelected
                            ? AppStyles.buttonDecoration
                            : AppStyles.cardDecoration,
                        child: Text(
                          category == 'All' ? '✨ All' : category,
                          style: AppStyles.bodyMedium.copyWith(
                            color: isSelected ? AppColors.primaryBg : AppColors.textPrimary,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Places list
            Expanded(
              child: places.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '🔍',
                            style: TextStyle(fontSize: 60),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No places found',
                            style: AppStyles.titleSmall,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Try different search or filter',
                            style: AppStyles.bodySmall,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: places.length,
                      itemBuilder: (context, index) {
                        final place = places[index];
                        return _PlaceCard(place: place);
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

class _PlaceCard extends StatelessWidget {
  final Place place;

  const _PlaceCard({required this.place});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final isFavorite = provider.isFavorite(place.id);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => PlaceDetailScreen(place: place),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: AppStyles.cardDecoration.copyWith(
          boxShadow: [
            BoxShadow(
              color: AppColors.glowGold.withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: AppColors.shadowDark,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Emoji icon
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.tertiaryBg, AppColors.cardBg],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.goldSecondary.withValues(alpha: 0.3),
                      width: 2,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.glowBlue,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      place.imageEmoji,
                      style: const TextStyle(fontSize: 36),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Title and location
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.name,
                        style: AppStyles.titleSmall.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.location_solid,
                            size: 14,
                            color: AppColors.goldSecondary,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              place.location,
                              style: AppStyles.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Favorite button
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    provider.toggleFavorite(place.id);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: isFavorite
                          ? const LinearGradient(
                              colors: [AppColors.accentPink, AppColors.goldSecondary],
                            )
                          : null,
                      color: isFavorite ? null : AppColors.tertiaryBg,
                      boxShadow: isFavorite
                          ? [
                              const BoxShadow(
                                color: AppColors.accentPink,
                                blurRadius: 15,
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      isFavorite
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      color: isFavorite ? AppColors.textPrimary : AppColors.textTertiary,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Description
            Text(
              place.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.bodyMedium,
            ),
            const SizedBox(height: 16),
            // Info row
            Row(
              children: [
                _InfoChip(
                  icon: CupertinoIcons.time,
                  label: '⏱️ ${place.estimatedTimeMinutes} min',
                ),
                const SizedBox(width: 8),
                _InfoChip(
                  icon: CupertinoIcons.tag,
                  label: '🏛️ ${place.category}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.cardBg, AppColors.tertiaryBg],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.goldSecondary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
