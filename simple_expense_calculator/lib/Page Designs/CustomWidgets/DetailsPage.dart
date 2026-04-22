import 'package:flutter/material.dart';

class ExpenseDetailsPage extends StatefulWidget {

  final Function(int) changeTab;
  const ExpenseDetailsPage({required this.changeTab, super.key});

  @override
  State<ExpenseDetailsPage> createState() => _ExpenseDetailsPageState();
}

class _ExpenseDetailsPageState extends State<ExpenseDetailsPage> {

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
      appBar: AppBar(title: Text("Edit Activity Details"),
      centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            const Text(
                  'Activity Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
        
            TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Activity Name',
                ),
              ),

            SizedBox(height: 20),
        
            const Text(
                  'Amount',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            SizedBox(height: 2),
            Container(
              child: TextField(
                decoration: InputDecoration(
                  prefixText: '৳ ',
                  suffixText: "BDT",
                  border: OutlineInputBorder(),
                  hintText: 'Enter the Amount',
                ),
              ),
            ),
            SizedBox(height: 20),


            // Date Picker
            const Text(
                  'Date',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
            SizedBox(height: 2),
            Container(
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
                        selectedDate == null ? "Select Date" : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                      ),
                      const Icon(Icons.calendar_today, size: 18),
                    ],
                  ),
                ),
              ),
            ),
           SizedBox(height: 20),


           // category 
           const Text(
                  'Category',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        
            SizedBox(height: 2),
            Container(
              child: DropdownButtonFormField<String>(
                items: [
                  DropdownMenuItem(value: "Bills", child: Text("Bills")),
                  DropdownMenuItem(value: "Dining", child: Text("Dining")),
                  DropdownMenuItem(value: "Transport", child: Text("Transport")),
                  DropdownMenuItem(value: "Groceries", child: Text("Groceries")),
                  DropdownMenuItem(value: "Entertainment", child: Text("Entertainment")),
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
            SizedBox(height: 20),


            // Description 
            const Text(
                  'Description (Optional)',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            SizedBox(height: 2),
            Container(
              child: TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a description',
                ),
              ),
            ),
            SizedBox(height: 20),


            // Save and Cancel Button
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print("Cancel button pressed");
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 222, 80, 104),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print("Save button pressed");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Edited successfully"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 30, 109, 170),
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Save Changes',
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
      ),
    );
  }
}
