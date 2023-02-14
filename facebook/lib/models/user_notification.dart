class UserNotification {
  final String imageUrl;
  final String content;
  final String time;

  UserNotification(
      {required this.imageUrl, required this.content, required this.time});
}

List<UserNotification> notifications = [
  new UserNotification(
      imageUrl: 'assets/goalcast.png',
      content: 'Goalcast posted a new video',
      time: '3 hours ago'),
];
