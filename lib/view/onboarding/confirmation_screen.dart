import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/status.dart';
import 'package:rentremedy_mobile/Providers/api_service_provider.dart';
import 'package:rentremedy_mobile/Providers/auth_model_provider.dart';
import 'package:rentremedy_mobile/Providers/message_model_provider.dart';
import 'join_screen.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController txtCode = TextEditingController();
  late ApiServiceProvider apiService;

  String _statusMessage = '';
  late Color _messageColor = Colors.black;
  bool isLoading = false;

  @override
  void initState() {
    apiService = Provider.of<ApiServiceProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var messageModel = context.watch<MessageModelProvider>();
    var authModel = context.read<AuthModelProvider>();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        centerTitle: true,
        title: const Text('Confirmation'),
        // automaticallyImplyLeading: false,
        // leading: IconButton(
        //   icon: const Icon(Icons.logout),
        //   onPressed: () {
        //     authModel.logoutUser();
        //     messageModel.clearRecentMessages();
        //     Navigator.pushReplacementNamed(context, '/login');
        //   },
        //   color: Colors.white,
        // ),
      ),
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
            ListTile(
              title: const Text('Lease Agreement'),
              leading: const Icon(Icons.document_scanner),
              onTap: () {
                Navigator.pushNamed(context, '/viewLeaseAgreements');
              },
            ),
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
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(36),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 150),
                  const Text(
                    "You will receive a confirmation code in your email after applying and being accepted to a rent remedy property.",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  statusMessage(),
                  confirmationInput(),
                  Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: isLoading,
                      child: const CircularProgressIndicator()),
                  submitButton(context),
                ],
              ),
            )),
      ),
    );
  }

  Widget submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          try {
            setState(() {
              isLoading = true;
            });
            LeaseAgreement? leaseAgreement =
                await apiService.getLeaseAgreement(txtCode.text);

            setState(() {
              isLoading = false;
            });

            if (leaseAgreement != null) {
              if (leaseAgreement.status == Status.Inactive) {
                setState(() {
                  _statusMessage = "Property is not connected.";
                  _messageColor = Colors.red;
                  isLoading = false;
                });
                return;
              } else if (leaseAgreement.status == Status.Unassigned) {
                Navigator.pushReplacementNamed(context, '/join',
                    arguments: JoinScreenArguments(leaseAgreement));
              }
            }
          } on Exception catch (e) {
            setState(() {
              _statusMessage = e.toString();
              _messageColor = Colors.red;
              isLoading = false;
            });
          }
        }
      },
      child: const Text('Submit'),
    );
  }

  Widget confirmationInput() {
    return TextFormField(
        controller: txtCode,
        keyboardType: TextInputType.text,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: 'Enter Confirmation Code',
            hintStyle: TextStyle(color: Colors.grey.shade400),
            icon: const Icon(Icons.lock)),
        validator: (text) => text!.isEmpty ? 'Code is required' : null);
  }

  Widget statusMessage() {
    return Text(
      _statusMessage,
      style: TextStyle(
          fontSize: 16, color: _messageColor, fontWeight: FontWeight.bold),
    );
  }

  @override
  void dispose() {
    txtCode.dispose();
    super.dispose();
  }
}
