import 'package:flutter/material.dart';
import 'package:simple_expense_calculator/Page%20Designs/add_expense_page.dart';
import 'package:simple_expense_calculator/Page%20Designs/analyticsPage.dart';
import 'package:simple_expense_calculator/Page%20Designs/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int currentIndex = 0;
  void changeTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePageView(changeTab: changeTab),
      AddExpensePage(changeTab: changeTab),
      AnalyticsPage(), // placeholder
    ];
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: changeTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline_outlined),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "Analytics",
          ),
        ],
      ),
    );
  }
}