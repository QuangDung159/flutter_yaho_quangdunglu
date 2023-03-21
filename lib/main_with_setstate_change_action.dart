import 'package:flutter/material.dart';
import 'package:flutter_yaho_quangdunglu/main_view_model.dart';
import 'package:flutter_yaho_quangdunglu/models/user_model.dart';
import 'package:flutter_yaho_quangdunglu/widgets/grid_item.dart';
import 'package:flutter_yaho_quangdunglu/widgets/grid_user.dart';
import 'package:flutter_yaho_quangdunglu/widgets/list_user.dart';

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
  int _page = 1;
  bool _canLoadMore = true;
  bool _loading = true;

  final _mainViewModel = MainViewModel();
  final List<UserModel> _listUser = [];
  final ScrollController _controller = ScrollController();

  static const double _endReachedThreshold = 200;
  static const int _itemsPerPage = 6;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
    fetchList(_page);
  }

  Future<void> fetchList(int page) async {
    _loading = true;

    List<UserModel> listUserFetched = await _mainViewModel.fetchList(page);
    setState(() {
      _listUser.addAll(listUserFetched);

      if (listUserFetched.length < _itemsPerPage) {
        _canLoadMore = false;
      }

      _loading = false;
    });
  }

  void _onScroll() {
    if (!_controller.hasClients || _loading) return;

    final thresholdReached =
        _controller.position.extentAfter < _endReachedThreshold;

    if (thresholdReached) {
      fetchList(_page + 1);
      setState(() {
        _page += 1;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _mainViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          StreamBuilder<bool>(
            stream: _mainViewModel.displayGridStream,
            builder: (context, snapshot) {
              bool isGrid = snapshot.hasData ? snapshot.data! : true;

              return IconButton(
                onPressed: () => _mainViewModel.displayGridSink.add(isGrid),
                icon: Icon(
                  isGrid ? Icons.view_list_sharp : Icons.grid_view_sharp,
                ),
              );
            },
          )
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        controller: _controller,
        slivers: [
          StreamBuilder<bool>(
            stream: _mainViewModel.displayGridStream,
            builder: (context, snapshot) {
              bool isGrid = snapshot.hasData ? snapshot.data! : true;
              if (isGrid) {
                return GridUser(listUser: _listUser);
              } else {
                return ListUser(listUser: _listUser);
              }
            },
          ),
          SliverToBoxAdapter(
            child: _canLoadMore
                ? Container(
                    padding: const EdgeInsets.only(bottom: 16),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  )
                : const SizedBox(
                    height: 16,
                  ),
          )
        ],
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
