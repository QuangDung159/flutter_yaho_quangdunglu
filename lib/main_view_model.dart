import 'dart:async';
import 'dart:convert';

import 'package:flutter_yaho_quangdunglu/models/user_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class MainViewModel {
  final _listUserSubject = BehaviorSubject<List<UserModel>>();

  var getListUser =
      StreamTransformer<List<UserModel>, List<UserModel>>.fromHandlers(
    handleData: (data, sink) {
      sink.add(data);
    },
  );

  void fetchList() async {
    final res = await http.get(Uri.parse('https://reqres.in/api/users?page=1'));
    Iterable listUserJson = jsonDecode(res.body)['data'];
    List<UserModel> listUser = List<UserModel>.from(
      listUserJson.map(
        (e) => UserModel.fromJson(e),
      ),
    );
    listUserModelSink.add(listUser);
  }

  Stream<List<UserModel>> get listUserStream =>
      _listUserSubject.stream.transform(getListUser);
  Sink<List<UserModel>> get listUserModelSink => _listUserSubject.sink;

  dispose() {
    _listUserSubject.close();
  }

  MainViewModel() {
    Rx.combineLatest([_listUserSubject], (listUser) => listUser)
        .listen((event) {});
  }
}
