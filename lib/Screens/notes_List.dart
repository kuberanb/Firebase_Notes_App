import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_todo/Screens/create_notes.dart';
import 'package:firebase_todo/Screens/search_notes.dart';
import 'package:firebase_todo/Screens/view_notes.dart';
import 'package:firebase_todo/models/Item_model.dart';
import 'package:flutter/material.dart';

const collectionName = 'basket_items';

List<Item> basketItems = [];

class NotesList extends StatefulWidget {
  const NotesList({super.key});

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  void initState() {
    fetchRecords();
    FirebaseFirestore.instance
        .collection(collectionName)
        .snapshots()
        .listen((records) {
      mapRecords(records);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: ((context) => SearchNotes(datas: basketItems)),),);
            },
            icon: const Icon(
              Icons.search,
              size: 25,
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const CreateNotes()),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                size: 25,
              )),
        ],
        title: const Text(
          'Notes App',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: ListView.separated(
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: (() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => ViewNotes(
                          title: basketItems[index].title,
                          content: basketItems[index].content)),
                    ),
                  );
                }),
                child: ListTile(
                  title: Text(
                    basketItems[index].title,
                    style: const TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(
                    basketItems[index].content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      deleteRecords(basketItems[index].id);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 22,
                    ),
                  ),
                ),
              );
            }),
            separatorBuilder: ((context, index) {
              return const SizedBox(
                height: 12,
              );
            }),
            itemCount: basketItems.length),
      ),
    );
  }

  fetchRecords() async {
    var records =
        await FirebaseFirestore.instance.collection(collectionName).get();
    mapRecords(records);
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

  deleteRecords(String id) {
    FirebaseFirestore.instance.collection(collectionName).doc(id).delete();
  }
}
