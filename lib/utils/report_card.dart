import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final String date;
  final String status;
  final String color;

  ReportCard({required this.date, required this.status, required this.color});

  Color getBorderColor() {
    switch (color) {
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.orange;
      case 'red':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: getBorderColor(), width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text("Skin Cancer Detection"),
        subtitle: Text(status, style: TextStyle(color: getBorderColor(), fontWeight: FontWeight.bold)),
        trailing: Text(date, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
