import 'package:flutter/material.dart';
import 'package:my_icon_package/my_icon_package.dart';
import 'package:provider/provider.dart';
import 'package:simple_expense_calculator/Page%20Designs/CustomWidgets/analytic_Cat_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:simple_expense_calculator/utility/CustomStaticUtilityFnc.dart';
import 'package:simple_expense_calculator/utility/activityManagementProvidor.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  
  @override
  Widget build(BuildContext context) {

    final activityList = context.watch<ActivityManagementProvider>().firebaseFetchedActivities;
    double totalExpense = CustomUtilityfucntion.getTotalExpense(activityList);
    final categoryData = CustomUtilityfucntion.getCategoryWiseTotal(activityList);

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
              SizedBox(height: 20),
              Text("Total Expence:  ${totalExpense.toStringAsFixed(2)} ৳ ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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
                                      value: CustomUtilityfucntion.calculatePercentage(categoryData["Dining"] ?? 0, totalExpense),
                                      color: Colors.blue,
                                      title: CustomUtilityfucntion.calculatePercentage(categoryData["Dining"] ?? 0, totalExpense).toStringAsFixed(1) + '%',
                                      radius: 60,
                                      titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    PieChartSectionData(
                                      value: CustomUtilityfucntion.calculatePercentage(categoryData["Groceries"] ?? 0, totalExpense),
                                      color: Colors.green,
                                      title: CustomUtilityfucntion.calculatePercentage(categoryData["Groceries"] ?? 0, totalExpense).toStringAsFixed(1) + '%',
                                      radius: 60,
                                      titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    PieChartSectionData(
                                      value: CustomUtilityfucntion.calculatePercentage(categoryData["Entertainment"] ?? 0, totalExpense),
                                      color: Colors.orange,
                                      title: CustomUtilityfucntion.calculatePercentage(categoryData["Entertainment"] ?? 0, totalExpense).toStringAsFixed(1) + '%',
                                      radius: 60,
                                      titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    PieChartSectionData(
                                      value: CustomUtilityfucntion.calculatePercentage(categoryData["Transport"] ?? 0, totalExpense),
                                      color: Colors.red,
                                      title: CustomUtilityfucntion.calculatePercentage(categoryData["Transport"] ?? 0, totalExpense).toStringAsFixed(1) + '%',
                                      radius: 60,
                                      titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    PieChartSectionData(
                                      value: CustomUtilityfucntion.calculatePercentage(categoryData["Bills"] ?? 0, totalExpense),
                                      color: Colors.purple,
                                      title: CustomUtilityfucntion.calculatePercentage(categoryData["Bills"] ?? 0, totalExpense).toStringAsFixed(1) + '%',
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
                              ),
                              SizedBox(
                                child: Row(
                                  children: [
                                    Container(width: 14, height: 14, color: Colors.purple),
                                    SizedBox(width: 8),
                                    Text("Bills", style: TextStyle(fontSize: 16)),
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
                children: categoryData.entries.map((entry) {
                  return CatagoryBreakDownCard(
                    categoryName: entry.key,
                    amount: entry.value.toStringAsFixed(2),
                    icon: CategoryConfig.getIcon(entry.key),
                  );
                }).toList(),
              )
              )
            ],
          ),
        ),
      ),
    );
  }
}


class CategoryConfig {
  static Map<String, dynamic> categoryIcons = {
    "Dining": ColoredIcon.burger(size: 25),
    "Groceries": ColoredIcon.shoppingCart1(size: 25),
    "Transport": ColoredIcon.carTaxi(size: 25),
    "Entertainment": ColoredIcon.filmRoll1(size: 25),
    "Bills": ColoredIcon.wallet(size: 25),
  };

  static dynamic getIcon(String category) {
    return categoryIcons[category];
  }
}

