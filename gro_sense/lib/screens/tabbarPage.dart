// import 'package:flutter/material.dart';
//
// class tabbarPage extends StatefulWidget {
//   const tabbarPage({Key? key}) : super(key: key);
//
//   tabbarPageState createState() => tabbarPageState();
// }
//
// class tabbarPageState extends State<tabbarPage>
//     with SingleTickerProviderStateMixin {
//   late TabController tabController;
//
//   @override
//   void initState() {
//     tabController = TabController(length: 2, vsync: this);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white10,
//         /*appBar: AppBar(
//           backgroundColor: Colors.green,
//           title: Text('List Screen'),
//         ),*/
//         body: Column(
//           children: [
//             SizedBox(
//               height: 50,
//             ),
//             Text("Gro-Sense",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold)),
//             SizedBox(
//               height: 10,
//             ),
//             Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//               elevation: 5,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: TabBar(
//                   indicator: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: Colors.green),
//                   controller: tabController,
//                   isScrollable: true,
//                   labelPadding: EdgeInsets.symmetric(horizontal: 60),
//                   tabs: [
//                     Tab(
//                       child: Text(
//                         "List of items",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                     Tab(
//                       child: Text(
//                         "Expired items",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//                 child: TabBarView(
//               controller: tabController,
//               children: [
//                 ListView.builder(
//                     physics: BouncingScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: 10,
//                     itemBuilder: (context, index) {
//                       return Card(
//                         margin:
//                             EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//                         child: ListTile(
//                           /*leading: Icon(
//                             Icons.add,
//                             color: Colors.red,
//                           ),*/
//                           title: Text("List of Item: ${index + 1}"),
//                           /* onTap: () {
//                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => add_product));
//                           },*/
//                           trailing: Icon(
//                             Icons.edit,
//                             color: Colors.red,
//                           ),
//                         ),
//                       );
//                     }),
//                 ListView.builder(
//                     physics: BouncingScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: 10,
//                     itemBuilder: (context, index) {
//                       return Card(
//                           margin: EdgeInsets.symmetric(
//                               horizontal: 30, vertical: 10),
//                           child: ListTile(
//                             /*leading: Icon(
//                             Icons.add,
//                             color: Colors.red,
//                           ),*/
//                             title: Text("Expired Item: ${index + 1}"),
//                             trailing: Icon(
//                               Icons.delete,
//                               color: Colors.red,
//                             ),
//                           ));
//                     })
//               ],
//             ))
//           ],
//         ));
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gro_sense/utils/navigation.dart';
import 'package:intl/intl.dart';

import 'dashboard.dart';

class tabbarPage extends StatefulWidget {
  const tabbarPage({Key? key}) : super(key: key);

  tabbarPageState createState() => tabbarPageState();
}

class tabbarPageState extends State<tabbarPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  List<Map<String, dynamic>> userMap = [];
  bool isLoading = false;
  List productData = [];
  int? userId;

  @override
  void initState() {
    getData();
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    User? currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (int i = 0; i < value.size; i++) {
        userMap.add(value.docs[i].data());
        if (currentUser!.uid == (userMap[i]['uid'])) {
          userId = i;
          print("--------------userIndex---------" + userId.toString());
        }
      }

      if (userMap[userId!]['Add Product'] != null) {
        for (int i = 0; i < userMap[userId!]['Add Product'].length; i++) {
          productData.add(userMap[userId!]['Add Product'][i]);
        }
        print("product data------------------" + productData.length.toString());
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF6F6F6),
        appBar: AppBar(
          title: Text('List of products'),
          backgroundColor: Colors.green,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // passing this to our root
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyBottomNavigation()));
            },
          ),
        ),
        body: Column(
          children: [
            // SizedBox(
            //   height: 50,
            // ),
            // Text("Gro-Sense",
            //     style: TextStyle(
            //         color: Colors.white70,
            //         fontSize: 30,
            //         fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),

            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.green),
                  controller: tabController,
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(horizontal: 50),
                  tabs: [
                    Tab(
                      child: Text(
                        "List of items",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Expired items",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: productData.length,
                        itemBuilder: (context, index) {
                          return buildItem(context, productData[index]);
                        }),
                    ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: productData.length,
                        itemBuilder: (context, index) {
                          return buildItem1(context, productData[index]);
                        }),
                  ],
                ))
          ],
        ));
  }

  DateTime formatTimestamp(Timestamp timestamp) {
    var format = new DateFormat('y-MM-d'); // <- use skeleton here
    return timestamp.toDate();
  }

  Widget buildItem(BuildContext context, map) {
    print("-------------------------->>>>>" + map.toString());
    if (map != null) {
      var date = new DateTime.now();
      final difference =
          formatTimestamp(map['expiryDate']).difference(date).inDays;
      return difference < 0
          ? Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Text("No any expired products"),
      )
          : Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 26.0,
        ),
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        //margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
        width: MediaQuery.of(context).size.width,
        child: Text("No Data Found"),
      );
    }
  }

  Widget buildItem1(BuildContext context, map) {
    print("-------------------------->>>>>" + map.toString());
    if (map != null) {
      var date = new DateTime.now();
      final difference =
          formatTimestamp(map['expiryDate']).difference(date).inDays;
      return difference > -1
          ? Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        // child: Center(child: Text("No expired product")),
      )
          : Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 26.0,
        ),
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
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
        width: MediaQuery.of(context).size.width,
        child: Text("No Data Found"),
      );
    }
  }
}
// import 'package:flutter/material.dart';
//
// class tabbarPage extends StatefulWidget {
//   const tabbarPage({Key? key}) : super(key: key);
//
//   tabbarPageState createState() => tabbarPageState();
// }
//
// class tabbarPageState extends State<tabbarPage>
//     with SingleTickerProviderStateMixin {
//   late TabController tabController;
//
//   @override
//   void initState() {
//     tabController = TabController(length: 2, vsync: this);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white10,
//         /*appBar: AppBar(
//           backgroundColor: Colors.green,
//           title: Text('List Screen'),
//         ),*/
//         body: Column(
//           children: [
//             SizedBox(
//               height: 50,
//             ),
//             Text("Gro-Sense",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold)),
//             SizedBox(
//               height: 10,
//             ),
//             Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//               elevation: 5,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: TabBar(
//                   indicator: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: Colors.green),
//                   controller: tabController,
//                   isScrollable: true,
//                   labelPadding: EdgeInsets.symmetric(horizontal: 60),
//                   tabs: [
//                     Tab(
//                       child: Text(
//                         "List of items",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                     Tab(
//                       child: Text(
//                         "Expired items",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//                 child: TabBarView(
//               controller: tabController,
//               children: [
//                 ListView.builder(
//                     physics: BouncingScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: 10,
//                     itemBuilder: (context, index) {
//                       return Card(
//                         margin:
//                             EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//                         child: ListTile(
//                           /*leading: Icon(
//                             Icons.add,
//                             color: Colors.red,
//                           ),*/
//                           title: Text("List of Item: ${index + 1}"),
//                           /* onTap: () {
//                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => add_product));
//                           },*/
//                           trailing: Icon(
//                             Icons.edit,
//                             color: Colors.red,
//                           ),
//                         ),
//                       );
//                     }),
//                 ListView.builder(
//                     physics: BouncingScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: 10,
//                     itemBuilder: (context, index) {
//                       return Card(
//                           margin: EdgeInsets.symmetric(
//                               horizontal: 30, vertical: 10),
//                           child: ListTile(
//                             /*leading: Icon(
//                             Icons.add,
//                             color: Colors.red,
//                           ),*/
//                             title: Text("Expired Item: ${index + 1}"),
//                             trailing: Icon(
//                               Icons.delete,
//                               color: Colors.red,
//                             ),
//                           ));
//                     })
//               ],
//             ))
//           ],
//         ));
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gro_sense/utils/navigation.dart';
import 'package:intl/intl.dart';

import 'dashboard.dart';

class tabbarPage extends StatefulWidget {
  const tabbarPage({Key? key}) : super(key: key);

  tabbarPageState createState() => tabbarPageState();
}

class tabbarPageState extends State<tabbarPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  List<Map<String, dynamic>> userMap = [];
  bool isLoading = false;
  List productData = [];
  int? userId;

  @override
  void initState() {
    getData();
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    User? currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (int i = 0; i < value.size; i++) {
        userMap.add(value.docs[i].data());
        if (currentUser!.uid == (userMap[i]['uid'])) {
          userId = i;
          print("--------------userIndex---------" + userId.toString());
        }
      }

      if (userMap[userId!]['Add Product'] != null) {
        for (int i = 0; i < userMap[userId!]['Add Product'].length; i++) {
          productData.add(userMap[userId!]['Add Product'][i]);
        }
        print("product data------------------" + productData.length.toString());
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF6F6F6),
        appBar: AppBar(
          title: Text('List of products'),
          backgroundColor: Colors.green,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // passing this to our root
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyBottomNavigation()));
            },
          ),
        ),
        body: Column(
          children: [
            // SizedBox(
            //   height: 50,
            // ),
            // Text("Gro-Sense",
            //     style: TextStyle(
            //         color: Colors.white70,
            //         fontSize: 30,
            //         fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),

            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.green),
                  controller: tabController,
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(horizontal: 50),
                  tabs: [
                    Tab(
                      child: Text(
                        "List of items",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Expired items",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: productData.length,
                        itemBuilder: (context, index) {
                          return buildItem(context, productData[index]);
                        }),
                    ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: productData.length,
                        itemBuilder: (context, index) {
                          return buildItem1(context, productData[index]);
                        }),
                  ],
                ))
          ],
        ));
  }

  DateTime formatTimestamp(Timestamp timestamp) {
    var format = new DateFormat('y-MM-d'); // <- use skeleton here
    return timestamp.toDate();
  }

  Widget buildItem(BuildContext context, map) {
    print("-------------------------->>>>>" + map.toString());
    if (map != null) {
      var date = new DateTime.now();
      final difference =
          formatTimestamp(map['expiryDate']).difference(date).inDays;
      return difference < 0
          ? Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Text("No any expired products"),
      )
          : Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 26.0,
        ),
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        //margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
        width: MediaQuery.of(context).size.width,
        child: Text("No Data Found"),
      );
    }
  }

  Widget buildItem1(BuildContext context, map) {
    print("-------------------------->>>>>" + map.toString());
    if (map != null) {
      var date = new DateTime.now();
      final difference =
          formatTimestamp(map['expiryDate']).difference(date).inDays;
      return difference > -1
          ? Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        // child: Center(child: Text("No expired product")),
      )
          : Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 26.0,
        ),
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
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
        width: MediaQuery.of(context).size.width,
        child: Text("No Data Found"),
      );
    }
  }
}
