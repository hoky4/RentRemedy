import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Model/Auth/logged_in_user.dart';
import 'package:rentremedy_mobile/Model/Fees/due_date_type.dart';
import 'package:rentremedy_mobile/Model/Fees/monthly_fees.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/amenity.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/maintenance.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/one_time_security_deposit.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/termination_info.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/utility.dart';
import 'package:rentremedy_mobile/Model/Property/property.dart';
import 'package:rentremedy_mobile/Model/Review/review_status.dart';
import 'package:rentremedy_mobile/Providers/api_service_provider.dart';
import 'package:rentremedy_mobile/Providers/auth_model_provider.dart';
import '../../Model/LeaseAgreement/status.dart';
import '../../Model/Review/review.dart';
import 'join_screen.dart';
import 'package:rating_dialog/rating_dialog.dart';

class TermsScreen extends StatefulWidget {
  final LeaseAgreement leaseAgreement;
  const TermsScreen({Key? key, required this.leaseAgreement}) : super(key: key);

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
    var authModel = context.read<AuthModelProvider>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColorDark,
            title: const Text("Terms"),
            automaticallyImplyLeading: false,
            centerTitle: true,
            actions: [
              if (widget.leaseAgreement.signatures.isEmpty) ...[
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white70,
                  ),
                  onPressed: () {
                    // Update with a unsigned lease agreement
                    LoggedInUser? user = authModel.user;
                    if (user != null) {
                      user.leaseAgreement = widget.leaseAgreement;
                      authModel.loginUser(user);
                      Navigator.pushReplacementNamed(context, '/chat');
                    }
                  },
                  child: const Text('Sign Later'),
                ),
              ] else ...[
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white70,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ]),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    duration(widget.leaseAgreement.startDate,
                        widget.leaseAgreement.endDate),
                    const Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    monthlyFees(widget.leaseAgreement.monthlyFees),
                    const Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    address(widget.leaseAgreement.property),
                    const Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    deposit(widget.leaseAgreement.securityDeposit),
                    const Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    amenities(widget.leaseAgreement.amenitiesProvided),
                    const Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    utilitiesProvided(widget.leaseAgreement.utilitiesProvided),
                    const Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    maintenanceProvided(
                        widget.leaseAgreement.maintenanceProvided),
                    if (widget.leaseAgreement.signatures.isNotEmpty) ...[
                      const Divider(
                          thickness: 1, indent: 32, endIndent: 32, height: 48),
                      signedInfo(
                          widget.leaseAgreement.signatures.first.signDate),
                    ],
                    if (widget
                            .leaseAgreement.terminationInfo?.terminationDate !=
                        null) ...[
                      const Divider(
                          thickness: 1, indent: 32, endIndent: 32, height: 48),
                      terminationInfo(widget.leaseAgreement.terminationInfo!),
                    ],
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            if (widget.leaseAgreement.signatures.isEmpty) ...[
              Container(
                  width: double.infinity,
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColorDark),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          Padding(padding: const EdgeInsets.all(8.0),
                            child: acceptButton(context, widget.leaseAgreement.id)
                          ),
                          
                          const Spacer()
                        ],
                      ),
                      const Text(
                        "By selecting accept, I agree to the terms above.",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 4.0)
                    ],
                  )),
            ] else if (widget.leaseAgreement.terminationInfo?.terminationDate ==
                null) ...[
              Container(
                  width: double.infinity,
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColorDark),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          Padding(padding: const EdgeInsets.all(8.0),
                            child: terminateButton(context, widget.leaseAgreement.id),
                          ),
                          const Spacer()
                        ],
                      )
                    ],
                  )),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if ((widget.leaseAgreement.terminationInfo?.terminationDate != null ||
              widget.leaseAgreement.status == Status.Terminated ||
              widget.leaseAgreement.status == Status.Completed) &&
          widget.leaseAgreement.review?.status == ReviewStatus.Pending) {
        showRatingPromptAlert(context);
      }
    });
  }

  Widget terminationInfo(TerminationInfo info) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 0.0, 0, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Termination", style: categoryStyle),
            const SizedBox(height: 8.0),
            detailLine(
                "Terminated on: ",
                DateFormat.yMMMMd('en_US')
                    .format(info.terminationDate!.toLocal())),
            // Text("Terminated on ${DateFormat.yMMMMd('en_US').format(info.terminationDate!)}",
            //     style: bodyStyle),
            SizedBox(height: 4.0),
            detailLine("Reason: ", info.reason!),
            SizedBox(height: 4.0),
            detailLine("New Address: ", info.newAddress.toString())
          ],
        ),
      ),
    );
  }

  Widget signedInfo(DateTime signedDate) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 0.0, 0, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Signature", style: categoryStyle),
            const SizedBox(height: 8.0),
            detailLine("Signed on: ",
                DateFormat.yMMMMd('en_US').format(signedDate.toLocal())),
            // Text("Signed on ${DateFormat.yMMMMd('en_US').format(signedDate)}",
            //     style: bodyStyle),
          ],
        ),
      ),
    );
  }

  Widget terminateButton(BuildContext context, String leaseAgreemenId) {
    final _formKey = GlobalKey<FormState>();
    var authModel = context.read<AuthModelProvider>();

    ApiServiceProvider apiService =
        Provider.of<ApiServiceProvider>(context, listen: false);
    final TextEditingController txtReason = TextEditingController();
    final TextEditingController txtLine1 = TextEditingController();
    final TextEditingController txtLine2 = TextEditingController();
    final TextEditingController txtCity = TextEditingController();
    final TextEditingController txtState = TextEditingController();
    final TextEditingController txtZipCode = TextEditingController();

    return SizedBox(
      height: 60,
      width: 150,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red[800]),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
        ),
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext dialogContext) => AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text(
              'Complete before Terminating',
              style: TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: txtReason,
                      keyboardType: TextInputType.multiline,
                      minLines: 2,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Reason',
                        labelStyle: const TextStyle(color: Colors.white),
                        // hintText: 'Ex. Sink is leaking',
                        // hintStyle: TextStyle(color: Colors.grey.shade400),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Description is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32.0),
                    const Text(
                      "New Address",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: txtLine1,
                      decoration: InputDecoration(
                        labelText: 'Line 1',
                        labelStyle: const TextStyle(color: Colors.white),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Line1 is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: txtLine2,
                      decoration: InputDecoration(
                        labelText: 'Line 2',
                        labelStyle: const TextStyle(color: Colors.white),
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
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            controller: txtCity,
                            decoration: InputDecoration(
                              labelText: 'City',
                              labelStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      const BorderSide(color: Colors.blue)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'City is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            controller: txtState,
                            decoration: InputDecoration(
                              labelText: 'State',
                              labelStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      const BorderSide(color: Colors.blue)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'State is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: txtZipCode,
                      decoration: InputDecoration(
                        labelText: 'Zip Code',
                        labelStyle: const TextStyle(color: Colors.white),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Zip Code is required';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      LeaseAgreement leaseAgreement =
                          await apiService.terminateLeaseAgreement(
                              leaseAgreemenId,
                              txtReason.text,
                              txtLine1.text,
                              txtLine2.text,
                              txtCity.text,
                              txtState.text,
                              txtZipCode.text);
                      print('Lease agreement terminated');

                      final result = await Navigator.pushReplacementNamed(
                          context, '/terminateSuccess') as bool;
                      if (result) {
                        print('termination successful');
                        // Update with a unsigned lease agreement
                        LoggedInUser? user = authModel.user;
                        if (user != null) {
                          setState(() {
                            widget.leaseAgreement.terminationInfo =
                                leaseAgreement.terminationInfo;
                          });
                        }
                        showRatingPromptAlert(context);
                      }
                    } on Exception catch (e) {
                      print(
                          "Error terminating leaseAgreement: ${e.toString()}");
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }

                    // Navigator.pop(context, 'OK');
                  }
                },
                child: const Text('Confirm'),
              ),
            ],
          ),
        ),
        child: const Text('Terminate',
            style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  void showRatingPromptAlert(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext dialogContext) => AlertDialog(
              backgroundColor: Theme.of(context).primaryColor,
              title: const Text(
                'Would you like to review your landlord?',
                style: TextStyle(color: Colors.white),
              ),
              actions: <Widget>[noButton(context), yesButton(context)],
            ));
  }

  Widget yesButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
      ),
      onPressed: () async {
        Navigator.of(context).pop();
        showRatingAlert(context);
      },
      child: const Text(
        'Yes',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget noButton(BuildContext context) {
    ApiServiceProvider apiService =
        Provider.of<ApiServiceProvider>(context, listen: false);
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
      ),
      onPressed: () async {
        try {
          Review review = await apiService.submitReview(
              widget.leaseAgreement.review!.id,
              widget.leaseAgreement.tenant!.id,
              widget.leaseAgreement.landlord.id,
              0,
              "",
              ReviewStatus.Rejected);

          widget.leaseAgreement.review = review;

          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Review Rejected")));
          Navigator.of(context).pop();
        } on Exception catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }
      },
      child: const Text(
        'No',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  void showRatingAlert(BuildContext context) {
    ApiServiceProvider apiService =
        Provider.of<ApiServiceProvider>(context, listen: false);
    showDialog(
        context: context,
        builder: (dialogContext) => RatingDialog(
              initialRating: 1.0,
              // your app's name?
              title: const Text(
                'Review Landlord',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              message: const Text(
                'Tap a star to set your rating. Add more description here if you want.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
              // image: const FlutterLogo(size: 100),

              submitButtonText: 'Submit',
              commentHint: 'Description',
              onCancelled: () => print('cancelled'),
              onSubmitted: (response) async {
                try {
                  Review review = await apiService.submitReview(
                      widget.leaseAgreement.review!.id,
                      widget.leaseAgreement.tenant!.id,
                      widget.leaseAgreement.landlord.id,
                      response.rating.toInt(),
                      response.comment,
                      ReviewStatus.FilledOut);
                  widget.leaseAgreement.review = review;

                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Review Submitted")));
                } on Exception catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
            ));
  }

  Widget maintenanceProvided(List<Maintenance> maintenance) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Maintenance Provided", style: categoryStyle),
            const SizedBox(height: 8.0),
            ListView(
              primary: false,
              itemExtent: 32.0,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                for (Maintenance item in maintenance)
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/${item.toString().split('.').elementAt(1)}.png',
                      fit: BoxFit.cover,
                    ),
                    title: Align(
                      child: Text(item.value, style: bodyStyle2),
                      alignment: const Alignment(-1.2, 0),
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget utilitiesProvided(List<Utility> utilities) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Utilities Provided", style: categoryStyle),
            const SizedBox(height: 8.0),
            ListView(
              primary: false,
              itemExtent: 32.0,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                for (Utility item in utilities)
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/${item.toString().split('.').elementAt(1)}.png',
                      fit: BoxFit.cover,
                    ),
                    title: Align(
                      child: Text(item.value, style: bodyStyle2),
                      alignment: const Alignment(-1.2, 0),
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget amenities(List<Amenity> amenities) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Amenities",
              style: categoryStyle,
            ),
            const SizedBox(height: 8.0),
            ListView(
              primary: false,
              itemExtent: 32.0,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                for (Amenity item in amenities)
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/${item.toString().split('.').elementAt(1)}.png',
                      fit: BoxFit.cover,
                    ),
                    title: Align(
                      child: Text(
                        item.value,
                        style: bodyStyle2,
                      ),
                      alignment: const Alignment(-1.2, 0),
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget deposit(OneTimeSecurityDeposit securityDeposit) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("One Time Security Deposit", style: categoryStyle),
            const SizedBox(height: 8.0),
            detailLine("Deposit Amount: ",
                "\$${convertToDollar(securityDeposit.depositAmount)}"),
            const SizedBox(height: 8.0),
            detailLine("Refund Amount: ",
                "\$${convertToDollar(securityDeposit.refundAmount)}"),
            const SizedBox(height: 8.0),
            detailLine(
                "Due Date: ",
                DateFormat.yMMMMd('en_US')
                    .format(securityDeposit.dueDate.toLocal())),
          ],
        ),
      ),
    );
  }

  Widget address(Property? property) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Address", style: categoryStyle),
            const SizedBox(height: 8.0),
            property != null
                ? detailLine("", property.toString())
                : detailLine("", "No property assigned")
          ],
        ),
      ),
    );
  }

  Widget monthlyFees(MonthlyFees monthlyFees) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Monthly Fees", style: categoryStyle),
            const SizedBox(height: 8.0),
            detailLine("Rent Fee: ",
                "\$${convertToDollar(monthlyFees.rentFee.rentFeeAmount)}"),
            const SizedBox(height: 4.0),
            detailLine("Pet Fee: ",
                "\$${convertToDollar(monthlyFees.petFee.petFeeAmount)}"),
            const SizedBox(height: 4.0),
            dueDateCondition(monthlyFees),
            const SizedBox(height: 4.0),
            detailLine(
                "Late Fee: ", "\$${convertToDollar(monthlyFees.lateFee)}"),
            const SizedBox(height: 4.0),
            detailLine("Grace Period: ", "${monthlyFees.gracePeriod} days"),
          ],
        ),
      ),
    );
  }

  Widget dueDateCondition(MonthlyFees monthlyFees) {
    switch (monthlyFees.dueDateType) {
      case DueDateType.StartOfMonth:
        return detailLine("Due Date: ", monthlyFees.dueDateType.value);
      case DueDateType.EndOfMonth:
        return detailLine("Due Date: ", monthlyFees.dueDateType.value);
      case DueDateType.DayOfMonth:
        return detailLine("Due Date: ",
            "${DateFormat.yMMMMd('en_US').format(monthlyFees.dueDate!.toLocal())} *(or end of month)");
      default:
        return Text("Not avaliable.", style: bodyStyle);
    }
  }

  Widget duration(DateTime startDate, DateTime endDate) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 24.0, 0, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Duration", style: categoryStyle),
            const SizedBox(height: 8.0),
            detailLine("",
                "${DateFormat.yMMMMd('en_US').format(startDate.toLocal())} to ${DateFormat.yMMMMd('en_US').format(endDate.toLocal())}"),
          ],
        ),
      ),
    );
  }

  Widget acceptButton(BuildContext context, String leaseAgreemenId) {
    ApiServiceProvider apiService =
        Provider.of<ApiServiceProvider>(context, listen: false);

    return SizedBox(
      height: 60,
      width: 150,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
        ),
        onPressed: () async {
          try {
            LeaseAgreement leaseAgreement =
                await apiService.signLeaseAgreement(leaseAgreemenId);
            print('Lease agreement signed');

            Navigator.pushReplacementNamed(context, '/creditCard',
                arguments: JoinScreenArguments(leaseAgreement));
          } on Exception catch (e) {
            print(
                "Error signing leaseAgreement or setting up card payment: ${e.toString()}");
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
        },
        child: const Text('Accept',
            style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  String convertToDollar(amount) {
    final value = amount / 100;
    final money = NumberFormat("###,###,###", "en_us");
    return money.format(value);
  }

  Widget detailLine(String title, String detail) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text("$title", style: bodyStyleBold),
        Flexible(child: Text(detail, style: bodyStyle)),
      ],
    );
  }
}

// class TermsScreen extends StatelessWidget {
//   final LeaseAgreement leaseAgreement;

//   TermsScreen({Key? key, required this.leaseAgreement}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var authModel = context.read<AuthModelProvider>();

//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//             backgroundColor: Theme.of(context).primaryColorDark,
//             title: const Text("Terms"),
//             automaticallyImplyLeading: false,
//             centerTitle: true,
//             actions: [
//               if (leaseAgreement.signatures.isEmpty) ...[
//                 TextButton(
//                   style: TextButton.styleFrom(
//                     primary: Colors.white70, // foreground
//                   ),
//                   onPressed: () {
//                     // Update with a unsigned lease agreement
//                     LoggedInUser? user = authModel.user;
//                     if (user != null) {
//                       user.leaseAgreement = leaseAgreement;
//                       authModel.loginUser(user);
//                       Navigator.pushReplacementNamed(context, '/chat');
//                     }
//                   },
//                   child: const Text('Sign Later'),
//                 ),
//               ] else ...[
//                 TextButton(
//                   style: TextButton.styleFrom(
//                     primary: Colors.white70, // foreground
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Icon(Icons.close),
//                 ),
//               ],
//             ]),
//         body: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     duration(leaseAgreement.startDate, leaseAgreement.endDate),
//                     const Divider(
//                         thickness: 1, indent: 32, endIndent: 32, height: 48),
//                     monthlyFees(leaseAgreement.monthlyFees),
//                     const Divider(
//                         thickness: 1, indent: 32, endIndent: 32, height: 48),
//                     address(leaseAgreement.property),
//                     const Divider(
//                         thickness: 1, indent: 32, endIndent: 32, height: 48),
//                     deposit(leaseAgreement.securityDeposit),
//                     const Divider(
//                         thickness: 1, indent: 32, endIndent: 32, height: 48),
//                     amenities(leaseAgreement.amenitiesProvided),
//                     const Divider(
//                         thickness: 1, indent: 32, endIndent: 32, height: 48),
//                     utilitiesProvided(leaseAgreement.utilitiesProvided),
//                     const Divider(
//                         thickness: 1, indent: 32, endIndent: 32, height: 48),
//                     maintenanceProvided(leaseAgreement.maintenanceProvided),
//                     const SizedBox(height: 24),
//                     if (leaseAgreement.signatures.isNotEmpty) ...[
//                       const Divider(
//                           thickness: 1, indent: 32, endIndent: 32, height: 48),
//                       signedInfo(leaseAgreement.signatures.first.signDate),
//                       const SizedBox(height: 24),
//                     ]
//                   ],
//                 ),
//               ),
//             ),
//             if (leaseAgreement.signatures.isEmpty) ...[
//               Container(
//                   // alignment: Alignment.center,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       color: Theme.of(context)
//                           .primaryColorDark), //Colors.black12),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           const Spacer(),
//                           acceptButton(context, leaseAgreement.id),
//                           const Spacer()
//                         ],
//                       ),
//                       const Text(
//                         "By selecting accept, I agree to the terms above.",
//                         style: TextStyle(color: Colors.white),
//                       )
//                     ],
//                   )),
//             ] else ...[
//               //TODO: check condition on terminated Date
//               Container(
//                   // alignment: Alignment.center,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       color: Theme.of(context)
//                           .primaryColorDark), //Colors.black12),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           const Spacer(),
//                           terminateButton(context, leaseAgreement.id),
//                           const Spacer()
//                         ],
//                       )
//                     ],
//                   )),
//             ],
//           ],
//         ),
//       ),
//     );
//   }

//   Widget signedInfo(DateTime signedDate) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(32.0, 24.0, 0, 0),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Signed on ${DateFormat.yMMMMd('en_US').format(signedDate)}",
//                 style: bodyStyle),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget terminateButton(BuildContext context, String leaseAgreemenId) {
//     final _formKey = GlobalKey<FormState>();
//     var authModel = context.read<AuthModelProvider>();

//     ApiServiceProvider apiService =
//         Provider.of<ApiServiceProvider>(context, listen: false);
//     final TextEditingController txtReason = TextEditingController();
//     final TextEditingController txtLine1 = TextEditingController();
//     final TextEditingController txtLine2 = TextEditingController();
//     final TextEditingController txtCity = TextEditingController();
//     final TextEditingController txtState = TextEditingController();
//     final TextEditingController txtZipCode = TextEditingController();

//     return SizedBox(
//       height: 60,
//       width: 150,
//       child: ElevatedButton(
//         style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.all(Colors.red[800]),
//           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(24.0),
//             ),
//           ),
//         ),
//         onPressed: () => showDialog<String>(
//           context: context,
//           builder: (BuildContext context) => AlertDialog(
//             backgroundColor: Theme.of(context).primaryColor,
//             title: const Text(
//               'Complete before Terminating',
//               style: TextStyle(color: Colors.white),
//             ),
//             content: SingleChildScrollView(
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       style: const TextStyle(color: Colors.white),
//                       controller: txtReason,
//                       keyboardType: TextInputType.multiline,
//                       minLines: 2,
//                       maxLines: 5,
//                       decoration: InputDecoration(
//                         labelText: 'Reason',
//                         labelStyle: const TextStyle(color: Colors.white),
//                         // hintText: 'Ex. Sink is leaking',
//                         // hintStyle: TextStyle(color: Colors.grey.shade400),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(color: Colors.grey)),
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(color: Colors.blue)),
//                         errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(color: Colors.red)),
//                         focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(color: Colors.red)),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Description is required';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 32.0),
//                     const Text(
//                       "New Address",
//                       style: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                     TextFormField(
//                       style: const TextStyle(color: Colors.white),
//                       controller: txtLine1,
//                       decoration: InputDecoration(
//                         labelText: 'Line 1',
//                         labelStyle: const TextStyle(color: Colors.white),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(color: Colors.grey)),
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(color: Colors.blue)),
//                         errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(color: Colors.red)),
//                         focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(color: Colors.red)),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Line1 is required';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16.0),
//                     TextFormField(
//                       style: const TextStyle(color: Colors.white),
//                       controller: txtLine2,
//                       decoration: InputDecoration(
//                         labelText: 'Line 2',
//                         labelStyle: const TextStyle(color: Colors.white),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(color: Colors.grey)),
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(color: Colors.blue)),
//                         errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(color: Colors.red)),
//                         focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(color: Colors.red)),
//                       ),
//                       // validator: (value) {
//                       //   if (value == null || value.isEmpty) {
//                       //     return 'Line2 is required';
//                       //   }
//                       //   return null;
//                       // },
//                     ),
//                     const SizedBox(height: 16.0),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextFormField(
//                             style: const TextStyle(color: Colors.white),
//                             controller: txtCity,
//                             decoration: InputDecoration(
//                               labelText: 'City',
//                               labelStyle: const TextStyle(color: Colors.white),
//                               enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(16),
//                                   borderSide:
//                                       const BorderSide(color: Colors.grey)),
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(16),
//                                   borderSide:
//                                       const BorderSide(color: Colors.blue)),
//                               errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(16),
//                                   borderSide:
//                                       const BorderSide(color: Colors.red)),
//                               focusedErrorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(16),
//                                   borderSide:
//                                       const BorderSide(color: Colors.red)),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'City is required';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 8.0,
//                         ),
//                         Expanded(
//                           child: TextFormField(
//                             style: const TextStyle(color: Colors.white),
//                             controller: txtState,
//                             decoration: InputDecoration(
//                               labelText: 'State',
//                               labelStyle: const TextStyle(color: Colors.white),
//                               enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(16),
//                                   borderSide:
//                                       const BorderSide(color: Colors.grey)),
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(16),
//                                   borderSide:
//                                       const BorderSide(color: Colors.blue)),
//                               errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(16),
//                                   borderSide:
//                                       const BorderSide(color: Colors.red)),
//                               focusedErrorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(16),
//                                   borderSide:
//                                       const BorderSide(color: Colors.red)),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'State is required';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16.0),
//                     TextFormField(
//                       style: const TextStyle(color: Colors.white),
//                       controller: txtZipCode,
//                       decoration: InputDecoration(
//                         labelText: 'Zip Code',
//                         labelStyle: const TextStyle(color: Colors.white),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(color: Colors.grey)),
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(color: Colors.blue)),
//                         errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(color: Colors.red)),
//                         focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(color: Colors.red)),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Zip Code is required';
//                         }
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () => Navigator.pop(context, 'Cancel'),
//                 child: const Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     try {
//                       LeaseAgreement leaseAgreement =
//                           await apiService.terminateLeaseAgreement(
//                               leaseAgreemenId,
//                               txtReason.text,
//                               txtLine1.text,
//                               txtLine2.text,
//                               txtCity.text,
//                               txtState.text,
//                               txtZipCode.text);
//                       print('Lease agreement terminated');

//                       final result = await Navigator.pushReplacementNamed(
//                           context, '/terminateSuccess') as bool;
//                       if (result) {
//                         print('termination successful');
//                         // Update with a unsigned lease agreement
//                         LoggedInUser? user = authModel.user;
//                         if (user != null) {
//                           user.leaseAgreement = leaseAgreement;
//                         }
//                       }
//                     } on Exception catch (e) {
//                       print(
//                           "Error terminating leaseAgreement: ${e.toString()}");
//                       ScaffoldMessenger.of(context)
//                           .showSnackBar(SnackBar(content: Text(e.toString())));
//                     }

//                     // Navigator.pop(context, 'OK');
//                   }
//                 },
//                 child: const Text('Confirm'),
//               ),
//             ],
//           ),
//         ),
//         // onPressed: () async {
//         //   try {
//         //     // LeaseAgreement leaseAgreement =
//         //     //     await apiService.terminateLeaseAgreement(leaseAgreemenId);
//         //     // print('Lease agreement terminated');

//         //     Navigator.pushReplacementNamed(context, '/terminateSuccess');
//         //   } on Exception catch (e) {
//         //     print("Error terminating leaseAgreement: ${e.toString()}");
//         //     ScaffoldMessenger.of(context)
//         //         .showSnackBar(SnackBar(content: Text(e.toString())));
//         //   }
//         // },
//         child: const Text('Terminate',
//             style: TextStyle(fontSize: 20, color: Colors.white)),
//       ),
//     );
//   }

//   Widget maintenanceProvided(List<Maintenance> maintenance) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 0),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Maintenance Provided", style: categoryStyle),
//             const SizedBox(height: 8.0),
//             ListView(
//               primary: false,
//               itemExtent: 32.0,
//               scrollDirection: Axis.vertical,
//               shrinkWrap: true,
//               children: [
//                 for (Maintenance item in maintenance)
//                   ListTile(
//                     leading: Image.asset(
//                       'assets/icons/${item.toString().split('.').elementAt(1)}.png',
//                       fit: BoxFit.cover,
//                     ),
//                     title: Align(
//                       child: Text(item.value, style: bodyStyle2),
//                       alignment: const Alignment(-1.2, 0),
//                     ),
//                   )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget utilitiesProvided(List<Utility> utilities) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 0),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Utilities Provided", style: categoryStyle),
//             const SizedBox(height: 8.0),
//             ListView(
//               primary: false,
//               itemExtent: 32.0,
//               scrollDirection: Axis.vertical,
//               shrinkWrap: true,
//               children: [
//                 for (Utility item in utilities)
//                   ListTile(
//                     leading: Image.asset(
//                       'assets/icons/${item.toString().split('.').elementAt(1)}.png',
//                       fit: BoxFit.cover,
//                     ),
//                     title: Align(
//                       child: Text(item.value, style: bodyStyle2),
//                       alignment: const Alignment(-1.2, 0),
//                     ),
//                   )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget amenities(List<Amenity> amenities) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 0),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Amenities",
//               style: categoryStyle,
//             ),
//             const SizedBox(height: 8.0),
//             ListView(
//               primary: false,
//               itemExtent: 32.0,
//               scrollDirection: Axis.vertical,
//               shrinkWrap: true,
//               children: [
//                 for (Amenity item in amenities)
//                   ListTile(
//                     leading: Image.asset(
//                       'assets/icons/${item.toString().split('.').elementAt(1)}.png',
//                       fit: BoxFit.cover,
//                     ),
//                     title: Align(
//                       child: Text(
//                         item.value,
//                         style: bodyStyle2,
//                       ),
//                       alignment: const Alignment(-1.2, 0),
//                     ),
//                   )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget deposit(OneTimeSecurityDeposit securityDeposit) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 0),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("One Time Security Deposit", style: categoryStyle),
//             const SizedBox(height: 8.0),
//             detailLine("Deposit Amount: ",
//                 "\$${convertToDollar(securityDeposit.depositAmount)}"),
//             const SizedBox(height: 8.0),
//             detailLine("Refund Amount: ",
//                 "\$${convertToDollar(securityDeposit.refundAmount)}"),
//             const SizedBox(height: 8.0),
//             detailLine("Due Date: ",
//                 DateFormat.yMMMMd('en_US').format(securityDeposit.dueDate)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget address(Property? property) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 0),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Address", style: categoryStyle),
//             const SizedBox(height: 8.0),
//             property != null
//                 ? detailLine("", property.toString())
//                 : detailLine("", "No property assigned")
//           ],
//         ),
//       ),
//     );
//   }

//   Widget monthlyFees(MonthlyFees monthlyFees) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 0),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Monthly Fees", style: categoryStyle),
//             const SizedBox(height: 8.0),
//             detailLine("Rent Fee: ",
//                 "\$${convertToDollar(monthlyFees.rentFee.rentFeeAmount)}"),
//             const SizedBox(height: 4.0),
//             detailLine("Pet Fee: ",
//                 "\$${convertToDollar(monthlyFees.petFee.petFeeAmount)}"),
//             const SizedBox(height: 4.0),
//             dueDateCondition(monthlyFees),
//             const SizedBox(height: 4.0),
//             detailLine(
//                 "Late Fee: ", "\$${convertToDollar(monthlyFees.lateFee)}"),
//             const SizedBox(height: 4.0),
//             detailLine("Grace Period: ", "${monthlyFees.gracePeriod} days"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget dueDateCondition(MonthlyFees monthlyFees) {
//     switch (monthlyFees.dueDateType) {
//       case DueDateType.StartOfMonth:
//         return detailLine("Due Date: ", monthlyFees.dueDateType.value);
//       case DueDateType.EndOfMonth:
//         return detailLine("Due Date: ", monthlyFees.dueDateType.value);
//       case DueDateType.DayOfMonth:
//         return detailLine("Due Date: ",
//             "${DateFormat.yMMMMd('en_US').format(monthlyFees.dueDate!)} *(or end of month)");
//       default:
//         return Text("Not avaliable.", style: bodyStyle);
//     }
//   }

//   Widget duration(DateTime startDate, DateTime endDate) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(32.0, 24.0, 0, 0),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Duration", style: categoryStyle),
//             const SizedBox(height: 8.0),
//             detailLine("",
//                 "${DateFormat.yMMMMd('en_US').format(startDate)} to ${DateFormat.yMMMMd('en_US').format(endDate)}"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget acceptButton(BuildContext context, String leaseAgreemenId) {
//     ApiServiceProvider apiService =
//         Provider.of<ApiServiceProvider>(context, listen: false);

//     return SizedBox(
//       height: 60,
//       width: 150,
//       child: ElevatedButton(
//         style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.all(Colors.green),
//           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(24.0),
//             ),
//           ),
//         ),
//         onPressed: () async {
//           try {
//             LeaseAgreement leaseAgreement =
//                 await apiService.signLeaseAgreement(leaseAgreemenId);
//             print('Lease agreement signed');

//             Navigator.pushReplacementNamed(context, '/creditCard',
//                 arguments: JoinScreenArguments(leaseAgreement));
//           } on Exception catch (e) {
//             print(
//                 "Error signing leaseAgreement or setting up card payment: ${e.toString()}");
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(SnackBar(content: Text(e.toString())));
//           }
//         },
//         child: const Text('Accept',
//             style: TextStyle(fontSize: 20, color: Colors.white)),
//       ),
//     );
//   }

//   String convertToDollar(amount) {
//     final value = amount / 100;
//     final money = NumberFormat("###,###,###", "en_us");
//     return money.format(value);
//   }

//   Widget detailLine(String title, String detail) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.baseline,
//       textBaseline: TextBaseline.alphabetic,
//       children: [
//         Text("$title", style: bodyStyleBold),
//         Flexible(child: Text(detail, style: bodyStyle)),
//       ],
//     );
//   }
// }

TextStyle categoryStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500, fontSize: 24, color: Colors.black);

TextStyle bodyStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black);

TextStyle bodyStyle2 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w300, fontSize: 16, color: Colors.black);

TextStyle bodyStyleBold = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black);
