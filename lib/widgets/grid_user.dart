import 'package:flutter/material.dart';
import 'package:flutter_yaho_quangdunglu/models/user_model.dart';
import 'package:flutter_yaho_quangdunglu/widgets/grid_item.dart';

class GridUser extends StatelessWidget {
  const GridUser({
    super.key,
    required this.listUser,
  });

  final List<UserModel> listUser;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(10),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.69,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return GridItem(user: listUser[index]);
          },
          childCount: listUser.length,
        ),
      ),
    );
  }
}
