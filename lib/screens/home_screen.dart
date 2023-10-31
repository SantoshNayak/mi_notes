import 'package:flutter/material.dart';
import 'package:mi_notes/widgets/note_list.dart';

import 'note_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Notes'),
      ),
      body: NoteList(), // Replace with your NoteList widget
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the note editing screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return NoteScreen(); // Replace 'NoteScreen()' with the appropriate widget for note editing
              },
            ),
          );
          // Navigate to the note editing screen
          // You can use Navigator.push to navigate to NoteScreen
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
