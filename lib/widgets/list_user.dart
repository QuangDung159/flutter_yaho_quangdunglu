import 'package:flutter/material.dart';
import 'package:flutter_yaho_quangdunglu/models/user_model.dart';
import 'package:flutter_yaho_quangdunglu/widgets/list_item.dart';

class ListUser extends StatelessWidget {
  const ListUser({
    super.key,
    required this.listUser,
  });

  final List<UserModel> listUser;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ListItem(user: listUser[index]);
          },
          childCount: listUser.length,
        ),
      ),
    );
  }
}
