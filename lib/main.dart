import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: FlexThemeData.light(scheme: FlexScheme.aquaBlue),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.aquaBlue),
      home: const MyHomePage(title: 'News Feed'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final RssFeedItems = List<RssFeedItem>.generate(
        4,
        (int index) => RssFeedItem(
              title: "UN News ${index + 1}",
              subtitle: "Global perspective, human stories ${index + 1}",
              imageURL:
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Flag_of_the_United_Nations.svg/640px-Flag_of_the_United_Nations.svg.png",
            ),
        growable: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: RssFeedItems.length,
        itemBuilder: (context, index) => RssFeedItems[index],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Favorites',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class RssFeedItem extends StatelessWidget {
  // Widget (View) for Card Item
  final String title;
  final String subtitle;
  final String imageURL;

  const RssFeedItem(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.imageURL})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 8),
            Image.network(
              imageURL,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset('images/rss.png',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.contain);
              },
            ),
            ListTile(
              leading: Icon(Icons.rss_feed_outlined),
              title: Text(title),
              subtitle: Text(subtitle),
            ),
            // const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('ADD TO FAVORITES'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('READ'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
            // const Spacer(),
          ],
        ),
      ),
    );
  }
}
