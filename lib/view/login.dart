import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentremedy_mobile/models/user.dart';
import 'package:rentremedy_mobile/networking/api_exception.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';
import 'package:rentremedy_mobile/view/signup.dart';
import 'package:rentremedy_mobile/view/success_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _message = '';
  late Color _messageColor = Colors.black;
  User user = User('', '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: SingleChildScrollView(
          child: Container(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100),
                    titleLogo(),
                    SizedBox(height: 25),
                    statusMessage(),
                    emailInput(),
                    passwordInput(),
                    loginButton(),
                    showSignupButton(),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget titleLogo() {
    return Text(
      "Login",
      style: GoogleFonts.pacifico(
          fontWeight: FontWeight.bold, fontSize: 50, color: Colors.black),
    );
  }

  Widget statusMessage() {
    return Text(
      _message,
      style: TextStyle(
          fontSize: 16, color: _messageColor, fontWeight: FontWeight.bold),
    );
  }

  Padding emailInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: TextEditingController(text: user.email),
        onChanged: (value) {
          user.email = value;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Email is required';
          } else if (RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            return null;
          } else {
            return 'Enter valid email';
          }
        },
        decoration: InputDecoration(
          hintText: 'Enter Email',
          icon: Icon(Icons.email),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.blue)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.red)),
        ),
      ),
    );
  }

  Padding passwordInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: TextEditingController(text: user.password),
        onChanged: (value) {
          user.password = value;
        },
        obscureText: true,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Password is required';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: 'Enter Password',
          icon: Icon(Icons.lock),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.blue)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.red)),
        ),
      ),
    );
  }

  Widget loginButton() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        height: 50,
        width: 400,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(8.0),
            primary: Colors.white,
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                ApiService apiService = ApiService();
                await apiService.login(user.email, user.password);

                setState(() {
                  _message = 'Login Success';
                  _messageColor = Colors.green;
                });
                await Future.delayed(Duration(seconds: 1));
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => SuccessScreen()));
              } on BadRequestException catch (e) {
                print('error-msg: ${e.toString()}');
                setState(() {
                  _message = 'Bad Request.';
                  _messageColor = Colors.red;
                });
              }
            } else {
              print('Missing required fields');
            }
          },
          child: const Text('Login'),
        ),
      ),
    );
  }

  Widget showSignupButton() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(65, 20, 0, 0),
        child: Row(children: [
          Text(
            "Don't have Account ? ",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => Signup()));
            },
            child: Text(
              'Signup',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
        ]));
  }
}
