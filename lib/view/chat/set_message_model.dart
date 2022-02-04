import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/models/Message/message_model.dart';

import 'message_socket_handler.dart';

class SetMessageModel extends StatelessWidget {
  const SetMessageModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MessageModel(),
      child: MessageSocketHandler(),
    );
  }
}
