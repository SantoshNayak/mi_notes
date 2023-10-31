import 'package:flutter/material.dart';
import 'package:mi_notes/data/database_helper.dart';
import 'package:mi_notes/models/note.dart';

class NoteScreen extends StatefulWidget {
  final Note? existingNote;

  NoteScreen({this.existingNote});

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingNote != null) {
      _titleController.text = widget.existingNote!.title;
      _contentController.text = widget.existingNote!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveNote();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Title'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(hintText: 'Note content'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveNote() async {
    final title = _titleController.text;
    final content = _contentController.text;

    if (widget.existingNote != null) {
      // Update an existing note
      await DatabaseHelper.instance.update({
        'id': widget.existingNote!.id,
        'title': title,
        'content': content,
      });
    } else {
      // Create a new note
      final note = Note(
        title: title,
        content: content,
      );

      final noteMap = {
        'title': note.title,
        'content': note.content,
      };
      await DatabaseHelper.instance.insert(noteMap);
      // Create a new note
      // await DatabaseHelper.instance.insert(Note(
      //   title: title,
      //   content: content,
      // ));
    }
  }
}
