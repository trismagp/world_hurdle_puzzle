import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_hurdle_puzzle/hurdle_provider.dart';

class WordHurldPage extends StatefulWidget {
  const WordHurldPage({super.key});

  @override
  State<WordHurldPage> createState() => _WordHurldPageState();
}

class _WordHurldPageState extends State<WordHurldPage> {
  @override
  void didChangeDependencies() {
    Provider.of<HurdleProvider>(context, listen: false).init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Word hurdle game')));
  }
}
