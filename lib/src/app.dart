import 'package:flutter/material.dart';
import 'package:hacker_news/src/blocs/stories_provider.dart';
import 'package:hacker_news/src/screens/news_list.dart';
import 'package:hacker_news/src/widgets/news_details.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        title: 'News!',
        onGenerateRoute: routes,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        return NewsList();
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        return NewsDetails();
      });
    }
  }
}