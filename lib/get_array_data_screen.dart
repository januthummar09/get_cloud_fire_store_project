import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetArrayDataScreen extends StatefulWidget {
  const GetArrayDataScreen({Key? key}) : super(key: key);

  @override
  State<GetArrayDataScreen> createState() => _GetArrayDataScreenState();
}

class _GetArrayDataScreenState extends State<GetArrayDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get data Screen"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('array_collection').snapshots(),
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
                              Text("Id  : ${snap[index]['number']}"),
                              Text("Name  : ${snap[index]['data']}"),
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
