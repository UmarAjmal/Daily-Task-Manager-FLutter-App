class Task {
  final int id;
  final String title;
  final String description;
  final DateTime dueDate;
  late final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isCompleted,
  });
}
  Map<String, dynamic> toMap() {
    var title;
    var id;
    var description;
    var dueDate;
    var isCompleted;
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate']),
      isCompleted: map['isCompleted'] == 1,
    );
  }


// import 'package:awesome_notifications/awesome_notifications.dart';
//
// class Task {
//   final int id;
//   final String title;
//   final String description;
//   final DateTime dueDate;
//   late final bool isCompleted;
//
//
//
//   Task({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.dueDate,
//     required this.isCompleted, required isNotificationScheduled,
//   });
//
//   get isNotificationScheduled => null;
//
//   // Method to schedule a notification for this task
//   Future<void> scheduleNotification() async {
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: id, // Use the task id for unique notification ID
//         channelKey: 'basic_channel',
//         title: 'Task Due Soon!',
//         body: 'The task "$title" is due on ${dueDate.toLocal().toString().split(' ')[0]}.',
//       ),
//       schedule: NotificationCalendar(
//         year: dueDate.year,
//         month: dueDate.month,
//         day: dueDate.day,
//         hour: dueDate.hour,
//         minute: dueDate.minute,
//         second: dueDate.second,
//         millisecond: dueDate.millisecond,
//         preciseAlarm: true,
//       ),
//     );
//   }
//
//   // Method to cancel the notification for this task
//   Future<void> cancelNotification() async {
//     await AwesomeNotifications().cancel(id); // Cancel notification using the task id
//   }
// }
//
