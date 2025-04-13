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
            Consumer<HurdleProvider>(
              builder:
                  (context, provider, child) => KeyboardView(
                    excludedLetters: provider.excludedLetters,
                    onPressed: (value) {
                      provider.inputLetter(value);
                    },
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<HurdleProvider>(
                builder:
                    (context, provider, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            provider.deleteLetter();
                          },
                          child: const Text('Delete'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (!provider.isAValidWord) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Not a word in my dictionary'),
                                ),
                              );
                              return;
                            }
                            provider.submitWord();
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
