import 'package:flutter/cupertino.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFF1C1C24),
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Color(0xFF232332),
        border: null,
        middle: Text(
          'Welcome',
          style: TextStyle(color: CupertinoColors.white),
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.location_solid,
                size: 80,
                color: CupertinoColors.white,
              ),
              const SizedBox(height: 24),
              const Text(
                'Ancient Tour Guidance',
                style: TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Explore ancient landmarks and discover their fascinating history',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              CupertinoButton(
                color: CupertinoColors.white,
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    color: Color(0xFF1C1C24),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  // Action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
