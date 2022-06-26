import 'package:gro_sense/model/product_details.dart';
class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  bool? emailVerified;
  UserModel({this.uid, this.email, this.firstName, this.secondName,this.emailVerified});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
        emailVerified: map['emailVerified'],
    );
  }
  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'emailVerified': emailVerified,
    };
  }


}
mixin Userclass implements addprod {

  List<dynamic>  addproduct = [];
//send data to database
  Map<String, dynamic> toMap() {
    return {
      'addprod': addprod,
    };
  }
}