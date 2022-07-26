import 'dart:ui';
import 'package:gro_sense/model/user_model.dart';

class addprod{
  String? productName;
  DateTime? expiryDate;
  DateTime? reminderDate;

  addprod(this.productName,this.expiryDate, this.reminderDate);

  Map<dynamic, dynamic> toMap() => {
    "productName" : productName,
    "expiryDate" : expiryDate,
  };
}
