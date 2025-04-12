import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_hurdle_puzzle/hurdle_provider.dart';
import 'package:world_hurdle_puzzle/keyboard_view.dart';
import 'package:world_hurdle_puzzle/wordle_view.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text('Word hurdle game')),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Consumer<HurdleProvider>(
                  builder:
                      (context, provider, child) => GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                            ),
                        itemCount: provider.hurdleBoard.length,
                        itemBuilder: (context, index) {
                          final wordle = provider.hurdleBoard[index];
                          return WordleView(wordle: wordle);
                        },
                      ),
                ),
              ),
            ),
            KeyboardView(),
          ],
        ),
      ),
    );
  }
}
