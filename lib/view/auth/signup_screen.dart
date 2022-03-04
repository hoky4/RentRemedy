import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Providers/api_service_provider.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _statusMessage = '';
  late Color _messageColor = Colors.black;
  final TextEditingController txtFirstName = TextEditingController();
  final TextEditingController txtLastName = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  late ApiServiceProvider apiService;
  bool isLoading = false;

  @override
  void initState() {
    apiService = Provider.of<ApiServiceProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(36),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      titleLogo(),
                      const SizedBox(height: 25),
                      statusMessage(),
                      firstNameInput(),
                      lastNameInput(),
                      emailInput(),
                      passwordInput(),
                      signupButton(),
                      Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: isLoading,
                          child: const CircularProgressIndicator()),
                      showLoginButton(),
                    ],
                  ))),
        ));
  }

  Widget titleLogo() {
    return Text(
      "Signup",
      style: GoogleFonts.pacifico(
          fontWeight: FontWeight.bold, fontSize: 75, color: Colors.white),
    );
  }

  Widget statusMessage() {
    return Text(
      _statusMessage,
      style: TextStyle(
          fontSize: 16, color: _messageColor, fontWeight: FontWeight.bold),
    );
  }

  Widget firstNameInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: TextFormField(
          controller: txtFirstName,
          validator: (text) => text!.isEmpty ? 'First Name is required' : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'First Name',
            icon: const Icon(Icons.person),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.blue)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red)),
          ),
        ),
      ),
    );
  }

  Widget lastNameInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: TextFormField(
          controller: txtLastName,
          validator: (text) => text!.isEmpty ? 'Last Name is required' : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Last Name',
            icon: const Icon(Icons.person),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.blue)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red)),
          ),
        ),
      ),
    );
  }

  Widget emailInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: TextFormField(
          controller: txtEmail,
          validator: (text) => text!.isEmpty ? 'Email is required' : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Email',
            icon: const Icon(Icons.email),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.blue)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red)),
          ),
        ),
      ),
    );
  }

  Widget passwordInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: TextFormField(
          obscureText: true,
          controller: txtPassword,
          validator: (text) => text!.isEmpty ? 'Password is required' : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Password',
            icon: const Icon(Icons.lock),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.blue)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red)),
          ),
        ),
      ),
    );
  }

  Widget signupButton() {
    return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Container(
            height: 60,
            width: 150,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
              ),
              child: const Text(
                'Sign up',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    setState(() {
                      isLoading = true;
                    });
                    await apiService.signup(txtFirstName.text, txtLastName.text,
                        txtEmail.text, txtPassword.text);

                    setState(() {
                      _statusMessage = 'Signup Success';
                      _messageColor = Colors.green;
                      isLoading = false;
                    });

                    Navigator.pop(context);
                  } on Exception catch (e) {
                    setState(() {
                      _statusMessage = e.toString();
                      _messageColor = Colors.red;
                      isLoading = false;
                    });
                  }
                } else {
                  print('Missing required fields');
                }
              },
            )));
  }

  Widget showLoginButton() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(65, 20, 0, 0),
        child: Row(children: [
          const Text(
            'Already have Account ? ',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
        ]));
  }

  @override
  void dispose() {
    txtFirstName.dispose();
    txtLastName.dispose();
    txtEmail.dispose();
    txtPassword.dispose();
    super.dispose();
  }
}
