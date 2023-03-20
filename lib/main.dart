import 'package:flutter/material.dart';
import 'package:flutter_yaho_quangdunglu/main_view_model.dart';
import 'package:flutter_yaho_quangdunglu/models/user_model.dart';
import 'package:flutter_yaho_quangdunglu/widgets/grid_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final mainViewMode = MainViewModel();

  @override
  void initState() {
    super.initState();

    mainViewMode.fetchList();
  }

  @override
  void dispose() {
    super.dispose();

    mainViewMode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.grey[100],
      body: StreamBuilder(
        stream: mainViewMode.listUserStream,
        builder: (context, snapshot) {
          List<UserModel>? listUser = snapshot.data;

          return GridView.count(
            childAspectRatio: 0.69,
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 20,
            ),
            crossAxisCount: 2,
            primary: false,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: renderListItem(listUser),
          );
        },
      ),
    );
  }

  List<Widget> renderListItem(List<UserModel>? listUser) {
    List<Widget> listRendered = [];
    if (listUser == null || listUser.isEmpty) {
      listRendered.add(
        const Text('List empty'),
      );
    } else {
      for (var element in listUser) {
        listRendered.add(
          GridItem(
            user: element,
          ),
        );
      }
    }

    return listRendered;
  }
}
