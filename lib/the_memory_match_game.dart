import 'package:flutter/material.dart';
import 'package:the_memory_match_game/ui/pages/startup_page.dart';

class TheMemoryMatchGame extends StatelessWidget {
  const TheMemoryMatchGame({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const StartUpPage(),
      title: 'The Match Game',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}
