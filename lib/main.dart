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
  // _saved Set 을 추가해 사용자 즐겨찾기 단어 쌍 저장, Set 중복 항목을 허용하지 않음
  final _saved = <WordPair>{};
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
        // ListView의 각 행 앞에 1 픽셀 높이의 구분선 위젯을 추가
        if (i.isOdd) {
          return const Divider();
        }

        final index = i ~/ 2;

        // 구분선 위젯을 제외한 ListView에 있는 단어 쌍을 모두 사용하고 나면, 10개를 더 생성하고 제안 목록에 추가합니다
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair wordPair) {
    // 이미 즐겨찾기에 추가되어 있지 않은지 확인
    final alreadySaved = _saved.contains(wordPair);
    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        style: _titleTextStyle,
      ),
      subtitle: Text(
        wordPair.asPascalCase,
        style: _subtitleTextStyle,
      ),
      // 즐겨찾기 icon 추가
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  RandomWordsState createState() => RandomWordsState();
}
