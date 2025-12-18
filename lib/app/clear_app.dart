import 'package:flutter/cupertino.dart';

class ClearApp extends StatelessWidget {
  const ClearApp({super.key});

  static const Color _backgroundColor = Color(0xFF1C1C24);
  static const Color _surfaceColor = Color(0xFF232332);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,

      home: CupertinoPageScaffold(child: Center(child: Text('Hello World!'))),
    );
  }
}
