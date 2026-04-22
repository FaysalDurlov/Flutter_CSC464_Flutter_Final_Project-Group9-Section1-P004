import 'package:flutter/material.dart';
import 'package:simple_expense_calculator/Page%20Designs/home_page.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  DateTime? selectedDate;

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 189, 216, 245),
        shadowColor: Colors.black,
        elevation: 4,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            print("back button pressed");
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
        ),
        title: Text(
          'Add Expense',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Expense Name',
              ),
            ),
          ),
          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Amount',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              decoration: InputDecoration(
                prefixText: '৳ ',
                suffixText: "BDT",
                border: OutlineInputBorder(),
                hintText: 'Enter the Amount',
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Date',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: InkWell(
              // here the inkwell can make any widgets clickable thats it
              onTap: pickDate,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 17,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate == null
                          ? "Select Date"
                          : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                    ),
                    const Icon(Icons.calendar_today, size: 18),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Category',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: DropdownButtonFormField<String>(
              items: [
                DropdownMenuItem(value: "Bills", child: Text("Bills")),
                DropdownMenuItem(value: "Dining", child: Text("Dining")),
                DropdownMenuItem(value: "Transport", child: Text("Transport")),
                DropdownMenuItem(value: "Groceries", child: Text("Groceries")),
                DropdownMenuItem(
                  value: "Entertainment",
                  child: Text("Entertainment"),
                ),
              ],
              onChanged: (value) {
                print("Selected category: $value");
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select a category',
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Description (Optional)',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a description',
              ),
            ),
          ),

          SizedBox(height: 10),

          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print("Cancel button pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color.fromARGB(255, 30, 109, 170),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    print("Save button pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 30, 109, 170),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Save Expense',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
