import 'package:flutter/cupertino.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFF1C1C24),
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Color(0xFF232332),
        border: null,
        middle: Text(
          'Favorites',
          style: TextStyle(color: CupertinoColors.white),
        ),
      ),
      child: const SafeArea(
        child: Center(
          child: Text(
            'Favorites Screen',
            style: TextStyle(
              color: CupertinoColors.white,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
