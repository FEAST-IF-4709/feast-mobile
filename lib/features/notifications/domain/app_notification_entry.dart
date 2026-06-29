/// A persisted notification entry shown in [NotificationListScreen].
class AppNotificationEntry {
  const AppNotificationEntry({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    this.orderId,
    this.isRead = false,
  });

  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final String? orderId;
  final bool isRead;

  AppNotificationEntry copyWith({bool? isRead}) => AppNotificationEntry(
        id: id,
        title: title,
        body: body,
        timestamp: timestamp,
        orderId: orderId,
        isRead: isRead ?? this.isRead,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'timestamp': timestamp.toIso8601String(),
        if (orderId != null) 'orderId': orderId,
        'isRead': isRead,
      };

  static AppNotificationEntry fromJson(Map<String, dynamic> j) =>
      AppNotificationEntry(
        id: j['id'] as String,
        title: j['title'] as String,
        body: j['body'] as String,
        timestamp: DateTime.parse(j['timestamp'] as String),
        orderId: j['orderId'] as String?,
        isRead: (j['isRead'] as bool?) ?? false,
      );
}
