class ChatMessage {
  final String text;
  final bool isSender;

  ChatMessage({this.text = '', required this.isSender});
}

List demoChatMessage = [
  ChatMessage(text: 'Welcome to Rent Remedy!', isSender: false),
  ChatMessage(text: "What's the wifi password again?", isSender: true),
  ChatMessage(text: 'Password is password123', isSender: false),
  ChatMessage(text: 'Thanks!', isSender: true),
];
