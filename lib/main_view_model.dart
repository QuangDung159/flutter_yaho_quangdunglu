import 'dart:async';
import 'dart:convert';

import 'package:flutter_yaho_quangdunglu/models/user_model.dart';
import 'package:http/http.dart' as http;

class MainViewModel {
  Future<List<UserModel>> fetchList(int page) async {
    final res =
        await http.get(Uri.parse('https://reqres.in/api/users?page=$page'));
    Iterable listUserJson = jsonDecode(res.body)['data'];
    List<UserModel> listUser = List<UserModel>.from(
      listUserJson.map(
        (e) => UserModel.fromJson(e),
      ),
    );
    return listUser;
  }

  dispose() {}
}
