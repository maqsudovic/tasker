import 'dart:convert';

import 'package:bottom/models/course.dart';
import 'package:http/http.dart' as http;

class Courseservice {
  Future<List<Course>> getCourse() async {
    Uri url = Uri.parse(
        'https://fir-73d12-default-rtdb.firebaseio.com/course.json');
    final responce = await http.get(url);
    final data = jsonDecode(responce.body);
    List<Course> loadedcourses = [];
    data.forEach((key, value) {
      value['id'] = key;
      loadedcourses.add(Course.fromJson(value));
    });
   
    return loadedcourses;
  }
}
