import 'package:flutter/material.dart';
import 'package:hacker_news/src/models/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return Text('Still loading comment');
        }

        final item = snapshot.data;
        final children = <Widget>[
          ListTile(
            title: Text(item.text),
            subtitle: item.by == '' ? Text('Deleted') : Text(item.by),
            contentPadding:
                EdgeInsets.only(right: 16.0, left: (depth + 1) * 16.0),
          ),
          Divider()
        ];

        snapshot.data.kids.forEach((kidId) {
          children.add(Comment(
            itemId: kidId,
            itemMap: itemMap,
            depth: depth + 1,
          ));
        });

        return Column(children: children);
      },
    );
  }
}
