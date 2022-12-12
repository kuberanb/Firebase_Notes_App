import 'package:firebase_todo/Screens/create_notes.dart';
import 'package:flutter/material.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const CreateNotes()),
                  ),
                );
              },
              icon: const Icon(Icons.add)),
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
              return ListTile(
                title: Text(
                  'Title 1',
                ),
                subtitle: Text('1'),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 22,
                  ),
                ),
              );
            }),
            separatorBuilder: ((context, index) {
              return const SizedBox(
                height: 12,
              );
            }),
            itemCount: 20),
      ),
    );
  }
}
