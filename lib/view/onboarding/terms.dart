import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentremedy_mobile/view/chat/message_screen.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
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
                    duration(),
                    Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    amount(),
                    Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    address(),
                    Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    deposit(),
                    Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    amenities(),
                    Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    utilitiesProvided(),
                    Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                    maintenanceProvided(),
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
                  children: [Spacer(), acceptButton(context), Spacer()],
                )),
          ],
        ),
      ),
    );
  }

  Widget maintenanceProvided() {
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
                for (MaintenanceProvided item in MaintenanceProvided.values)
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

  Widget utilitiesProvided() {
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
                for (UtilitiesProvided item in UtilitiesProvided.values)
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

  Widget amenities() {
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
                for (Amenities item in Amenities.values)
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

  Widget deposit() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Deposit", style: categoryStyle),
            SizedBox(height: 8.0),
            Text("\$500", style: bodyStyle),
          ],
        ),
      ),
    );
  }

  Widget address() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Address", style: categoryStyle),
            SizedBox(height: 8.0),
            Text("1111 Spring Valley Rd,\n#104 Salt Lake City UT, 84024",
                style: bodyStyle),
          ],
        ),
      ),
    );
  }

  Widget amount() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Amount", style: categoryStyle),
            SizedBox(height: 8.0),
            Text("\$550/mo", style: bodyStyle),
            SizedBox(height: 4.0),
            Text("Late Fee: \$50", style: bodyStyle),
            SizedBox(height: 4.0),
            Text("Grace Period: 10 days", style: bodyStyle),
          ],
        ),
      ),
    );
  }

  Widget duration() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 24.0, 0, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Duration", style: categoryStyle),
            SizedBox(height: 8.0),
            Text("January 2022 to January 2023", style: bodyStyle),
          ],
        ),
      ),
    );
  }

  Widget acceptButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.green),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
      ),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MessageScreen()));
      },
      child:
          Text('Accept', style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }
}

enum Amenities {
  Refrigerator,
  Microwave,
  Stove,
  Oven,
  Dishwasher,
  Washer,
  Dryer
}

enum UtilitiesProvided { Electricity, Gas, Water, Internet, Waste }

enum MaintenanceProvided {
  Foundation,
  Plumbing,
  Roof,
  Sprinklers,
  HVAC,
  MainSystems,
  ElectricalSystems,
  Structure
}

TextStyle categoryStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500, fontSize: 24, color: Colors.black);

TextStyle bodyStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black);

TextStyle bodyStyle2 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w300, fontSize: 16, color: Colors.black);
