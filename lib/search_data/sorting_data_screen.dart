import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SortingDataScreen extends StatefulWidget {
  const SortingDataScreen({Key? key}) : super(key: key);

  @override
  State<SortingDataScreen> createState() => _SortingDataScreenState();
}

class _SortingDataScreenState extends State<SortingDataScreen> {
  List searchList = [];

  Future<void> searchFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('student_list')
        .where(
          'name',
          isEqualTo: query,
          // isGreaterThanOrEqualTo: query
          // arrayContains: query,
        )
        .get();
    setState(() {
      searchList = result.docs.map((e) => e.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("particular Get Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (query) {
                searchFirebase(query);
              },
              decoration: InputDecoration(
                labelText: "Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
              itemCount: searchList.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: ListTile(
                      tileColor: Colors.green,
                      title: Text(" id  :${searchList[index]['id']}"),
                      subtitle: Text("Name  :${searchList[index]['name']}"),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
