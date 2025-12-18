import 'package:flutter/cupertino.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFF1C1C24),
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Color(0xFF232332),
        border: null,
        middle: Text(
          'Map',
          style: TextStyle(color: CupertinoColors.white),
        ),
      ),
      child: const SafeArea(
        child: Center(
          child: Text(
            'Map Screen',
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
