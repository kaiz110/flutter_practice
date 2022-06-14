import 'package:flutter/material.dart';
import 'package:todo/database/tasks.dart';
import 'package:todo/screens/calculator_home.dart';
import 'package:todo/screens/todo_edit.dart';
import 'package:todo/widget.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({Key? key}) : super(key: key);

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  Future<void> _navigateToEdit(BuildContext context, Tasks? task) async {
    final navi = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TodoEdit(
                  task: task,
                )));

    if (navi == 'update') {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 235, 235, 235),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            width: double.infinity,
            child: Stack(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Header(title: 'Todo'),
                      FutureBuilder<List<Tasks>>(
                        future: TasksDatabaseHelper.instance.getTasks(),
                        builder:
                            (context, AsyncSnapshot<List<Tasks>> snapshot) {
                          if (!snapshot.hasData) {
                            return const Text('Loading');
                          }

                          return snapshot.data!.isEmpty
                              ? CustomCard(
                                  name: 'Empty todo',
                                  desc:
                                      'press the float button on the bottom right of the screen to add a todo, after adding you can long tap to delete',
                                  onLongPressed: () {},
                                  onPressed: () {},
                                )
                              : ListView(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  children: snapshot.data!.map((task) {
                                    return CustomCard(
                                      name: task.title,
                                      desc: task.content,
                                      onLongPressed: () {
                                        setState(() {
                                          TasksDatabaseHelper.instance
                                              .remove(task.id!);
                                        });
                                      },
                                      onPressed: () {
                                        _navigateToEdit(context, task);
                                      },
                                    );
                                  }).toList(),
                                );
                        },
                      )
                    ]),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: GestureDetector(
                    onTap: () {
                      _navigateToEdit(context, null);
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 128, 89, 254),
                            Color.fromARGB(255, 103, 56, 255)
                          ], begin: Alignment(0, -1), end: Alignment(0, 1)),
                          color: Color.fromARGB(255, 115, 73, 254),
                          borderRadius: BorderRadius.circular(20)),
                      child:
                          const Icon(Icons.add, color: Colors.white, size: 50),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard(
      {Key? key,
      required this.name,
      required this.desc,
      required this.onPressed,
      required this.onLongPressed})
      : super(key: key);
  final String name;
  final String desc;
  final VoidCallback onPressed;
  final VoidCallback onLongPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      onLongPress: onLongPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                  color: Color(0xFF211551),
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 9),
              child: Text(desc,
                  style: TextStyle(fontSize: 16.0, color: Colors.black45)),
            ),
          ],
        ),
      ),
    );
  }
}
