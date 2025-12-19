import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../providers/app_provider.dart';
import '../theme/app_colors.dart';
import '../models/fortune_reward.dart';

class FortuneWheelScreen extends StatefulWidget {
  const FortuneWheelScreen({super.key});

  @override
  State<FortuneWheelScreen> createState() => _FortuneWheelScreenState();
}

class _FortuneWheelScreenState extends State<FortuneWheelScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _spinController;
  bool _isSpinning = false;
  FortuneReward? _reward;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  void _spin() {
    final provider = Provider.of<AppProvider>(context, listen: false);
    
    if (!provider.canSpinFortuneWheel) {
      _showAlreadySpunDialog();
      return;
    }

    setState(() => _isSpinning = true);
    
    _spinController.reset();
    _spinController.forward().then((_) {
      final reward = provider.spinFortuneWheel();
      setState(() {
        _reward = reward;
        _isSpinning = false;
      });
      _showRewardDialog(reward);
    });
  }

  void _showAlreadySpunDialog() {
    final provider = Provider.of<AppProvider>(context, listen: false);
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('🔮 Daily Limit Reached'),
        content: Text(
          'You\'ve already spun the Fortune Wheel today!\n\nToday\'s reward: ${provider.todayFortuneReward?.emoji} ${provider.todayFortuneReward?.title}',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showRewardDialog(FortuneReward reward) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(reward.emoji),
            const SizedBox(width: 8),
            Flexible(child: Text(reward.title)),
          ],
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(
            reward.description,
            style: const TextStyle(fontSize: 15),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Accept Quest'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final canSpin = provider.canSpinFortuneWheel;

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
          '🔮 Fortune Wheel',
          style: TextStyle(
            color: AppColors.goldPrimary,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                
                // Title
                Text(
                  'Ancient Egyptian Oracle',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldPrimary,
                    shadows: [
                      Shadow(
                        color: AppColors.glowGold,
                        blurRadius: 20,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 12),
                
                Text(
                  'Spin once per day',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
                
                const SizedBox(height: 60),
                
                // Fortune Wheel
                AnimatedBuilder(
                  animation: _spinController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _spinController.value * 4 * math.pi,
                      child: Container(
                        width: 280,
                        height: 280,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              AppColors.goldPrimary,
                              AppColors.goldSecondary,
                              AppColors.accentPink,
                              AppColors.bluePrimary,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.glowGold,
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            // Center circle
                            Center(
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.secondaryBg,
                                  border: Border.all(
                                    color: AppColors.goldPrimary,
                                    width: 3,
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    '👁️',
                                    style: TextStyle(fontSize: 50),
                                  ),
                                ),
                              ),
                            ),
                            // Symbols around
                            ...List.generate(8, (index) {
                              final angle = (index * math.pi * 2 / 8);
                              final symbols = ['☥', '🔺', '👁️', '🐍', '⚱️', '🪲', '☀️', '🌙'];
                              return Positioned(
                                left: 140 + math.cos(angle) * 100 - 15,
                                top: 140 + math.sin(angle) * 100 - 15,
                                child: Text(
                                  symbols[index],
                                  style: const TextStyle(fontSize: 30),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 80),
                
                // Spin Button
                GestureDetector(
                  onTap: _isSpinning ? null : _spin,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 18,
                    ),
                    decoration: BoxDecoration(
                      gradient: canSpin
                          ? LinearGradient(
                              colors: [
                                AppColors.goldPrimary,
                                AppColors.goldSecondary,
                              ],
                            )
                          : null,
                      color: canSpin ? null : AppColors.textTertiary,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: canSpin
                          ? [
                              BoxShadow(
                                color: AppColors.glowGold,
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      _isSpinning
                          ? 'Spinning...'
                          : canSpin
                              ? '✨ SPIN THE WHEEL ✨'
                              : '🔒 Come Back Tomorrow',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: canSpin
                            ? AppColors.primaryBg
                            : AppColors.secondaryBg,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Current reward if already spun
                if (!canSpin && provider.todayFortuneReward != null)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.secondaryBg,
                          AppColors.secondaryBg.withValues(alpha: 0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.goldSecondary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Today\'s Fortune',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '${provider.todayFortuneReward!.emoji} ${provider.todayFortuneReward!.title}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          provider.todayFortuneReward!.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
