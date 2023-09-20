import 'package:botanika/models/word.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main_provider.dart';

class DetailsPage extends StatelessWidget {
  final Word word;
  const DetailsPage(this.word,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(word.country ?? "..." ),
      ),
      body: Consumer<MainProvider>(builder: (context, data, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(),
                Text( data.showCity ? 'Country:' : "Capital:", style: const TextStyle(fontSize: 30),),
                const SizedBox(height: 12,),
                Text(data.showCity ? word.country! : word.city ?? "...",style: const TextStyle(fontSize: 30),),
              ],
            ),
          ],
        );
      }),
    );
  }
}
