import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddFireStoreScreen extends StatefulWidget {
  const AddFireStoreScreen({Key? key}) : super(key: key);

  @override
  State<AddFireStoreScreen> createState() => _AddFireStoreScreenState();
}

class _AddFireStoreScreenState extends State<AddFireStoreScreen> {
  String name = "";
  // List<Map<String, dynamic>> data = [
  //   {
  //     "name": "janki",
  //   },
  //   {
  //     "name": "kajal",
  //   },
  //   {
  //     "name": "kunj",
  //   },
  //   {
  //     "name": "riyu",
  //   },
  //   {
  //     "name": "kavu",
  //   },
  //   {
  //     "name": "nency",
  //   },
  //   {
  //     "name": "nirali",
  //   },
  //   {
  //     "name": "krishna",
  //   },
  // ];
  // addData() async {
  //   for (var element in data) {
  //     FirebaseFirestore.instance.collection("name_list").add(element);
  //     debugPrint("All Data added");
  //   }
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   addData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 30,
        ),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                labelText: "Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('student_list').snapshots(),
                builder: (context, snapshot) {
                  return (snapshot.connectionState == ConnectionState.waiting)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            var dataList = snapshot.data!.docs[index];
                            if (name.isEmpty) {
                              return ListTile(
                                title: Text('All List     :  ${dataList['name']}'),
                              );
                            }
                            if (dataList['name'].toString().startsWith(name.toLowerCase())) {
                              return ListTile(
                                title: Text("Name   :${dataList['name']}"),
                              );
                            }
                            return const SizedBox();
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                          itemCount: snapshot.data!.docs.length,
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
