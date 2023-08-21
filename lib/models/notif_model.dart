// class NotificationManager {
//   static final NotificationManager _instance = NotificationManager._internal();

//   factory NotificationManager() {
//     return _instance;
//   }

//   NotificationManager._internal();

//   final List<String> notifications = [];

//   void addNotification(String message) {
//     if (notifications.length >= 20) {
//       notifications.removeAt(0); // Remove the oldest notification
//     }
//     notifications.add(message);
//   }

//   List<String> getNotifications() {
//     return notifications;
//   }
// }
