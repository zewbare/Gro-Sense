import 'dart:ui';
import 'package:gro_sense/model/user_model.dart';

class addprod{
  String? productName;
  DateTime? expiryDate;

  addprod(this.productName,this.expiryDate);

  Map<dynamic, dynamic> toMap() => {
    "productName" : productName,
    "expiryDate" : expiryDate,
  };
}
