import 'package:flutter/cupertino.dart';
import '../theme/app_colors.dart';
import '../models/place_timeline.dart';
import '../models/place.dart';

class TimePortalScreen extends StatefulWidget {
  final Place place;

  const TimePortalScreen({super.key, required this.place});

  @override
  State<TimePortalScreen> createState() => _TimePortalScreenState();
}

class _TimePortalScreenState extends State<TimePortalScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentIndex = 0;
  late List<TimelineEvent> _events;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    final timelines = PlaceTimeline.getTimelines();
    final timeline = timelines[widget.place.id];
    _events = timeline?.events ?? [];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextEvent() {
    if (_currentIndex < _events.length - 1) {
      setState(() => _currentIndex++);
    }
  }

  void _previousEvent() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_events.isEmpty) {
      return CupertinoPageScaffold(
        backgroundColor: AppColors.primaryBg,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: AppColors.secondaryBg,
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(CupertinoIcons.back, color: AppColors.goldPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          middle: Text(
            '⏳ Time Portal',
            style: TextStyle(
              color: AppColors.goldPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child: Center(
          child: Text(
            'No timeline available for this place',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    final currentEvent = _events[_currentIndex];

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
          '⏳ Time Portal',
          style: TextStyle(
            color: AppColors.goldPrimary,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // Place name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                widget.place.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            const SizedBox(height: 12),
            
            Text(
              'Journey Through Time',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Time portal animation
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.bluePrimary.withValues(alpha: 0.3),
                        AppColors.accentPink.withValues(alpha: 0.2),
                        AppColors.goldPrimary.withValues(alpha: 0.1),
                      ],
                      stops: [
                        _controller.value * 0.3,
                        _controller.value * 0.6,
                        _controller.value,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.bluePrimary.withValues(alpha: 0.3),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      currentEvent.emoji,
                      style: const TextStyle(fontSize: 80),
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 40),
            
            // Event card
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.secondaryBg,
                          AppColors.secondaryBg.withValues(alpha: 0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.goldSecondary.withValues(alpha: 0.3),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.glowGold,
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Year badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.goldPrimary,
                                AppColors.goldSecondary,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.glowGold,
                                blurRadius: 12,
                              ),
                            ],
                          ),
                          child: Text(
                            currentEvent.year,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryBg,
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Title
                        Text(
                          currentEvent.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Description
                        Text(
                          currentEvent.description,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: AppColors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            // Navigation
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Progress dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_events.length, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: index == _currentIndex ? 12 : 8,
                        height: index == _currentIndex ? 12 : 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == _currentIndex
                              ? AppColors.goldPrimary
                              : AppColors.textTertiary,
                          boxShadow: index == _currentIndex
                              ? [
                                  BoxShadow(
                                    color: AppColors.glowGold,
                                    blurRadius: 8,
                                  ),
                                ]
                              : null,
                        ),
                      );
                    }),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Navigation buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        color: _currentIndex > 0
                            ? AppColors.secondaryBg
                            : AppColors.textTertiary,
                        borderRadius: BorderRadius.circular(12),
                        onPressed: _currentIndex > 0 ? _previousEvent : null,
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.chevron_left,
                              color: _currentIndex > 0
                                  ? AppColors.goldPrimary
                                  : AppColors.textSecondary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Previous',
                              style: TextStyle(
                                color: _currentIndex > 0
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CupertinoButton(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        color: _currentIndex < _events.length - 1
                            ? AppColors.secondaryBg
                            : AppColors.textTertiary,
                        borderRadius: BorderRadius.circular(12),
                        onPressed: _currentIndex < _events.length - 1
                            ? _nextEvent
                            : null,
                        child: Row(
                          children: [
                            Text(
                              'Next',
                              style: TextStyle(
                                color: _currentIndex < _events.length - 1
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              CupertinoIcons.chevron_right,
                              color: _currentIndex < _events.length - 1
                                  ? AppColors.goldPrimary
                                  : AppColors.textSecondary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
