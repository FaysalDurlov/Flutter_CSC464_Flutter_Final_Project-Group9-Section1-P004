import 'package:flutter/material.dart';
import 'package:my_icon_package/my_icon_package.dart';

class CatagoryBreakDownCard extends StatelessWidget {


  final String categoryName;
  final String amount;
  final ColoredIcon icon;

  const CatagoryBreakDownCard({required this.categoryName, required this.amount, required this.icon, super.key});


  @override
  Widget build(BuildContext context) {
    return Card(
            color: Color.fromARGB(255, 253, 250, 246),
            elevation: 7,
            child: Container(
              padding: EdgeInsets.all(16),
              height: 70,
              child: Row(
                children: [
                icon,
                SizedBox(width: 30),
                Text(categoryName, style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700)),
                Spacer(),
                Text("$amount ৳", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              ],
              ),
            ),
          );
  }
}