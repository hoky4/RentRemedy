import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaintenanceRequestSuccessScreen extends StatefulWidget {
  const MaintenanceRequestSuccessScreen({Key? key}) : super(key: key);

  @override
  _MaintenanceRequestSuccessScreenState createState() =>
      _MaintenanceRequestSuccessScreenState();
}

class _MaintenanceRequestSuccessScreenState
    extends State<MaintenanceRequestSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.build_circle_outlined,
                  size: 150, color: Colors.orange[200]),
              Text("Successful", style: categoryStyle),
              const SizedBox(height: 16),
              Text("Your request was done successfully", style: bodyStyle2),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue[100],
                    fixedSize: const Size(125, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Done', style: bodyStyle),
              )
            ],
          ),
        ));
  }
}

TextStyle categoryStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w400, fontSize: 24, color: Colors.black);

TextStyle bodyStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black);

TextStyle bodyStyle2 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w300, fontSize: 16, color: Colors.black);
