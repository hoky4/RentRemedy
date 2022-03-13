import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TerminateSuccessScreen extends StatefulWidget {
  const TerminateSuccessScreen({Key? key}) : super(key: key);

  @override
  _TerminateSuccessScreenState createState() => _TerminateSuccessScreenState();
}

class _TerminateSuccessScreenState extends State<TerminateSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.done_rounded, size: 150, color: Colors.blue),
              Text("Successful", style: categoryStyleLight),
              const SizedBox(height: 16),
              Text("Your lease agreement was termintated successfully",
                  style: bodyStyle2Light),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue[200],
                    fixedSize: const Size(125, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Done', style: bodyStyleLight),
              )
            ],
          ),
        ));
  }
}

TextStyle categoryStyleLight = GoogleFonts.montserrat(
    fontWeight: FontWeight.w400, fontSize: 24, color: Colors.white);

TextStyle bodyStyleLight = GoogleFonts.montserrat(
    fontWeight: FontWeight.normal, fontSize: 16, color: Colors.white);

TextStyle bodyStyle2Light = GoogleFonts.montserrat(
    fontWeight: FontWeight.w300, fontSize: 16, color: Colors.white70);
