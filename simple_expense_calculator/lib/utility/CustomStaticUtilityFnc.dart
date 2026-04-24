import 'package:simple_expense_calculator/modelClass/ActivityModelClass.dart';

class CustomUtilityfucntion {
  static double getTotalExpense(List<ActivityModelClass> list) {
    double total = 0.0;
    for (var item in list) {
      total += double.tryParse(item.amount.toString()) ?? 0.0;
    }
    return total;
  }
  static double calculatePercentage(double part, double total) {
    if (total == 0) return 0;
    return (part / total) * 100;
  }

  static Map<String, double> getCategoryWiseTotal(List<ActivityModelClass> list) {
    Map<String, double> categoryTotals = {};

    for (var item in list) {
      double amount = double.tryParse(item.amount) ?? 0;
      String category = item.category;

      if (categoryTotals.containsKey(category)) {
        categoryTotals[category] = categoryTotals[category]! + amount;
      } else {
        categoryTotals[category] = amount;
      }
    }
    return categoryTotals;
  }


  // 🔍 1. FILTER BY CATEGORY
  static List<ActivityModelClass> filterByCategory(List<ActivityModelClass> list, String category) {
    if (category.isEmpty) return list;
    return list.where((item) => item.category == category).toList();
  }




  // 🔎 2. SEARCH BY NAME
  static List<ActivityModelClass> searchByName(List<ActivityModelClass> list, String query) {

    if (query.isEmpty) return list;
    return list.where((item) => item.name.toLowerCase().contains(query.toLowerCase())).toList();

  }
  
  // 🔃 3. SORT FUNCTION
  static List<ActivityModelClass> sortActivities(List<ActivityModelClass> list, String sortType) {

    List<ActivityModelClass> sortedList = List.from(list);
    
    switch (sortType) {
      case "By Date (Oldest to Newest)":
        sortedList.sort((a, b) => a.date.compareTo(b.date));
        break;

      case "By Date (Newest to Oldest)":
        sortedList.sort((a, b) => b.date.compareTo(a.date));
        break;

      case "By Amount (Low to High)":
        sortedList.sort((a, b) =>
            double.parse(a.amount).compareTo(double.parse(b.amount)));
        break;

      case "By Amount (High to Low)":
        sortedList.sort((a, b) =>
            double.parse(b.amount).compareTo(double.parse(a.amount)));
        break;
    }

    return sortedList;
  }

}