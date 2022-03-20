import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/Model/Message/message.dart';
import 'package:rentremedy_mobile/Model/environment.dart';
import 'package:rentremedy_mobile/Providers/api_service_provider.dart';
import 'package:rentremedy_mobile/Providers/auth_model_provider.dart';
import 'package:rentremedy_mobile/Providers/message_model_provider.dart';
import 'package:rentremedy_mobile/Model/Message/model.dart';
import 'package:rentremedy_mobile/Model/Message/websocket_message.dart';
import 'package:rentremedy_mobile/Networking/api.dart';
import 'package:rentremedy_mobile/View/Maintenance/view_maintenance_requests_screen.dart';
import 'package:rentremedy_mobile/View/Onboarding/join_screen.dart';
import 'package:rentremedy_mobile/View/Payment/view_payments_screen.dart';
import 'package:web_socket_channel/io.dart';
import 'message_screen.dart';

class MessageSocketHandler extends StatefulWidget {
  const MessageSocketHandler({Key? key}) : super(key: key);

  @override
  _MessageSocketHandlerState createState() => _MessageSocketHandlerState();
}

class _MessageSocketHandlerState extends State<MessageSocketHandler>
    with AutomaticKeepAliveClientMixin<MessageSocketHandler> {
  late IOWebSocketChannel channel;
  late ApiServiceProvider apiService;
  late List<Message> conversation;
  late String userId;
  late String cookie;
  bool isLoading = true;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    apiService = Provider.of<ApiServiceProvider>(context, listen: false);
    cookie = context.read<AuthModelProvider>().user!.cookie!;
    userId = context.read<AuthModelProvider>().user!.id;

    conversation = [];

    channel = IOWebSocketChannel.connect(
      Environment.websocket,
      headers: <String, dynamic>{
        'Content-Type': 'application/json',
        "Cookie": cookie
      },
    );
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
    if (mounted) {
      setState(() {
        conversation = convo;
        isLoading = false;
      });
    }
  }

  /// listener and handler for inbound and delivered messages
  void setupChannel() {
    var messageModel = context.read<MessageModelProvider>();

    channel.stream.listen((m) {
      Map<String, dynamic> responseMap = jsonDecode(m);

      if (responseMap['model'] == Model.Message.index) {
        Message message = apiService.parseInboundMessageFromSocket(m);
        messageModel.messageReceived(message);
      } else if (responseMap['model'] == Model.MessageDelivered.index) {
        DateTime deliveredDate =
            DateTime.parse(responseMap['messageDeliveredDate']);
        messageModel.movePendingMessageToRecent(
            responseMap['messageTempId'], deliveredDate, userId);
      }

      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      }
    }, onError: (error) {
      channel = IOWebSocketChannel.connect(
        Environment.websocket,
        headers: <String, dynamic>{
          'Content-Type': 'application/json',
          "Cookie": cookie
        },
      );
    });
  }

  /// hanlder for sending messages
  void checkForNewMessages() {
    var messageModel = context.read<MessageModelProvider>();

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

  @override
  Widget build(BuildContext context) {
    var messageModel = context.watch<MessageModelProvider>();
    var authModel = context.read<AuthModelProvider>();
    LeaseAgreement? leaseAgreement = authModel.leaseAgreement;

    List<Message> recentMessages = messageModel.recentMessages;
    List<Message> allMessages = (recentMessages + conversation);

    allMessages.sort((a, b) => a.creationDate.compareTo(b.creationDate));

    return DefaultTabController(
      length: (leaseAgreement != null && leaseAgreement.signatures.isNotEmpty)
          ? 3
          : 1,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColorDark,
            bottom: TabBar(
              indicatorColor: Colors.blue,
              tabs: [
                const Tab(icon: Icon(Icons.comment_rounded)),
                if (leaseAgreement != null &&
                    leaseAgreement.signatures.isNotEmpty) ...[
                  const Tab(icon: Icon(Icons.attach_money_outlined)),
                  const Tab(icon: Icon(Icons.build_circle_outlined)),
                ],
              ],
            ),
            title: const Text('Rent Remedy'),
            actions: [
              if (authModel.leaseAgreement!.signatures.isEmpty) ...[
                IconButton(
                    icon: const Icon(Icons.document_scanner),
                    onPressed: () async {
                      LeaseAgreement? leaseAgreement = authModel.leaseAgreement;
                      if (leaseAgreement != null) {
                        Navigator.pushReplacementNamed(context, '/terms',
                            arguments: JoinScreenArguments(leaseAgreement));
                      }
                    })
              ],
            ]),
        drawer: Drawer(
          child: ListView(
            // padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('${authModel.user?.email}'),
              ),
              if (authModel.leaseAgreement!.signatures.isNotEmpty) ...[
                ListTile(
                  title: const Text('Lease Agreement'),
                  leading: const Icon(Icons.document_scanner),
                  onTap: () {
                    LeaseAgreement? leaseAgreement = authModel.leaseAgreement;
                    if (leaseAgreement != null) {
                      Navigator.pushNamed(context, '/viewLeaseAgreements');
                    }
                  },
                ),
              ],
              ListTile(
                title: const Text('Logout'),
                leading: const Icon(Icons.logout),
                onTap: () {
                  authModel.logoutUser();
                  messageModel.clearRecentMessages();
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            isLoading
                ? Scaffold(
                    backgroundColor: Theme.of(context).primaryColor,
                    body: const Center(child: CircularProgressIndicator()))
                : MessageScreen(
                    allMessages: allMessages,
                    scrollController: scrollController,
                  ),
            if (leaseAgreement != null &&
                leaseAgreement.signatures.isNotEmpty) ...[
              const ViewPaymentsScreen(),
              const ViewMaintenanceRequestsScreen(),
            ]
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dipose() {
    super.dispose();
    channel.sink.close();
    print('...closing socket.........');
  }

  @override
  void deactivate() {
    super.deactivate();
    channel.sink.close();
    var messageModel = context.read<MessageModelProvider>();
    messageModel.clearRecentMessages();
  }
}
