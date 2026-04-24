import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_expense_calculator/modelClass/ActivityModelClass.dart';
import 'package:simple_expense_calculator/utility/contants.dart';


class FirebaseCrudUtilityFunctions {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> addActivity(ActivityModelClass activity) async {
    try {
      print("inside firebase function: ${activity.toJson()}");
      await firestore.collection(appConst.activityRecordsCollection).add(activity.toJson());
      print("Activity added successfully.");
      return true;
    } catch (e) {
      print("Error adding activity: $e");
      return false;
    }
  }

  Future<List<ActivityModelClass>> getAllActivity() async {
    try {
      final snapshot = await firestore.collection(appConst.activityRecordsCollection).get();

      return snapshot.docs.map((doc) => ActivityModelClass.fromJson(doc.data(), doc.id)).toList();

    } catch (e) {
      print("Error fetching tasks: $e");
      return [];
    }
  }

  Future<bool> updateActivityRecord(String docId, Map<String, dynamic> updatedData) async {
    try {
      await firestore.collection(appConst.activityRecordsCollection).doc(docId).update(updatedData);
      print("Activity record updated successfully.");
      return true;
    } catch (e) {
      print("Error updating activity record: $e");
      return false;
    }
  }

  Future<bool> deleteActivityRecord(String docId) async {
    try {
      await firestore.collection(appConst.activityRecordsCollection).doc(docId).delete();
      print("Activity record deleted successfully.");
      return true;
    } catch (e) {
      print("Error deleting activity record: $e");
      return false;
    }
  }
}
