import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rentremedy_mobile/Model/Maintenance/maintenance_request.dart';

class ViewMaintenanceRequestScreen extends StatelessWidget {
  MaintenanceRequest maintenanceRequest;
  ViewMaintenanceRequestScreen({Key? key, required this.maintenanceRequest})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("View Payment"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    balanceInfo(),
                    const Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                  ],
                ),
              ),
            ), // SizedBox(height: 8.0)
          ],
        ),
      ),
    );
  }

  Widget balanceInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 200.0, 0, 0),
      child: Align(
        // alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Item: ${maintenanceRequest.item}", style: categoryStyle),
            const SizedBox(height: 16.0),
            Text("Location: ${maintenanceRequest.location}",
                style: categoryStyle),
            Text("Description: ${maintenanceRequest.description}",
                style: categoryStyle),
            Text("Severity: ${maintenanceRequest.severity}",
                style: categoryStyle),
            Text("Status: ${maintenanceRequest.status}", style: categoryStyle),
            Text(
                "Date Submitted: ${DateFormat.yMMMMd('en_US').format(maintenanceRequest.submissionDate)}",
                style: bodyStyle),
          ],
        ),
      ),
    );
  }
}

TextStyle categoryStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w400, fontSize: 24, color: Colors.black);

TextStyle bodyStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black);
