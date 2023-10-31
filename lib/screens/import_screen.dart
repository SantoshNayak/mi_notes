import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'dart:io';

class ImportScreen extends StatefulWidget {
  @override
  _ImportScreenState createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  Future<void> importNotes() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['json']);

    if (result != null) {
      String content = await File(result.files.single.path!).readAsString(); // Use null assertion operator here
      List<dynamic> notesData = json.decode(content);
      // Process and save the notes to the database
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Import Notes'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: importNotes,
          child: Text('Import JSON'),
        ),
      ),
    );
  }
}
