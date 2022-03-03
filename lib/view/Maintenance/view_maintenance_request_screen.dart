import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rentremedy_mobile/Model/Maintenance/maintenance_request.dart';
import 'package:rentremedy_mobile/Model/Maintenance/maintenance_request_status.dart';
import 'package:rentremedy_mobile/Model/Maintenance/severity_type.dart';

class ViewMaintenanceRequestScreenArguments {
  final MaintenanceRequest maintenanceRequest;

  ViewMaintenanceRequestScreenArguments(this.maintenanceRequest);
}

class ViewMaintenanceRequestScreen extends StatelessWidget {
  MaintenanceRequest maintenanceRequest;
  ViewMaintenanceRequestScreen({Key? key, required this.maintenanceRequest})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("View Maintenance Request"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      maintenanceRequestInfo(),
                      const Divider(
                          thickness: 1, indent: 32, endIndent: 32, height: 48),
                    ],
                  ),
                ),
              ),
            ), // SizedBox(height: 8.0)
          ],
        ),
      ),
    );
  }

  Widget maintenanceRequestInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 150.0, 0, 0),
      child: Align(
        // alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            maintenanceDetailLine("Item: ", maintenanceRequest.item),
            const SizedBox(height: 8.0),
            maintenanceDetailLine("Location: ", maintenanceRequest.location),
            const SizedBox(height: 8.0),
            maintenanceDetailLine(
                "Description: ", maintenanceRequest.description),
            const SizedBox(height: 8.0),
            maintenanceDetailLine(
                "Severity: ", maintenanceRequest.severity.value),
            const SizedBox(height: 8.0),
            maintenanceDetailLine("Status: ", maintenanceRequest.status.value),
            const SizedBox(height: 8.0),
            maintenanceDetailLine(
                "Date Submitted: ",
                DateFormat.yMMMMd('en_US')
                    .format(maintenanceRequest.submissionDate)),
          ],
        ),
      ),
    );
  }

  Widget maintenanceDetailLine(String title, String detail) {
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

TextStyle bodyStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black);

TextStyle bodyStyleBold = GoogleFonts.montserrat(
    fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black);
