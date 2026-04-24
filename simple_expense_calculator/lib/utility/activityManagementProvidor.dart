import 'package:flutter/material.dart';
import 'package:simple_expense_calculator/modelClass/ActivityModelClass.dart';
import 'package:simple_expense_calculator/utility/firebaseCrudUtilityFucntions.dart';

class ActivityManagementProvider with ChangeNotifier{
  List<ActivityModelClass> firebaseFetchedActivities = [];

  final FirebaseCrudUtilityFunctions repo = FirebaseCrudUtilityFunctions();

  Future<void> loadActivitiesFromFirebase() async {
    firebaseFetchedActivities = await repo.getAllActivity();
    notifyListeners();
  }
  
  Future<bool> addActivityToFirebase(ActivityModelClass activity) async {
    print("Inside Provider: ${activity.toJson()}");
    bool result = await repo.addActivity(activity);
    return result;
  }

  Future<bool> updateActivity(ActivityModelClass activity) async {
    bool result = await repo.updateActivityRecord(activity.id, activity.toJson());
    await loadActivitiesFromFirebase();
    return result;
  }

  Future<bool> deleteActivity(String id) async {
    bool result = await repo.deleteActivityRecord(id);
    await loadActivitiesFromFirebase();
    return result;
  }

}