import 'package:bottom/models/course.dart';
import 'package:bottom/repostories/courserepository.dart';

class Coursescontroller {
  List<Course> _list = [];
  final courserepository = Courserepository();
  Future<List<Course>> getCourse() async {
    _list = await courserepository.getCourse();
    return [..._list];
  }
}
