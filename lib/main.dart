import 'package:flutter/material.dart';
import 'package:flutter_yaho_quangdunglu/main_view_model.dart';
import 'package:flutter_yaho_quangdunglu/models/user_model.dart';
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
  bool _isGrid = true;

  final _mainViewMode = MainViewModel();
  final List<UserModel> _listUser = [];
  final ScrollController _controller = ScrollController();

  // static const double _endReachedThreshold = MediaQuery.of(context).size.height;
  static const int _itemsPerPage = 6;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
    fetchList(_page);
  }

  Future<void> fetchList(int page) async {
    _loading = true;

    List<UserModel> listUserFetched = await _mainViewMode.fetchList(page);
    setState(() {
      _listUser.addAll(listUserFetched);

      // if list fetched out of data => off indicator
      if (listUserFetched.length < _itemsPerPage) {
        _canLoadMore = false;
      }

      _loading = false;
    });
  }

  void _onScroll() {
    if (!_controller.hasClients || _loading) return;

    // check scroll to end
    final thresholdReached =
        _controller.position.extentAfter < MediaQuery.of(context).size.height;

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
    _mainViewMode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () => setState(() {
              _isGrid = !_isGrid;
            }),
            icon: Icon(_isGrid ? Icons.view_list_sharp : Icons.grid_view_sharp),
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: renderScrollView(),
    );
  }

  Widget renderScrollView() {
    if (_loading == false && _listUser.isEmpty) {
      return const Center(
        child: Text('List empty'),
      );
    }

    return CustomScrollView(
      controller: _controller,
      slivers: [
        _isGrid ? GridUser(listUser: _listUser) : ListUser(listUser: _listUser),
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
    );
  }
}
