import 'package:botanika/models/word.dart';
import 'package:botanika/screens/details/details.dart';
import 'package:flutter/material.dart';

class WordItem extends StatelessWidget {
  final Word word;
  final bool showCity;
  const WordItem(this.word,this.showCity, { Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailsPage(word)));
      },
      child: Card(
        elevation: 8,
        margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                    showCity ? word.city! : word.country ?? "..",
                    style: const TextStyle(fontSize: 22),)),
              const Icon(Icons.chevron_right_outlined,size: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
