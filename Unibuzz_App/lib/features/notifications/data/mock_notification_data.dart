import '../../home/data/mock_home_data.dart';

enum NotificationType {
  newEvent,
  endingSoon,
  reminder,
}

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String time;
  final NotificationType type;
  final bool isUnread;
  final EventModel? linkedEvent; // The event this notification relates to

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isUnread = false,
    this.linkedEvent,
  });
}

class MockNotificationData {
  static List<NotificationModel> notifications = [
    NotificationModel(
      id: '1',
      title: 'Reminder: Neon Night',
      message: 'Your event is tonight at 8 PM! Don\'t forget your ID.',
      time: 'Just now',
      type: NotificationType.reminder,
      isUnread: true,
      linkedEvent: MockHomeData.urgentEvents[0], 
    ),
    NotificationModel(
      id: '2',
      title: 'Registration Ending Soon',
      message: 'Only 4 hours left to register for Hackathon 24.',
      time: '2h ago',
      type: NotificationType.endingSoon,
      isUnread: true,
      linkedEvent: MockHomeData.urgentEvents[1],
    ),
    NotificationModel(
      id: '3',
      title: 'New Event Added',
      message: 'RoboWars has been added to the Tech category.',
      time: '5h ago',
      type: NotificationType.newEvent,
      isUnread: false,
      linkedEvent: MockHomeData.urgentEvents[2],
    ),
    NotificationModel(
      id: '4',
      title: 'Reminder: AI Workshop',
      message: 'The workshop starts tomorrow at 2 PM.',
      time: '1d ago',
      type: NotificationType.reminder,
      isUnread: false,
      linkedEvent: MockHomeData.feedEvents[1],
    ),
    NotificationModel(
      id: '5',
      title: 'New Event Added',
      message: 'Chess Tournament is now open for registration.',
      time: '2d ago',
      type: NotificationType.newEvent,
      isUnread: false,
      linkedEvent: MockHomeData.feedEvents[4],
    ),
  ];
}
