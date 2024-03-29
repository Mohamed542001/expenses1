import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'dropdown_model.g.dart';

@HiveType(typeId:3)
class DropdownModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;

  bool? isSelected;

  DropdownModel({this.id, this.name,this.isSelected=false});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory DropdownModel.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return DropdownModel();
    }
    return DropdownModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

