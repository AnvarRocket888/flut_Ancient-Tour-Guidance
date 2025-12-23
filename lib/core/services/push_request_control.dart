class PushRequestData {
  bool? pushNotificationAccepted;
  String? pushDeclinedAt;
  bool? firstLaunch;

  Map<String, dynamic> toJson() {
    return {
      'pushNotificationAccepted': pushNotificationAccepted,
      'pushDeclinedAt': pushDeclinedAt,
      'firstLaunch': firstLaunch,
    };
  }

  PushRequestData({
    this.pushNotificationAccepted,
    this.pushDeclinedAt,
    this.firstLaunch,
  });

  factory PushRequestData.fromJson(Map<String, dynamic> json) {
    var data = PushRequestData(
      pushNotificationAccepted: json['pushNotificationAccepted'],
      pushDeclinedAt: json['pushDeclinedAt'],
      firstLaunch: json['firstLaunch'],
    );
    return data;
  }
}

class PushRequestControl {
  static bool isDebug = false;

  static bool shouldShowPushRequest(PushRequestData data) {
    // Проверяем, получено ли согласие на уведомления
    final pushAccepted = data.pushNotificationAccepted;
    final firstDeclinedAt = data.pushDeclinedAt;

    // Если пользователь уже дал согласие, не показываем запрос
    if (pushAccepted == true) {
      return false;
    }

    // Если согласие не было получено и отказ не фиксировался, показываем запрос впервые
    if (pushAccepted == null && firstDeclinedAt == null) {
      return true;
    }

    // Если согласие не было получено, но есть дата первого отказа
    if (pushAccepted == false && firstDeclinedAt != null) {
      DateTime? declinedAt;
      try {
        declinedAt = DateTime.parse(firstDeclinedAt);
      } catch (e) {
        return true;
      }
      final now = DateTime.now();

      if (now.difference(declinedAt).inDays >= 3) {
        return true;
      }

      return false;
    }

    // Прочие случаи -- не показываем запрос
    return false;
  }

  // Метод для сохранения согласия пользователя на push-уведомления
  static void acceptPushRequest(PushRequestData data) async {
    data.pushNotificationAccepted = true;
    data.pushDeclinedAt = "";
  }

  // Метод для сохранения отказа пользователя от push-уведомлений
  static void declinePushRequest(PushRequestData data, [DateTime? date]) {
    date ??= DateTime.now();
    data.pushNotificationAccepted = false;
    data.pushDeclinedAt = date.toIso8601String();
  }
}
