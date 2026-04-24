import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_expense_calculator/Page Designs/CustomWidgets/DetailsPage.dart';
import 'package:intl/intl.dart';
import 'package:simple_expense_calculator/modelClass/ActivityModelClass.dart';
import 'package:simple_expense_calculator/utility/CustomStaticUtilityFnc.dart';
import 'package:simple_expense_calculator/utility/activityManagementProvidor.dart';

class HomePageView extends StatefulWidget {
  final Function(int) changeTab;
  const HomePageView({required this.changeTab, super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final ScrollController _scrollController = ScrollController();

  String selectedCategory = "";
  String selectedSort = "";
  String searchQuery = "";


  void _showFilterDialog(BuildContext context, {required List<String> itemLists, required String type}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: itemLists.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(itemLists[index]),
               onTap: () {
                setState(() {
                  if (type == "category") {
                    selectedCategory = itemLists[index];
                  } else if (type == "sort") {
                    selectedSort = itemLists[index];
                  }
                });
                Navigator.pop(context);
              },
              );
            },
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    final activityProvider = Provider.of<ActivityManagementProvider>(context, listen: false);

    activityProvider.loadActivitiesFromFirebase();
  }


  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFF4F6FB),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(icon, color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {


    final activityList = context.watch<ActivityManagementProvider>().firebaseFetchedActivities;
    final totalExpense = CustomUtilityfucntion.getTotalExpense(activityList);

    List<ActivityModelClass> filteredList = activityList;

    filteredList = CustomUtilityfucntion.filterByCategory(filteredList, selectedCategory);
    filteredList = CustomUtilityfucntion.searchByName(filteredList, searchQuery);
    filteredList = CustomUtilityfucntion.sortActivities(filteredList, selectedSort);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 189, 216, 245),
        centerTitle: true,
        title: const Text(
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
          // HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 20, bottom: 30),
            decoration: const BoxDecoration(
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
                  "৳  ${totalExpense.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // SEARCH + FILTERS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F6FB),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.grey),
                        hintText: "Search Expenses...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                _iconButton(Icons.filter_list, () {
                  _showFilterDialog(context, itemLists: ["Bills", "Dining", "Transport", "Groceries", "Entertainment"],type: "category");
                }),

                const SizedBox(width: 10),

                _iconButton(Icons.swap_vert, () {
                  _showFilterDialog(context,itemLists: [
                                            "By Date (Oldest to Newest)",
                                            "By Date (Newest to Oldest)",
                                            "By Amount (Low to High)",
                                            "By Amount (High to Low)"
                                          ],type: "sort");
                }),
              ],
            ),
          ),
          // LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return expenseItem(context, activity: filteredList[index]);
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 30, 109, 170),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
        onPressed: () {
          print("Add Expense button pressed");
          widget.changeTab(1);
        },
        icon: const Icon(Icons.add),
        label: const Text(
          'Add Expense',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget expenseItem(BuildContext context, {required ActivityModelClass activity}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(
          padding: const EdgeInsets.only(right: 20),
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        onDismissed: (direction) {
            final provider = context.read<ActivityManagementProvider>();
            provider.deleteActivity(activity.id);
        },

        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ExpenseDetailsPage( activity: activity, changeTab: widget.changeTab),
              ),
            );
          },

          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.fastfood, color: Colors.orange),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat('dd MMM, yyyy').format(activity.date),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                Text(
                  "৳ ${activity.amount}",
                  style: const TextStyle(
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