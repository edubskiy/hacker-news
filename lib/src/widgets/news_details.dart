import 'package:flutter/material.dart';

class NewsDetails extends StatelessWidget {
  final int itemId;

  NewsDetails({this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deails'),
      ),
      body: Text('id $itemId'),
    );
  }
}
