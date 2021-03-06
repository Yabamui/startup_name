import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Startup Name Generator', home: RandomWords());
  }
}

class RandomWordsState extends State<RandomWords> {
  // Dart 언어에서는 식별자 앞에 밑줄을 붙이면 프라이빗 적용이 됩니다.
  final _suggestions = <WordPair>[];
  final _titleTextStyle = const TextStyle(fontSize: 20.0);
  final _subtitleTextStyle = const TextStyle(fontSize: 10.0);

  @override
  Widget build(BuildContext context) {
    // Scaffold는 기본적인 머티리얼 디자인 시각 레이아웃을 구현합니다.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        /*2*/
        if (i.isOdd) {
          return const Divider();
        }
        /*3*/
        final index = i ~/ 2;

        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair wordPair) {
    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        style: _titleTextStyle,
      ),
      subtitle: Text(
        wordPair.asPascalCase,
        style: _subtitleTextStyle,
      ),
      selectedTileColor: const Color(0x0000000a),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  RandomWordsState createState() => RandomWordsState();
}
