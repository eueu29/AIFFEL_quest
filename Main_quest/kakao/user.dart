class Message {
  final String text;
  final bool isSentByMe;

  Message(this.text, this.isSentByMe);
}

class User {
  final String name;
  final String status;
  List<Message> chatMessages;
  final String imagePath;
  final String time;

  User(this.name, this.status, this.chatMessages, this.imagePath, this.time);
}