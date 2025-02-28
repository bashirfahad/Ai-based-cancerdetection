import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/report_list.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Reports",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),), backgroundColor: Color(0xff1F4C6B),shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(10), // Adjust the radius as needed
      ),),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ReportList(searchEnabled: true),
      ),
    );
  }
}
