import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, dynamic>> allUser = [
    {
      "name": "janki",
    },
    {
      "name": "kajal",
    },
    {
      "name": "kunj",
    },
    {
      "name": "riyu",
    },
    {
      "name": "kavu",
    },
    {
      "name": "nency",
    },
    {
      "name": "nirali",
    },
    {
      "name": "krishna",
    },
  ];

  List<Map<String, dynamic>> findList = [];
  @override
  void initState() {
    // TODO: implement initState
    findList = allUser;

    super.initState();
  }

  void showData(String enterData) {
    List<Map<String, dynamic>> result = [];
    if (enterData.isEmpty) {
      result = allUser;
    } else {
      result = allUser
          .where(
            (user) => user["name"].toLowerCase().contain(
                  enterData.toLowerCase(),
                ),
          )
          .toList();
    }
    setState(() {
      findList = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => showData(value),
              decoration: InputDecoration(
                labelText: "Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            findList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: findList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text("Name : ${findList[index]['name']}"),
                          ),
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
