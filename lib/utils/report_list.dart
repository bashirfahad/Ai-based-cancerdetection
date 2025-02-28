import 'package:cancerdetection/utils/report_card.dart';
import 'package:cancerdetection/utils/result.dart';
import 'package:flutter/material.dart';

class ReportList extends StatefulWidget {
  final bool searchEnabled;

  ReportList({this.searchEnabled = false});

  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.searchEnabled)
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search by Date (DD/MM/YY)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search, color: Color(0xff1F4C6B)),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
        Expanded(
          child: ListView.builder(
            itemCount: ReportData.results.length,
            itemBuilder: (context, index) {
              final result = ReportData.results[index];
              if (searchQuery.isNotEmpty && !result['date']!.contains(searchQuery)) {
                return SizedBox.shrink();
              }
              return ReportCard(
                date: result['date']!,
                status: result['status']!,
                color: result['color']!,
              );
            },
          ),
        ),
      ],
    );
  }
}