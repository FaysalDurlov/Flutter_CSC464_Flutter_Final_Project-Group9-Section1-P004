import 'package:flutter/material.dart';
import 'package:simple_expense_calculator/Page%20Designs/CustomWidgets/DetailsPage.dart';

class HomePageView extends StatefulWidget {

  final Function(int) changeTab;
  const HomePageView({required this.changeTab, super.key});


  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {

  void _showFilterDialog(BuildContext context , {required List<String> itemLists}) {
    final categories = itemLists;

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
        centerTitle: true,
        title: Text(
          'Simple Expense Calculator',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      body: Column(
        children: [
          //Top Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 20, bottom: 30),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 189, 216, 245),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                Text(
                  "Total Expense",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  "\$1,250.75",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          //Search Bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F6FB),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.grey),
                        hintText: "Search Expenses...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: (){
                    print("Filter By Category");
                    _showFilterDialog(context, 
                    itemLists: ["Bills", "Dining", "Transport", "Groceries", "Entertainment"]);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F6FB),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(Icons.filter_list, color: Colors.grey),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    print("Filter By Date and Amount");
                    _showFilterDialog(context, 
                    itemLists: ["By Date (Oldest to Newest)", "By Date (Newest to Oldest)", "By Amount (Low to High)", "By Amount (High to Low)"]);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F6FB),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(Icons.swap_vert, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),

          // Expense List
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return expenseItem(context);
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 30, 109, 170),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
        onPressed: () {
          print("Add Expense button pressed");
          widget.changeTab(1);
        },
        tooltip: 'Add Expense',
        icon: Icon(Icons.add),
        label: const Text(
          'Add Expense',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget expenseItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Dismissible(
        key: UniqueKey(),
        direction:
            DismissDirection.endToStart, // the Swipe Direction (Right to Left)
        // Delete Background RED
        background: Container(
          padding: EdgeInsets.only(right: 20),
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(Icons.delete, color: Colors.white),
        ),

        onDismissed: (direction) {
          print("Deleted");
        },

        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ExpenseDetailsPage(changeTab: widget.changeTab)),
            );
          },

          // Card UI for each expense item
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Icon Box
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.fastfood, color: Colors.orange),
                ),

                SizedBox(width: 15),

                // Text Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lunch @ Cafe",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("15 Oct 2023", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),

                // Amount
                Text(
                  "-\$32.50",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//Home_page_created