import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/report_list.dart';


class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("History",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),), backgroundColor: Color(0xff1F4C6B),elevation: 3,centerTitle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(10), // Adjust the radius as needed
      ),),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ReportList(),
      ),
    );
  }
}