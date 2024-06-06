import 'dart:convert';

import 'package:bottom/models/note.dart';
import 'package:http/http.dart' as http;

class Notesservice {
  Future<List<Note>> getTask() async {
    Uri url =
        Uri.parse('https://fir-73d12-default-rtdb.firebaseio.com/addnote.json');
    final responce = await http.get(url);
    final data = jsonDecode(responce.body);
    List<Note> loadedTasks = [];
    data.forEach((key, value) {
      value['id'] = key;
      loadedTasks.add(Note.fromJson(value));
    });
    return loadedTasks;
  }

  Future<void> editTasks(String id, String title, String date) async {
    Uri url =
        Uri.parse('https://fir-73d12-default-rtdb.firebaseio.com/editnote.json');
    Map<String, dynamic> taskData = {
      'title': title,
      'date': date,
      'id': id,
    };

    await http.patch(url, body: taskData);
  }

  Future<Note?> addTask(String title, String date) async {
    Uri url =
        Uri.parse('https://fir-73d12-default-rtdb.firebaseio.com/addnote.json');
    Map<String, dynamic> taskData = {
      'title': title,
      'date': date,
    };

    final response = await http.post(url, body: jsonEncode(taskData));
    final data = jsonDecode(response.body);
    if (data != null) {
      taskData['id'] = data['name'];

      return Note.fromJson(taskData);
    }
    return null;
  }

  Future<void> isDelete(String id) async {
    Uri url =
        Uri.parse('https://fir-73d12-default-rtdb.firebaseio.com/editnote.json');
    await http.delete(url);
  }
}
