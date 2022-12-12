import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_todo/Screens/notes_List.dart';
import 'package:firebase_todo/Screens/view_notes.dart';
import 'package:firebase_todo/models/Item_model.dart';
import 'package:flutter/material.dart';

class SearchNotes extends StatefulWidget {
  List<Item> datas;
  SearchNotes({super.key, required this.datas});

  @override
  State<SearchNotes> createState() => _SearchNotesState();
}

class _SearchNotesState extends State<SearchNotes> {
  List<Item> searcheddata = [];

  @override
  void initState() {
    // TODO: implement initState

    // FirebaseFirestore.instance
    //     .collection(collectionName)
    //     .snapshots()
    //     .listen((records) {
    //   mapRecords(records);
    // });

    searcheddata = widget.datas;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.blue,
        title: const Text(
          'Search Notes',
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: searchController,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              onChanged: (value) {
                SearchFirebase(searchController.text);
              },
              decoration: InputDecoration(
                labelText: 'Search Notes',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: (() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => ViewNotes(
                              title: searcheddata[index].title,
                              content: searcheddata[index].content)),
                        ),
                      );
                    }),
                    child: ListTile(
                      title: Text(
                        searcheddata[index].title,
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        searcheddata[index].content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  );
                }),
                separatorBuilder: ((context, index) {
                  return const SizedBox(
                    height: 12,
                  );
                }),
                itemCount: searcheddata.length),
          ]),
        ),
      ),
    );
  }

  SearchFirebase(String searchText) {
    setState(() {
      searcheddata = widget.datas
          .where((item) => item.title
              .toLowerCase()
              .contains(searchText.trim().toLowerCase()))
          .toList();
    });
  }

  deleteRecords(String id) {
    FirebaseFirestore.instance.collection(collectionName).doc(id).delete();
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) async {
    var _list = records.docs
        .map(
          (item) => Item(
            id: item.id,
            title: item['title'],
            content: item['content'],
          ),
        )
        .toList();

    setState(() {
      basketItems = _list;
    });
  }
}
