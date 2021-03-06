import 'package:flutter/material.dart';
import 'package:hacker_news/src/blocs/comments_provider.dart';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/widgets/comment.dart';
import 'package:hacker_news/src/widgets/loading_container.dart';

class NewsDetails extends StatelessWidget {
  final int itemId;

  NewsDetails({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Deails'),
      ),
      body: buildBuild(bloc),
    );
  }

  buildBuild(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final itemFuture = snapshot.data[itemId];

        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!snapshot.hasData) {
              return Text('loading');
            }

            return buildList(itemSnapshot.data, snapshot.data);
            // return buildTitle(itemSnapshot.data);
          },
        );
      },
    );
  }

  buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final commentsList = item.kids.map((kidId) {
      return Comment(
        itemId: kidId,
        itemMap: itemMap,
        depth: 0,
      );
    }).toList();

    return ListView(
      children: <Widget>[buildTitle(item), ...commentsList],
    );
  }

  buildTitle(ItemModel item) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(10.0),
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
