import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_todo/models/Item_model.dart';
import 'package:flutter/material.dart';

const collectionName = 'basket_items';


class CreateNotes extends StatelessWidget {
  const CreateNotes({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    final _formKey = new GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Create Notes',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: ((value) {
                    if (value == null) {
                      return null;
                    } else if (value.isEmpty) {
                      return "Enter Title";
                    }
                  }),
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: ((value) {
                    if (value == null) {
                      return null;
                    } else if (value.isEmpty) {
                      return "Enter Content";
                    }
                  }),
                  //  expands: true,
                  minLines: 1,
                  maxLines: 200,
                  controller: contentController,
                  decoration: InputDecoration(
                    labelText: 'content',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      addItem(titleController.text, contentController.text);
                      Navigator.of(context).pop();

                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
            
          ),
        ),
      ),
    );


  }
 addItem(String title, String content){
    
  var item = Item(id: '', title:title, content: content);

    FirebaseFirestore.instance.collection(collectionName).add(item.toJson());
  }
 
}
