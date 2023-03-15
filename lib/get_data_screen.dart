import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetDataScreen extends StatefulWidget {
  const GetDataScreen({Key? key}) : super(key: key);

  @override
  State<GetDataScreen> createState() => _GetDataScreenState();
}

class _GetDataScreenState extends State<GetDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get data Screen"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("student_list").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!.docs;
            return snap.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: snap.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 30,
                          ),
                          child: Column(
                            children: [
                              Text("Id  : ${snap[index]['id']}"),
                              Text("Name  : ${snap[index]['name']}"),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          } else {
            Container(
              height: 100,
              width: 100,
              color: Colors.pink,
            );

            return const Text("null");
          }
        },
      ),
    );
  }
}
