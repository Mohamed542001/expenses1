import 'package:auto_route/auto_route.dart';
import 'package:expenses/user/models/transaction_type_model/transaction_type_model.dart';
import 'package:flutter/material.dart';


class TransactionModel {
  int? id;
  String? name;
  String? image;
  List<TransactionTypeModel>? content;
  PageRouteInfo? page;

  bool? isSelected;

  TransactionModel({this.id, this.name,this.image,this.content,this.isSelected=false,this.page});


}

