import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../screens/main_screen.dart';
import '../providers/app_provider.dart';
import '../theme/app_colors.dart';

class ClearApp extends StatelessWidget {
  const ClearApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final provider = AppProvider();
        provider.loadData();
        return provider;
      },
      child: const CupertinoApp(
        debugShowCheckedModeBanner: false,
        theme: CupertinoThemeData(
          brightness: Brightness.dark,
          primaryColor: AppColors.goldPrimary,
          scaffoldBackgroundColor: AppColors.primaryBg,
          barBackgroundColor: AppColors.secondaryBg,
          textTheme: CupertinoTextThemeData(
            primaryColor: AppColors.textPrimary,
          ),
        ),
        home: MainScreen(),
      ),
    );
  }
}
