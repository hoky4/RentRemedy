import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/models/Message/message.dart';
import 'package:rentremedy_mobile/models/Message/message_model.dart';
import 'package:rentremedy_mobile/models/Message/model.dart';
import 'package:rentremedy_mobile/models/Message/websocket_message.dart';
import 'package:rentremedy_mobile/networking/api.dart';
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
    super.initState();

    apiService = Provider.of<ApiService>(context, listen: false);
    cookie = apiService.cookie;
    conversation = [];
    // conversation = apiService.conversation;

    channel = IOWebSocketChannel.connect(
      '$WEBSOCKET',
      headers: <String, dynamic>{
        'Content-Type': 'application/json',
        "Cookie": cookie
      },
    );

    fetchUserAndLandlordId();
    fetchConversation();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      setupChannel();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      checkForNewMessages();
    });
  }

  fetchConversation() async {
    List<Message> convo = await apiService.getConversation();
    setState(() {
      conversation = convo;
    });
  }

  fetchUserAndLandlordId() async {
    await apiService.getLandlordId().then((String id) {
      landlordId = id;
    });
    await apiService.getUserId().then((String id) {
      userId = id;
    });
  }

  /// listener and handler for inbound messages
  void setupChannel() {
    var messageModel = context.read<MessageModel>();

    channel.stream.listen((m) {
      Map<String, dynamic> responseMap = jsonDecode(m);

      if (responseMap['model'] == Model.Message.index) {
        print('recv msg');
        Message message = apiService.parseInboundMessageFromSocket(m);
        messageModel.messageReceived(message);
      } else if (responseMap['model'] == Model.MessageDelivered.index) {
        DateTime deliveredDate =
            DateTime.parse(responseMap['messageDeliveredDate']);
        messageModel.movePendingMessageToRecent(
            responseMap['messageTempId'], deliveredDate, userId);
      }
    });
  }

  /// hanlder for outbound messages
  void checkForNewMessages() {
    print('recv inbound message');
    var messageModel = context.read<MessageModel>();

    if (messageModel.sendQueue.isNotEmpty) {
      WebSocketMessage outboundMsg = messageModel.sendQueue[0];
      channel.sink.add(jsonEncode({
        'recipient': outboundMsg.recipient,
        'messageText': outboundMsg.messageText,
        'messageTempId': outboundMsg.messageTempId,
        'model': 1
      }));

      messageModel.moveFirstMessageFromSendToPending();
    }
  }

  void dipose() {
    channel.sink.close();
    print('closing socket.');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var messageModel = context.watch<MessageModel>();

    List<Message> recentMessages = messageModel.recentMessages;
    List<Message> allMessages = (recentMessages + conversation);

    allMessages.sort((a, b) => a.creationDate.compareTo(b.creationDate));

    return MessageScreen(allMessages: allMessages);
  }
}
