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
    );
  }
}

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
    return new Scaffold ( //impements the basic Material Design visual layout 
      appBar: new AppBar(
        title: new Text('Startup Name Generator',)
      ),
      body:_buildSuggestions(),
    );
  }
  //saving suggested word pairings
  final List<WordPair> _suggestions = <WordPair>[];
  //makes the font size larger
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

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
      }
    );
  }
  /////////
  /////////
  /////////
  /////////
  Widget _buildRow(WordPair pair) {
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style:_biggerFont,
      ),
    );
  }
}
