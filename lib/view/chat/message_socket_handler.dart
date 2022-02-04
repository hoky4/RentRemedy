import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/models/Message/message.dart';
import 'package:rentremedy_mobile/models/Message/message_model.dart';
import 'package:rentremedy_mobile/models/Message/model.dart';
import 'package:rentremedy_mobile/models/Message/websocket_message.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';
import 'package:web_socket_channel/io.dart';

import 'message_screen.dart';

class MessageSocketHandler extends StatefulWidget {
  const MessageSocketHandler({Key? key}) : super(key: key);

  @override
  _MessageSocketHandlerState createState() => _MessageSocketHandlerState();
}

class _MessageSocketHandlerState extends State<MessageSocketHandler> {
  late IOWebSocketChannel channel;
  late ApiService apiService;
  late String cookie;
  late List<Message> conversation;
  late String landlordId;
  late String userId;

  @override
  void initState() {
    apiService = Provider.of<ApiService>(context, listen: false);
    cookie = apiService.cookie;
    conversation = apiService.conversation;

    channel = IOWebSocketChannel.connect(
      'wss://10.0.2.2:5001/api/ws/connect',
      headers: <String, dynamic>{
        'Content-Type': 'application/json',
        "Cookie": cookie
      },
    );
    fetchUserAndLandlordId();

    // fetchConversation();

    super.initState();
  }

  fetchUserAndLandlordId() async {
    await apiService.getLandlordId().then((String id) {
      landlordId = id;
    });
    await apiService.getUserId().then((String id) {
      userId = id;
    });
  }

  // Future<void> fetchConversation() async {
  //   await apiService.getConversation().then((List<Message> messages) {
  //     conversation = messages;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    List<Message> recentMessages;
    List<Message> messageSortedByDate;
    // List<Message> conversation;
    return Consumer<MessageModel>(builder: (context, cart, child) {
      recentMessages = cart.recentMessages;
      // conversation.addAll(recentMessages);
      List<Message> allMessages = recentMessages + conversation;
      var messageModel = context.watch<MessageModel>();

      if (messageModel.sendQueue.length > 0) {
        print('There are messages ready to send.');
        WebSocketMessage outboundMsg = messageModel.sendQueue.removeAt(0);
        print(
            'Outbound msg: ${outboundMsg.messageText} to ${outboundMsg.recipient}');
        channel.sink.add(jsonEncode(outboundMsg));
        messageModel.pendingQueue.add(outboundMsg);
        print('Outbound msg sent.');
      }

      return StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          Map<String, dynamic> responseMap;
          String inboundMessage = snapshot.data.toString();
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              responseMap = jsonDecode(inboundMessage);

              Message message;
              if (responseMap['sender'] != null) {
                message =
                    apiService.parseInboundMessageFromSocket(inboundMessage);
                print(
                    'message: ${message.messageText}; sender: ${message.sender}');
                // messageModel.messageReceived(message); //Throws error
              } else if (responseMap['messageId'] != null &&
                  responseMap['messageTempId'] != null) {
                print('Message delivered response.');
                List<WebSocketMessage> pendingQueue = messageModel.pendingQueue;
                String deliveredTempId = responseMap['messageTempId'];
                final int index = pendingQueue.indexWhere(
                    ((msg) => msg.messageTempId == deliveredTempId));
                if (index != -1) {
                  print('Found matching tempId from pendingQueue');
                  WebSocketMessage deliveredMessage =
                      pendingQueue.removeAt(index);
                  Message wsMsgToMsg = Message.lessArguments(
                      userId,
                      deliveredMessage.recipient,
                      deliveredMessage.messageText,
                      deliveredMessage.messageTempId,
                      DateTime.now());
                  messageModel.messageReceived(wsMsgToMsg);
                }
              }
            }
          }

          return MessageScreen(allMessages: allMessages);
        },
      );
    });
  }

  sendMessage({required String input}) async {
    final message = WebSocketMessage(landlordId, input, "2", Model.Message);

    channel.sink.add(jsonEncode(message.toJson()));
  }
}
