import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Model/Auth/logged_in_user.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/Providers/api_service_provider.dart';
import 'package:rentremedy_mobile/Providers/auth_model_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _statusMessage = '';
  late Color _messageColor = Colors.black;
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  bool isLoading = false;
  var hasLeaseAgreement = false;
  late ApiServiceProvider apiService;

  @override
  void initState() {
    apiService = Provider.of<ApiServiceProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
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
                    const SizedBox(height: 75),
                    titleLogo(),
                    const SizedBox(height: 25),
                    statusMessage(),
                    emailInput(),
                    passwordInput(),
                    loginButton(),
                    Visibility(
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: isLoading,
                        child: const CircularProgressIndicator()),
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
        textStyle: Theme.of(context).textTheme.bodyText1,
        fontWeight: FontWeight.bold,
        fontSize: 75,
        color: Colors.white,
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

  Padding emailInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: TextFormField(
          controller: txtEmail,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Email is required';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Enter Email',
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

  Padding passwordInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: TextFormField(
          controller: txtPassword,
          obscureText: true,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Password is required';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Enter Password',
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

  Widget loginButton() {
    var authModel = context.read<AuthModelProvider>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 60,
        width: 150,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              // backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  setState(() {
                    isLoading = true;
                  });
                  LoggedInUser user =
                      await apiService.login(txtEmail.text, txtPassword.text);

                  LeaseAgreement? leaseAgreement =
                      await apiService.findExistingLeaseAgreements(user);

                  if (leaseAgreement != null) {
                    user.leaseAgreement = leaseAgreement;
                  }

                  authModel.loginUser(user);

                  Navigator.pushReplacementNamed(context, '/');

                  setState(() {
                    _statusMessage = 'Login Success';
                    _messageColor = Colors.green;
                    isLoading = false;
                  });
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
            child: const Text('Login',
                style: TextStyle(fontSize: 18, color: Colors.white))),
      ),
    );
  }

  Widget showSignupButton() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(65, 20, 0, 0),
        child: Row(children: [
          const Text(
            "Don't have Account ? ",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/signup');
            },
            child: const Text(
              'Signup',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
        ]));
  }

  @override
  void dispose() {
    txtEmail.dispose();
    txtPassword.dispose();
    super.dispose();
  }
}
