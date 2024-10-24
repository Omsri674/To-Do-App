import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<String> _links = [];
  List<bool> _done = [];
  final TextEditingController _controller = TextEditingController();

  void _addLink() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _links.add(_controller.text);
        _done.add(false);
        _controller.clear();
      });
    }
  }

  void _deleteLink(int index) {
    setState(() {
      _links.removeAt(index);
      _done.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'To-Do ',
          )),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Add Task',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _addLink(),
            ),
          ),
          ElevatedButton(
            onPressed: _addLink,

            child: Text('ADD'),

          ),
          Expanded(
            child: ListView.builder(
              itemCount: _links.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: IconButton(icon: _done[index]? (Icon(FontAwesomeIcons.check)):(Icon(FontAwesomeIcons.circleCheck)),
                    onPressed:() {
                    setState(()=>
                      _done[index] = !_done[index]
                    );
                    }),
                  title: Text(_links[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteLink(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
