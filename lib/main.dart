import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random(); // Add this line.
    return new MaterialApp(
      title: 'StartupName Generator',
      home: new RandomWords(),
      // theme: new ThemeData.dark(),
      theme: new ThemeData(
        primaryColor: Color.fromRGBO(255, 0 , 0 , 1),
      ),
    );
  }
}

//mutable??
class RandomWords extends StatefulWidget {
  @override
  //creating mutable state for immutable RandomWords widget
  RandomWordsState createState() => RandomWordsState();
}

//mutable state for Stateful widget above
class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    //random word generator
    return new Scaffold(
      //impements the basic Material Design visual layout
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        // backgroundColor: Color.fromRGBO(23, 183, 76, 1),
        // Some widget properties take a single widget (child), and other properties, such as action, take an array of widgets (children), as indicated by the square brackets ([]).
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  //saving suggested word pairings
  final List<WordPair> _suggestions = <WordPair>[];
  //makes the font size larger
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  //This Set stores the word pairings that the user favorited. Set is preferred to List because a properly implemented Set does not allow duplicate entries.
  final Set<WordPair> _saved = new Set<WordPair>();

  //In here you are pushing a route to the navigator stack which will display a new page when the list button is clicked
  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles( 
            //The divideTiles() method of ListTile adds horizontal spacing between each ListTile. 
            context: context,
            tiles: tiles,
          ).toList(); //The divided variable holds the final rows, converted to a list by the convenience function, toList().
          return new Scaffold( 
            appBar: new AppBar(
              title: const Text('Saved Suggestions'),
               backgroundColor: Color.fromRGBO(23, 183, 76, 1),
            ),
            // The body of the new route consists of a ListView containing the ListTiles rows; each row is separated by a divider.
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }

  //function for buildign the list view that displays the word pairngs
  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        //itemBuilder places each suggestion into a ListTile row
        itemBuilder: (BuildContext _context, int i) {
          // Add a one-pixel-high divider widget before each row
          // in the ListView.
          if (i.isOdd) {
            return new Divider();
          }
          // The syntax "i ~/ 2" divides i by 2 and returns an
          // integer result.
          // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
          // This calculates the actual number of word pairings
          // in the ListView,minus the divider widgets.
          final int index = i ~/ 2;
          if (index >= _suggestions.length) {
            //generate 10 more word pairings when you reach the end of the list
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  /////////
  /////////
  /////////
  /////////
  Widget _buildRow(WordPair pair) {
    //check if the word is already saved in the favorites set
    final bool alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      // If a word entry has already been added to favorites, tapping it again removes it from favorites. When a tile has been tapped, the function calls setState() to notify the framework that state has changed.
      onTap: () {
        // In Flutter's reactive style framework, calling setState() triggers a call to the build() method for the State object, resulting in an update to the UI.
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}
