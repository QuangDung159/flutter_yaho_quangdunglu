import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_yaho_quangdunglu/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/subjects.dart';

class MainViewModel {
  Future<List<UserModel>> fetchList(int page) async {
    try {
      final res =
          await http.get(Uri.parse('https://reqres.in/api/users?page=$page'));
      Iterable listUserJson = jsonDecode(res.body)['data'];

      List<UserModel> listUser = List<UserModel>.from(
        listUserJson.map(
          (e) => UserModel.fromJson(e),
        ),
      );

      return listUser;
    } catch (e, stack) {
      debugPrint('Error: ${e.toString()}');
      debugPrint(stack.toString());
      return [];
    }
  }

  final _displayGridSubject = BehaviorSubject<bool>();

  var onChangeDisplayType = StreamTransformer<bool, bool>.fromHandlers(
    handleData: (data, sink) {
      sink.add(!data);
    },
  );

  Stream<bool> get displayGridStream =>
      _displayGridSubject.stream.transform(onChangeDisplayType);
  Sink<bool> get displayGridSink => _displayGridSubject.sink;

  dispose() {
    _displayGridSubject.close();
  }
}
