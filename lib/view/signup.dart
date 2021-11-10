import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController txtFirstName = TextEditingController();
  final TextEditingController txtLastName = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  bool _isSignup = true;
  late String _message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_isSignup ? 'Sign up Screen' : 'Log in Screen'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                _message = 'User Logged Out';
              },
            ),
          ],
        ),
        body: Container(
            padding: EdgeInsets.all(36),
            child: ListView(
              children: [
                Visibility(child: firstNameInput(), visible: _isSignup),
                Visibility(child: lastNameInput(), visible: _isSignup),
                emailInput(),
                passwordInput(),
                btnSignup(),
                btnSecondary(),
              ],
            )));
  }

  Row btnSecondary() {
    String buttonText = _isSignup ? 'Log in' : 'Sign up';
    String prompt =
        _isSignup ? "Already have an account? " : "Don't have an account? ";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(prompt),
        TextButton(
          child: Text(buttonText),
          style: TextButton.styleFrom(
            textStyle: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            setState(() {
              _isSignup = !_isSignup;
            });
          },
        ),
      ],
    );
  }

  Widget firstNameInput() {
    return Padding(
        padding: EdgeInsets.only(top: 24),
        child: TextFormField(
          controller: txtFirstName,
          keyboardType: TextInputType.name,
          decoration:
              InputDecoration(hintText: 'First Name', icon: Icon(Icons.person)),
          validator: (text) => text!.isEmpty ? 'First Name is required' : '',
        ));
  }

  Widget lastNameInput() {
    return Padding(
        padding: EdgeInsets.only(top: 24),
        child: TextFormField(
          controller: txtLastName,
          keyboardType: TextInputType.name,
          decoration:
              InputDecoration(hintText: 'Last Name', icon: Icon(Icons.person)),
          validator: (text) => text!.isEmpty ? 'Last Name is required' : '',
        ));
  }

  Widget emailInput() {
    return Padding(
        padding: EdgeInsets.only(top: 24),
        child: TextFormField(
          controller: txtEmail,
          keyboardType: TextInputType.emailAddress,
          decoration:
              InputDecoration(hintText: 'Email', icon: Icon(Icons.email)),
          validator: (text) => text!.isEmpty ? 'Email is required' : '',
        ));
  }

  Widget passwordInput() {
    return Padding(
        padding: EdgeInsets.only(top: 24),
        child: TextFormField(
          controller: txtPassword,
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration:
              InputDecoration(hintText: 'Password', icon: Icon(Icons.lock)),
          validator: (text) => text!.isEmpty ? 'Password is required' : '',
        ));
  }

  Widget btnSignup() {
    String btnText = _isSignup ? 'Sign up' : 'Log in';
    return Padding(
        padding: EdgeInsets.only(top: 48),
        child: Container(
            height: 60,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      side: BorderSide(color: Colors.red)),
                ),
              ),
              child: Text(
                btnText,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onPressed: () {
                String userId = '';
              },
            )));
  }
}
