import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rentremedy_mobile/models/Fees/monthly_fees.dart';
import 'package:rentremedy_mobile/models/LeaseAgreement/amenity.dart';
import 'package:rentremedy_mobile/models/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/models/LeaseAgreement/maintenance.dart';
import 'package:rentremedy_mobile/models/LeaseAgreement/one_time_security_deposit.dart';
import 'package:rentremedy_mobile/models/LeaseAgreement/utility.dart';
import 'package:rentremedy_mobile/models/Property/property.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';
import 'package:rentremedy_mobile/view/chat/message_screen.dart';

class TermsScreen extends StatelessWidget {
  LeaseAgreement leaseAgreement;

  TermsScreen({required this.leaseAgreement});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Terms"), automaticallyImplyLeading: false, centerTitle: true,),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    duration(leaseAgreement.startDate, leaseAgreement.endDate),
                    Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    monthlyFees(leaseAgreement.monthlyFees),
                    Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    address(leaseAgreement.property),
                    Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    deposit(leaseAgreement.securityDeposit),
                    Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    amenities(leaseAgreement.amenitiesProvided),
                    Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    utilitiesProvided(leaseAgreement.utilitiesProvided),
                    Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    maintenanceProvided(leaseAgreement.maintenanceProvided),
                    SizedBox(height: 24)
                  ],
                ),
              ),
            ),
            Container(
                // alignment: Alignment.center,
                width: double.infinity,
                decoration: new BoxDecoration(color: Colors.black12),
                child: Row(
                  children: [Spacer(), acceptButton(context, leaseAgreement.id), Spacer()],
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
            SizedBox(height: 8.0),
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
                      child: Text("${item.toString().split('.').elementAt(1)}",
                          style: bodyStyle2),
                      alignment: Alignment(-1.2, 0),
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
            SizedBox(height: 8.0),
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
                      child: Text("${item.toString().split('.').elementAt(1)}",
                          style: bodyStyle2),
                      alignment: Alignment(-1.2, 0),
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
            SizedBox(height: 8.0),
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
                        "${item.toString().split('.').elementAt(1)}",
                        style: bodyStyle2,
                      ),
                      alignment: Alignment(-1.2, 0),
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
            SizedBox(height: 8.0),
            Text("Deposit Amount: \$${securityDeposit.depositAmount}", style: bodyStyle),
            SizedBox(height: 8.0),
            Text("Refund Amount: \$${securityDeposit.refundAmount}", style: bodyStyle),
            SizedBox(height: 8.0),
            Text("Due Date: ${DateFormat.yMMMMd('en_US').format(securityDeposit.dueDate)}", style: bodyStyle),
          ],
        ),
      ),
    );
  }

  Widget address(Property property) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Address", style: categoryStyle),
            SizedBox(height: 8.0),
            Text("${property.toString()}",
                style: bodyStyle),
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
            SizedBox(height: 8.0),
            Text("Rent Fee: \$${monthlyFees.rentFee.rentFeeAmount}", style: bodyStyle),
            SizedBox(height: 4.0),
            Text("Pet Fee: \$${monthlyFees.petFee.petFeeAmount}", style: bodyStyle),
            SizedBox(height: 4.0),
            Text("Due Date: ${DateFormat.yMMMMd('en_US').format(monthlyFees.dueDate!)}", style: bodyStyle),
            SizedBox(height: 4.0),
            Text("Late Fee: \$${monthlyFees.lateFee}", style: bodyStyle),
            SizedBox(height: 4.0),
            Text("Grace Period: ${monthlyFees.gracePeriod} days", style: bodyStyle),
          ],
        ),
      ),
    );
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
            SizedBox(height: 8.0),
            Text("${DateFormat.yMMMMd('en_US').format(startDate)} to ${DateFormat.yMMMMd('en_US').format(endDate)}", style: bodyStyle),
          ],
        ),
      ),
    );
  }

  Widget acceptButton(BuildContext context, String leaseAgreemenId) {
    ApiService apiService = ApiService();

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
        await apiService.signLeaseAgreement('$leaseAgreemenId');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MessageScreen()));
      },
      child:
          Text('Accept', style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }
}

TextStyle categoryStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500, fontSize: 24, color: Colors.black);

TextStyle bodyStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black);

TextStyle bodyStyle2 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w300, fontSize: 16, color: Colors.black);
