import 'package:flutter/material.dart';
import 'package:my_icon_package/my_icon_package.dart';
import 'package:simple_expense_calculator/Page%20Designs/CustomWidgets/analytic_Cat_card.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {

  void _showCategoryDialog(BuildContext context) {
    final categories = [
      "Today",
      "Yesterday",
      "This Week",
      "This Month",
      "This Year",
    ];

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(categories[index]),
                onTap: () {
                  Navigator.pop(context);
                  print("Selected: ${categories[index]}");
                },
              );
            },
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 189, 216, 245),
        shadowColor: Colors.black,
        elevation: 4,
        centerTitle: true,
        title: Text(
          'Analytics',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text("October 2024", 
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () => _showCategoryDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(90, 206, 209, 214),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text("Filter",style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Icon(Icons.arrow_drop_down_sharp, size: 30),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              const Text("Total Expence: \$1234.56", 
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: const Text("Category-Wise", 
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 220,
                child: Card(
                  color: Color.fromARGB(255, 253, 250, 246),
                  elevation: 7,
                  child: Row(
                    children: [
                      Container(
                        width: 200,
                        padding: const EdgeInsets.all(8.0),
                        child: PieChart( 
                                PieChartData(
                                  sections: [
                                    PieChartSectionData(
                                      value: 40,
                                      color: Colors.blue,
                                      title: '40%',
                                      radius: 60,
                                      titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    PieChartSectionData(
                                      value: 30,
                                      color: Colors.green,
                                      title: '30%',
                                      radius: 60,
                                      titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    PieChartSectionData(
                                      value: 20,
                                      color: Colors.orange,
                                      title: '20%',
                                      radius: 60,
                                      titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    PieChartSectionData(
                                      value: 10,
                                      color: Colors.red,
                                      title: '10%',
                                      radius: 60,
                                      titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                  ]
                                ),
                              ),
                      ),
                      SizedBox(width: 30),
                      Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Row(
                                  children: [
                                    Container(width: 14, height: 14, color: Colors.blue),
                                    SizedBox(width: 8),
                                    Text("Dinning", style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Row(
                                  children: [
                                    Container(width: 14, height: 14, color: Colors.green),
                                    SizedBox(width: 8),
                                    Text("Groceries", style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Row(
                                  children: [
                                    Container(width: 14, height: 14, color: Colors.orange),
                                    SizedBox(width: 8),
                                    Text("Transport", style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Row(
                                  children: [
                                    Container(width: 14, height: 14, color: Colors.red),
                                    SizedBox(width: 8),
                                    Text("Entertainment", style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              )
                            ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: const Text("Category Breakdown", 
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
              child: Column(
                children: [
                  CatagoryBreakDownCard(categoryName: "Dinning", amount: "400.00", icon: ColoredIcon.burger(size: 25)),
                  CatagoryBreakDownCard(categoryName: "Groceries", amount: "300.00", icon: ColoredIcon.shoppingCart1(size: 25)),
                  CatagoryBreakDownCard(categoryName: "Transport", amount: "200.00", icon: ColoredIcon.carTaxi(size: 25)),
                  CatagoryBreakDownCard(categoryName: "Entertainment", amount: "150.00", icon: ColoredIcon.filmRoll1(size: 25)),
                ],
              )
              )
            ],
          ),
        ),
      ),
    );
  }
}// 15:23