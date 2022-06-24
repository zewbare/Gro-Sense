import 'package:flutter/material.dart';

class tabbarPage extends StatefulWidget {
  const tabbarPage({Key? key}) : super(key: key);

  tabbarPageState createState() => tabbarPageState();
}


class tabbarPageState extends State<tabbarPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        /*appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('List Screen'),
        ),*/
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text("Gro-Sense",
                style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
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
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.green),
                  controller: tabController,
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(horizontal: 60),
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
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: ListTile(
                          /*leading: Icon(
                            Icons.add,
                            color: Colors.red,
                          ),*/
                          title: Text("List of Item: ${index+1}"),
                          trailing: Icon(Icons.edit, color: Colors.red,),
                        ),
                      );
                    }),
                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Card(
                        margin:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: ListTile(
                          /*leading: Icon(
                            Icons.add,
                            color: Colors.red,
                          ),*/
                          title: Text("Expired Item: ${index+1}"),
                          trailing: Icon(Icons.delete, color: Colors.red,),
                        )

                      );
                    })
              ],
            ))
          ],
        ));
  }
}
