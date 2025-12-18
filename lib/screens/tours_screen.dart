import 'package:flutter/cupertino.dart';

class ToursScreen extends StatelessWidget {
  const ToursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFF1C1C24),
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Color(0xFF232332),
        border: null,
        middle: Text(
          'Tours',
          style: TextStyle(color: CupertinoColors.white),
        ),
      ),
      child: const SafeArea(
        child: Center(
          child: Text(
            'Tours Screen',
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
