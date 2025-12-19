import 'package:flutter/material.dart';

class AppConfig {
  static const String webGLEndpoint =
      'https://play.unity.com/api/v1/games/game/0da08167-1d8b-437c-9bc0-0ea301c00d34/build/latest/frame';

  static const String logoPath = 'assets/images/Logo.png';
  static const String loadingBackgroundPath =
      'assets/images/SplashBackground.png';

  //========================= Loading Screen ====================//
  static const String webGLLoadingText = 'Initialization...';
  static const Color webGLSpinerColor = Color(0xFFFFFFFF);
  static const Color webGLLoadingTextColor = Color(0xFCFFFFFF);
  static const Decoration webGLLoadingDecoration = const BoxDecoration(
    //закоментировать если не нужен градиент
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF7F3CCA),
        Color(0xFF23003C),
      ],
    ),

    //закоментировать если не нужен фон из изображения
    image: DecorationImage(
      image: AssetImage(AppConfig.loadingBackgroundPath),
      fit: BoxFit.cover,
    ),
  );
}
