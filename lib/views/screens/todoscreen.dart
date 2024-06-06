import 'package:bottom/controllers/taskscontroller.dart';
import 'package:bottom/models/task.dart';
import 'package:bottom/views/widgets/addtaskwidget.dart';
import 'package:bottom/views/widgets/editdialog.dart';
import 'package:bottom/views/widgets/taskswidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoScreenPage extends StatefulWidget {
  const TodoScreenPage({super.key});

  @override
  State<TodoScreenPage> createState() => _TodoScreenPageState();
}

class _TodoScreenPageState extends State<TodoScreenPage> {
  final TasksController taskController = TasksController();

  Future<void> addTask() async {
    final response = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        return const AddTaskWidget();
      },
    );

    if (response != null) {
      final String? task = response['title'];
      final String? date = response['date'];

      if (task != null && date != null) {
        await taskController.addTask(task, date);
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid task or date')),
        );
      }
    }
  }

  Future<void> isEdit(Task task) async {
    final response = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return Editdialog(title: task.title, date: task.date);
      },
    );
    if (response != null) {
      await taskController.editTasks(
          task.id, response['title'], response['date'], response['isDone']);
      setState(() {});
    }
  }

  Future<void> isDelete(Task task) async {
    taskController.isDelete(task.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: addTask,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 30,
              )),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_horiz_outlined))
        ],
      ),
      body: FutureBuilder<List<Task>>(
        future: taskController.list,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No tasks available!',
                style: GoogleFonts.abel(fontSize: 23, color: Colors.blue),
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final task = snapshot.data![index];
              return Taskswidget(
                task: task,
                isDelete: () => isDelete(task),
                isEdit: () => isEdit(task),
              );
            },
          );
        },
      ),
    );
  }
}
