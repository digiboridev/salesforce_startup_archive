import 'dart:convert';

var NotificationDataSearch = {
  "imageUrl": "http....png",
  "title": "Text title",
  "subTitle": "Sub Title Text",
  "message": "Test message",
  "notificationAction": {
    "actionType": "productInStock",
    "productSFId": "a022400000iyJNUAA2"
  }
};

var NotificationDataOpenProduct = {
  "imageUrl": "http....png",
  "title": "Text title",
  "subTitle": "Sub Title Text",
  "message": "Test message",
  "notificationAction": {"actionType": "search", "searchCondition": "Coffe"}
};

class NotificationData {
  final String imageUrl;
  final String title;
  final String subTitle;
  final String message;
  final NotificationAction notificationAction;
  NotificationData({
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    required this.message,
    required this.notificationAction,
  });

  factory NotificationData.fromMap(Map<String, dynamic> map) {
    return NotificationData(
      imageUrl: map['imageUrl'],
      title: map['title'],
      subTitle: map['subTitle'],
      message: map['message'],
      notificationAction: NotificationAction.fromMap(map['notificationAction']),
    );
  }

  factory NotificationData.fromJson(String source) =>
      NotificationData.fromMap(json.decode(source));
}

abstract class NotificationAction {
  String get actionType;

  factory NotificationAction.fromMap(Map<String, dynamic> map) {
    String actionType = map['actionType'];
    if (actionType == 'search') {
      return OpenSearchAction.fromMap(map);
    } else if (actionType == 'productInStock') {
      return OpenMaterialAction.fromMap(map);
    } else {
      return UnimplementedAction.fromMap(map);
    }
  }
}

class OpenSearchAction implements NotificationAction {
  final String actionType;
  final String searchCondition;
  OpenSearchAction({
    required this.actionType,
    required this.searchCondition,
  });

  factory OpenSearchAction.fromMap(Map<String, dynamic> map) {
    return OpenSearchAction(
      actionType: map['actionType'],
      searchCondition: map['searchCondition'],
    );
  }
}

class OpenMaterialAction implements NotificationAction {
  final String actionType;
  final String productSFId;
  OpenMaterialAction({
    required this.actionType,
    required this.productSFId,
  });

  factory OpenMaterialAction.fromMap(Map<String, dynamic> map) {
    return OpenMaterialAction(
      actionType: map['actionType'],
      productSFId: map['productSFId'],
    );
  }
}

class UnimplementedAction implements NotificationAction {
  final String actionType;
  UnimplementedAction({
    required this.actionType,
  });

  factory UnimplementedAction.fromMap(Map<String, dynamic> map) {
    return UnimplementedAction(
      actionType: map['actionType'],
    );
  }
}
