import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/status.dart';
import 'package:rentremedy_mobile/Networking/api_exception.dart';
import 'package:rentremedy_mobile/Providers/api_service_provider.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(36),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 200),
                  const Text("Enter the ID from the email.",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                  statusMessage(),
                  confirmationInput(),
                  submitButton(context),
                  Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: isLoading,
                      child: const CircularProgressIndicator()),
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
          } on BadRequestException catch (e) {
            setState(() {
              _statusMessage = e.toString();
              _messageColor = Colors.red;
              isLoading = false;
            });
          } on UnauthorizedException catch (e) {
            setState(() {
              _statusMessage = e.toString();
              _messageColor = Colors.red;
              isLoading = false;
            });
          } on NotFoundException catch (e) {
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
        decoration: const InputDecoration(
            hintText: 'Enter Confirmation Code', icon: Icon(Icons.lock)),
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
