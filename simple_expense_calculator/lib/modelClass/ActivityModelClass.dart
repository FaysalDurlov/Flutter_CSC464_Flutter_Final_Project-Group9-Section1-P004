// To parse this JSON data, do
//
//     final activityModelClass = activityModelClassFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ActivityModelClass activityModelClassFromJson(String str) => ActivityModelClass.fromJson(json.decode(str),"");

String activityModelClassToJson(ActivityModelClass data) => json.encode(data.toJson());

class ActivityModelClass {
    String id; // Add an 'id' field to hold the Firestore document ID
    String name;
    String amount;
    String category;
    String description;
    DateTime date;
    DateTime createdAt;

    ActivityModelClass({
        required this.id, // Make 'id' a required parameter in the constructor
        required this.name,
        required this.amount,
        required this.category,
        required this.description,
        required this.date,
        required this.createdAt,
    });

    factory ActivityModelClass.fromJson(Map<String, dynamic> json, String id) => ActivityModelClass(
        id: id,
        name: json["name"],
        amount: json["amount"],
        category: json["category"],
        description: json["description"],
        date: (json["date"] as Timestamp).toDate(),
        createdAt: (json["createdAt"] as Timestamp).toDate(),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
        "category": category,
        "description": description,
        "date": Timestamp.fromDate(date),
        "createdAt": Timestamp.fromDate(createdAt),
    };
}
