import 'package:flutter/material.dart';
import 'package:todo/database/tasks.dart';
import 'package:todo/widget.dart';

class TodoEdit extends StatefulWidget {
  final Tasks? task;
  const TodoEdit({
    Key? key,
    this.task,
  }) : super(key: key);

  @override
  State<TodoEdit> createState() => _TodoEditState();
}

class _TodoEditState extends State<TodoEdit> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descController.text = widget.task!.content;
    }

    return Scaffold(
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Header(title: widget.task != null ? 'Edit todo' : 'New Todo'),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Title'),
                    style: TextStyle(fontSize: 18),
                    onSubmitted: (value) {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: TextField(
                    controller: _descController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Description'),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_titleController.text.isNotEmpty &&
                        _descController.text.isNotEmpty) {
                      if (widget.task != null) {
                        TasksDatabaseHelper.instance.update(Tasks(
                            id: widget.task!.id,
                            title: _titleController.text,
                            content: _descController.text));
                      } else {
                        TasksDatabaseHelper.instance.add(Tasks(
                            title: _titleController.text,
                            content: _descController.text));
                      }
                      Navigator.pop(context, 'update');
                    }
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      width: scaleSize(200),
                      height: scaleSize(55),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        widget.task != null ? 'Save' : 'Add',
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
