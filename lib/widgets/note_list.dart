import 'package:flutter/material.dart';
import 'package:mi_notes/data/database_helper.dart';
import 'package:mi_notes/models/note.dart';
import 'package:mi_notes/screens/note_screen.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    // Load notes when the NoteList screen is initialized
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final noteMaps = await DatabaseHelper.instance.getNotes();
    final List<Note> notes = noteMaps.map((noteMap) => Note.fromMap(noteMap)).toList();
    if (mounted) {
      setState(() {
        // Update the notes and trigger a rebuild
        _notes = notes;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: _buildNoteList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteScreen(),
            ),
          );

          // Reload the notes after navigating back
          _loadNotes();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildNoteList() {
    if (_notes.isEmpty) {
      return Center(child: Text('No notes available.'));
    }

    return ListView.builder(
      itemCount: _notes.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_notes[index].title),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteScreen(existingNote: _notes[index]),
              ),
            );
          },
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteNote(_notes[index]);
            },
          ),
        );
      },
    );
  }

  Future<void> _deleteNote(Note note) async {
    await DatabaseHelper.instance.delete(note.id!);
    _loadNotes();
  }
}
