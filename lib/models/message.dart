class Message {
  final String sender;
  final String receiver;
  final String message;
  final DateTime createdAt;

  // ignore: sort_constructors_first
  Message({
    this.sender,
    this.receiver,
    this.message,
    this.createdAt,
  });
}
