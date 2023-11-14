class Notification {
  int id = 0;
  String title = "";
  String body = "";
  String type = "";
  bool isRead = false;
  int userId = 0;
  DateTime createdAt = DateTime.now();

  Notification.fromData(Map<String, dynamic> data) {
    if (data['id'] != null) {
      id = data['id'];
    }

    if (data['title'] != null) {
      title = data['title'];
    }

    if (data['body'] != null) {
      body = data['body'];
    }

    if (data['type'] != null) {
      type = data['type'];
    }

    if (data['is_read'] != null) {
      isRead = data['is_read'] == 1;
    }

    if (data['user_id'] != null) {
      userId = data['user_id'];
    }

    if (data['created_at'] != null) {
      createdAt = DateTime.parse(data['created_at']);
    }
  }
}
