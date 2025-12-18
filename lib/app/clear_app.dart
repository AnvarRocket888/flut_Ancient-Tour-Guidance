import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../screens/main_screen.dart';
import '../providers/app_provider.dart';

class ClearApp extends StatelessWidget {
  const ClearApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const CupertinoApp(
        debugShowCheckedModeBanner: false,
        theme: CupertinoThemeData(
          brightness: Brightness.dark,
          primaryColor: CupertinoColors.white,
          scaffoldBackgroundColor: Color(0xFF1C1C24),
          barBackgroundColor: Color(0xFF232332),
          textTheme: CupertinoTextThemeData(
            primaryColor: CupertinoColors.white,
          ),
        ),
        home: MainScreen(),
      ),
    );
  }
}
