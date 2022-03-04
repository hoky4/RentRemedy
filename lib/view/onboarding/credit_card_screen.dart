import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Model/Auth/logged_in_user.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/Providers/api_service_provider.dart';
import 'package:rentremedy_mobile/Providers/auth_model_provider.dart';

class CreditCardScreen extends StatefulWidget {
  LeaseAgreement signedLeaseAgreement;
  CreditCardScreen({Key? key, required this.signedLeaseAgreement})
      : super(key: key);

  @override
  _CreditCardScreenState createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late ApiServiceProvider apiServiceProvider;
  bool isLoading = false;

  @override
  void initState() {
    apiServiceProvider =
        Provider.of<ApiServiceProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authModel = context.read<AuthModelProvider>();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text("Credit Collection")),
      body: SafeArea(
        child: Column(children: <Widget>[
          CreditCardWidget(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: isCvvFocused,
            obscureCardNumber: true,
            obscureCardCvv: true,
            animationDuration: const Duration(milliseconds: 1000),
            onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
          ),
          const Text("Enter credit card information to continue.",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white)),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CreditCardForm(
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    onCreditCardModelChange: onCreditCardModelChange,
                    themeColor: Colors.blue,
                    formKey: formKey,
                    textColor: Colors.white,
                    cardNumberDecoration: InputDecoration(
                      hintText: 'xxxx xxxx xxxx xxxx',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      border: const OutlineInputBorder(),
                      labelText: 'Card Number',
                      labelStyle: const TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.blue)),
                    ),
                    expiryDateDecoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Expired Date',
                      labelStyle: const TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      hintText: 'xx/xx',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.blue)),
                    ),
                    cvvCodeDecoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'CVV',
                      labelStyle: const TextStyle(color: Colors.white),
                      hintText: 'xxx',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.blue)),
                    ),
                    cardHolderDecoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Card Holder',
                      labelStyle: const TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.blue)),
                    ),
                  ),
                  Visibility(
                      maintainSize: false,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: isLoading,
                      child: const CircularProgressIndicator()),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          primary: const Color(0xff1b447b)),
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'halter',
                            fontSize: 14,
                            package: 'flutter_credit_card',
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            setState(() {
                              isLoading = true;
                            });
                            await apiServiceProvider.makeSetupIntent(cardNumber,
                                expiryDate, cvvCode, cardHolderName);
                            setState(() {
                              isLoading = false;
                            });
                            // Update with a signed lease agreement
                            LoggedInUser? user = authModel.user;
                            if (user != null) {
                              user.leaseAgreement = widget.signedLeaseAgreement;
                              authModel.loginUser(user);

                              Navigator.pushReplacementNamed(context, '/chat');
                            }
                          } on Exception catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Problem creating a setup intent: ${e.toString()}")));
                            print(
                                "Problem creating a setup intent: ${e.toString()}");
                          }
                        } else {
                          print('Invalid Entries');
                        }
                      })
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
