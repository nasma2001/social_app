
class ChatModel {
  late String senderId;
  late String receiverId;
  late String dateTime;
  late String textMessage;

  ChatModel({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.textMessage,
  });

  ChatModel.fromJson(Map<String, dynamic> json)
  {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    textMessage = json['textMessage'];

  }

  Map<String, dynamic> toMap()
  {
    return {
      'senderId':senderId,
      'receiverId':receiverId,
      'dateTime':dateTime,
      'textMessage':textMessage,
    };
  }
}