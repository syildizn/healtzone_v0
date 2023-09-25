import 'package:flutter/material.dart';

class WaitingPage extends StatefulWidget {
  static String routeName = "WaitingPage";
  const WaitingPage({Key? key}) : super(key: key);

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Arka plan rengi.
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Text(
              "Bekleyecen kanka,"
                  "biz ne zaman onaylarsak o zaman girecen içeri,"
                  "belkide onaylamayız biraz bekle git",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

