import 'package:flutter/material.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  final _formKey = GlobalKey<FormState>();
  ApiService apiService = ApiService();
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
                  TextFormField(
                      controller: txtCode,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Enter Confirmation Code',
                          icon: Icon(Icons.lock)),
                      validator: (text) =>
                          text!.isEmpty ? 'Code is required' : null),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO: get lease agreement
                      }
                    },
                    child: Text('Submit'),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
