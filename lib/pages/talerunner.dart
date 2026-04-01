import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple ToDo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> tasks = [];

  void addTask() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      tasks.add({
        "title": _controller.text,
        "done": false,
      });
      _controller.clear();
    });
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index]["done"] = !tasks[index]["done"];
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("📋 To-Do App"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "เพิ่มงาน...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addTask,
                  child: Text("เพิ่ม"),
                )
              ],
            ),
          ),
          Expanded(
            child: tasks.isEmpty
                ? Center(child: Text("ยังไม่มีงาน 😴"))
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        child: ListTile(
                          title: Text(
                            tasks[index]["title"],
                            style: TextStyle(
                              decoration: tasks[index]["done"]
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          leading: Checkbox(
                            value: tasks[index]["done"],
                            onChanged: (_) => toggleTask(index),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteTask(index),
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}