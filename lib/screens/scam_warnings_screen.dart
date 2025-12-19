import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/scam_warning.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';

class ScamWarningsScreen extends StatelessWidget {
  const ScamWarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final warnings = provider.scamWarnings;

    return Container(
      decoration: AppStyles.backgroundGradient,
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.transparent,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: AppColors.secondaryBg.withValues(alpha: 0.9),
          border: Border(bottom: BorderSide(color: AppColors.goldSecondary.withValues(alpha: 0.3), width: 1)),
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.goldPrimary, AppColors.goldSecondary],
                ),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.glowGold,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Icon(CupertinoIcons.back, color: AppColors.textPrimary, size: 20),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          middle: Text(
            '🛡️ Safety Tips',
            style: AppStyles.titleSmall,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header info
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(24),
                decoration: AppStyles.cardDecoration,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.accentPink, AppColors.goldSecondary],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.glowGold,
                            blurRadius: 16,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        CupertinoIcons.exclamationmark_shield_fill,
                        size: 48,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '🏛️ Stay Safe in Egypt ✨',
                      style: AppStyles.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '⚠️ Be aware of common scams and how to avoid them',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.goldSecondary,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Warnings list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: warnings.length,
                  itemBuilder: (context, index) {
                    final warning = warnings[index];
                    return _WarningCard(warning: warning);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WarningCard extends StatefulWidget {
  final ScamWarning warning;

  const _WarningCard({required this.warning});

  @override
  State<_WarningCard> createState() => _WarningCardState();
}

class _WarningCardState extends State<_WarningCard> {
  bool _isExpanded = false;

  Color _getSeverityColor() {
    switch (widget.warning.severity) {
      case 'high':
        return AppColors.accentPink;
      case 'medium':
        return const Color(0xFFFFA500);
      case 'low':
        return AppColors.goldPrimary;
      default:
        return AppColors.goldSecondary;
    }
  }

  String _getSeverityEmoji() {
    switch (widget.warning.severity) {
      case 'high':
        return '🚨';
      case 'medium':
        return '⚠️';
      case 'low':
        return '💡';
      default:
        return 'ℹ️';
    }
  }

  IconData _getCategoryIcon() {
    switch (widget.warning.category) {
      case 'Transportation':
        return CupertinoIcons.car_fill;
      case 'Tours':
        return CupertinoIcons.map_fill;
      case 'Shopping':
        return CupertinoIcons.bag_fill;
      case 'Dining':
        return CupertinoIcons.waveform;
      case 'Money':
        return CupertinoIcons.money_dollar_circle_fill;
      case 'Accommodation':
        return CupertinoIcons.bed_double_fill;
      default:
        return CupertinoIcons.exclamationmark_triangle_fill;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.secondaryBg,
              AppColors.primaryBg,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _getSeverityColor().withValues(alpha: 0.5),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: _getSeverityColor().withValues(alpha: 0.3),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Category icon
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_getSeverityColor(), _getSeverityColor().withValues(alpha: 0.6)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: _getSeverityColor().withValues(alpha: 0.4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Icon(
                    _getCategoryIcon(),
                    color: AppColors.textPrimary,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 12),
                // Title
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_getSeverityEmoji()} ${widget.warning.title}',
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 17,
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
                        widget.warning.category,
                        style: TextStyle(
                          color: _getSeverityColor(),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // Expand icon
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.goldPrimary, AppColors.goldSecondary],
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.glowGold,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Icon(
                    _isExpanded
                        ? CupertinoIcons.chevron_up
                        : CupertinoIcons.chevron_down,
                    color: AppColors.textPrimary,
                    size: 18,
                  ),
                ),
              ],
            ),
            if (_isExpanded) ...[
              const SizedBox(height: 16),
              // Description
              Text(
                widget.warning.description,
                style: const TextStyle(
                  color: AppColors.goldSecondary,
                  fontSize: 15,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 16),
              // Prevention tips
              Text(
                '🛡️ How to Avoid:',
                style: AppStyles.titleSmall.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 12),
              ...widget.warning.preventionTips.map(
                (tip) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [_getSeverityColor(), _getSeverityColor().withValues(alpha: 0.7)],
                          ),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: _getSeverityColor().withValues(alpha: 0.3),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Icon(
                          CupertinoIcons.checkmark_shield_fill,
                          size: 14,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          tip,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
