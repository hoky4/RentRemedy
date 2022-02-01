import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/models/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/models/User/user.dart';
import 'package:rentremedy_mobile/networking/api_exception.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';
import 'package:rentremedy_mobile/view/auth/signup_screen.dart';
import 'package:rentremedy_mobile/view/onboarding/terms_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../chat/message_screen.dart';
import '../onboarding/confirmation_screen.dart';

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
  late ApiService apiService;

  @override
  void initState() {
    apiService = Provider.of<ApiService>(context, listen: false);
    super.initState();
  }

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
                    Visibility(
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: isLoading,
                        child: CircularProgressIndicator()),
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
      _statusMessage,
      style: TextStyle(
          fontSize: 16, color: _messageColor, fontWeight: FontWeight.bold),
    );
  }

  Padding emailInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
                setState(() {
                  isLoading = true;
                });
                User? user =
                    await apiService.login(txtEmail.text, txtPassword.text);
                LeaseAgreement? leaseAgreement =
                    await _findLeaseAgreementById();
                bool hasLeaseAgreement = leaseAgreement != null ? true : false;

                setState(() {
                  _statusMessage = 'Login Success';
                  _messageColor = Colors.green;
                  isLoading = false;
                });

                if (hasLeaseAgreement) {
                  if (isSigned(leaseAgreement)) {
                    await apiService.getConversation();

                    Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => MessageScreen(user: user!)));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Lease Agreement not signed yet.")));
                    Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                TermsScreen(leaseAgreement: leaseAgreement)));
                  }
                } else {
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => ConfirmationScreen()));
                }
                apiService.connectToWebSocket();
                print('Connected to websocket.');
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
              } on TimeoutException catch (e) {
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
                  new MaterialPageRoute(builder: (context) => SignupScreen()));
            },
            child: Text(
              'Signup',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
        ]));
  }

  Future<LeaseAgreement?> _findLeaseAgreementById() async {
    final prefs = await SharedPreferences.getInstance();
    final id = (prefs.getString('id') ?? '');
    var leaseAgreement = await apiService.findExistingLeaseAgreements(id);
    // return leaseAgreement != null ? Tuple2<bool, LeaseAgreement>(true, leaseAgreement) : const Tuple2<bool, LeaseAgreement?>(false, null);
    return leaseAgreement;
  }

  bool isSigned(LeaseAgreement leaseAgreement) {
    if (leaseAgreement.signatures.isEmpty) {
      print("Existing Lease Agreement Not signed.");
      return false;
    }
    print("Existing Lease Agreement Signed.");

    return true;
  }

  @override
  void dispose() {
    txtEmail.dispose();
    txtPassword.dispose();
    super.dispose();
  }
}
