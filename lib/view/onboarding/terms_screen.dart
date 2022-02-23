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
import 'package:rentremedy_mobile/Model/LeaseAgreement/utility.dart';
import 'package:rentremedy_mobile/Model/Property/property.dart';
import 'package:rentremedy_mobile/Providers/api_service_provider.dart';
import 'package:rentremedy_mobile/Providers/auth_model_provider.dart';
import 'join_screen.dart';

class TermsScreen extends StatelessWidget {
  final LeaseAgreement leaseAgreement;

  TermsScreen({Key? key, required this.leaseAgreement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authModel = context.read<AuthModelProvider>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Text("Terms"),
            automaticallyImplyLeading: false,
            centerTitle: true,
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white70, // foreground
                ),
                onPressed: () {
                  // Update with a unsigned lease agreement
                  LoggedInUser? user = authModel.user;
                  if (user != null) {
                    user.leaseAgreement = leaseAgreement;
                    authModel.loginUser(user);
                    Navigator.pushReplacementNamed(context, '/chat');
                  }
                },
                child: Text('Sign Later'),
              ),
            ]),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    duration(leaseAgreement.startDate, leaseAgreement.endDate),
                    const Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    monthlyFees(leaseAgreement.monthlyFees),
                    const Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    address(leaseAgreement.property),
                    const Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    deposit(leaseAgreement.securityDeposit),
                    const Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    amenities(leaseAgreement.amenitiesProvided),
                    const Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    utilitiesProvided(leaseAgreement.utilitiesProvided),
                    const Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    maintenanceProvided(leaseAgreement.maintenanceProvided),
                    const SizedBox(height: 24)
                  ],
                ),
              ),
            ),
            Container(
                // alignment: Alignment.center,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.black12),
                child: Row(
                  children: [
                    const Spacer(),
                    acceptButton(context, leaseAgreement.id),
                    const Spacer()
                  ],
                )),
          ],
        ),
      ),
    );
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
            Text(
                "Deposit Amount: \$${convertToDollar(securityDeposit.depositAmount)}",
                style: bodyStyle),
            const SizedBox(height: 8.0),
            Text(
                "Refund Amount: \$${convertToDollar(securityDeposit.refundAmount)}",
                style: bodyStyle),
            const SizedBox(height: 8.0),
            Text(
                "Due Date: ${DateFormat.yMMMMd('en_US').format(securityDeposit.dueDate)}",
                style: bodyStyle),
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
                ? Text(property.toString(), style: bodyStyle)
                : const Text("No property assigned")
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
            Text(
                "Rent Fee: \$${convertToDollar(monthlyFees.rentFee.rentFeeAmount)}",
                style: bodyStyle),
            const SizedBox(height: 4.0),
            Text(
                "Pet Fee: \$${convertToDollar(monthlyFees.petFee.petFeeAmount)}",
                style: bodyStyle),
            const SizedBox(height: 4.0),
            dueDateCondition(monthlyFees),
            // Text(
            //     "Due Date: ${DateFormat.yMMMMd('en_US').format(monthlyFees.dueDate!)}",
            //     style: bodyStyle),
            const SizedBox(height: 4.0),
            Text("Late Fee: \$${convertToDollar(monthlyFees.lateFee)}",
                style: bodyStyle),
            const SizedBox(height: 4.0),
            Text("Grace Period: ${monthlyFees.gracePeriod} days",
                style: bodyStyle),
          ],
        ),
      ),
    );
  }

  Widget dueDateCondition(MonthlyFees monthlyFees) {
    switch (monthlyFees.dueDateType) {
      case DueDateType.StartOfMonth:
        return Text("Due Date: ${monthlyFees.dueDateType.value}",
            style: bodyStyle);
      case DueDateType.EndOfMonth:
        return Text("Due Date: ${monthlyFees.dueDateType.value}",
            style: bodyStyle);
      case DueDateType.DayOfMonth:
        return Text(
            "Due Date: ${DateFormat.yMMMMd('en_US').format(monthlyFees.dueDate!)} *(or end of month)",
            style: bodyStyle);
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
            Text(
                "${DateFormat.yMMMMd('en_US').format(startDate)} to ${DateFormat.yMMMMd('en_US').format(endDate)}",
                style: bodyStyle),
          ],
        ),
      ),
    );
  }

  Widget acceptButton(BuildContext context, String leaseAgreemenId) {
    ApiServiceProvider apiService =
        Provider.of<ApiServiceProvider>(context, listen: false);

    return ElevatedButton(
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
          style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }

  String convertToDollar(amount) {
    final value = amount / 100;
    final money = NumberFormat("###,###,###", "en_us");
    return money.format(value);
  }
}

TextStyle categoryStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500, fontSize: 24, color: Colors.black);

TextStyle bodyStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black);

TextStyle bodyStyle2 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w300, fontSize: 16, color: Colors.black);
