import 'package:flutter/material.dart';
import 'package:rentremedy_mobile/models/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/models/LeaseAgreement/status.dart';
import 'package:rentremedy_mobile/networking/api_exception.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';

import 'join_screen.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _statusMessage = '';
  late Color _messageColor = Colors.black;
  ApiService apiService = ApiService();
  bool isLoading = false;
  final TextEditingController txtCode = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(36),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 200),
                  statusMessage(),
                  TextFormField(
                      controller: txtCode,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Enter Confirmation Code',
                          icon: Icon(Icons.lock)),
                      validator: (text) =>
                          text!.isEmpty ? 'Code is required' : null),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          setState(() {
                            isLoading = true;
                          });
                          LeaseAgreement? leaseAgreement =
                              await apiService.getLeaseAgreement(txtCode.text);
                          //TODO: navigate to validate_screen
                          setState(() {
                            isLoading = false;
                          });
                          if (leaseAgreement != null && leaseAgreement.status == Status.Unassigned) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JoinScreen(
                                          leaseAgreement: leaseAgreement,
                                        )));
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
                    child: Text('Submit'),
                  ),
                  Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: isLoading,
                      child: CircularProgressIndicator()),
                ],
              ),
            )),
      ),
    );
  }

  Widget statusMessage() {
    return Text(
      _statusMessage,
      style: TextStyle(
          fontSize: 16, color: _messageColor, fontWeight: FontWeight.bold),
    );
  }
}
