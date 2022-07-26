import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../Model/user_model.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final _auth = FirebaseAuth.instance;
  UserModel loggedInUser = UserModel();

  List<Map<String, dynamic>> userMap = [];
  bool isLoading = false;
  List productData = [];
  int? userId;

  Future getData() async {
    setState(() {
      isLoading = true;
    });
    User? currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('users').get().then((value) {
      //  print(value.size);
      // for(int i=0;i<value.size;i++){
      //
      // }
      // print(userMap);
      for (int i = 0; i < value.size; i++) {
        userMap.add(value.docs[i].data());
        if(currentUser?.uid==(userMap[i]['uid'])){
          userId=i;
          print("--------------userIndex---------"+userId.toString());
        }
      }

      if(userMap[userId!]['Add Product']!=null){
        for (int i = 0; i < userMap[userId!]['Add Product'].length; i++) {
          productData.add(userMap[userId!]['Add Product'][i]);
        }
        print("product data------------------"+productData.length.toString());
      }
      setState(() {
        isLoading = false;
      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea (
        child: isLoading
            ? const Center(
          child: Center(
            child: CircularProgressIndicator(
              valueColor:
              AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),
          ),
        )
            : Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          color: const Color(0xFFF6F6F6),
          child: Stack(children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    margin: const EdgeInsets.only(top: 25.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [
                        Text(
                          "Welcome",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 30.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 5.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 2.0, bottom: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          image: AssetImage("assets/banner1.png"),
                          width: double.infinity,
                        ),
                      )),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      // horizontal: 24.0,
                      vertical: 10.0,
                    ),
                    margin: EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Upcoming Expires",
                          style: TextStyle(
                            color: Color(0x9E000000),
                            fontSize: 20.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 5.0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  userMap[0]['Add Product']!=null?
                  Container(

                    height: 600,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: productData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildItem(context,productData[index]);
                      },

                      // controller: listScrollController,
                    ),
                  ):Container(
                    height: 200,
                    child: Center(child: Text("No data found")),
                  ),

                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

DateTime formatTimestamp(Timestamp timestamp) {
  var format = new DateFormat('y-MM-d'); // <- use skeleton here
  return timestamp.toDate();
}
Widget buildItem(BuildContext context,map) {
  print("-------------------------->>>>>"+map.toString());
  print(map);
  if (map != null) {

    var date = new DateTime.now();

    final difference =formatTimestamp(map['expiryDate']).difference(date).inDays;
    return difference < -1 ?Container(
    ) :Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 26.0,
      ),
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            map['productName'].toString(),
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 5.0,
            ),
            child: Text(
              formatTimestamp(map['expiryDate']).toString().substring(0,10),
              style: TextStyle(
                fontSize: 16.0,
                height: 1.0,
                color: Color(0xFFA8A8A8),
              ),
            ),
          ),
        ],
      ),
    );

  } else {
    return Container(
      height: MediaQuery.of(context).size.height,
      width:MediaQuery.of(context).size.width,
      child: Text("No Data Found"),
    );
  }
}
