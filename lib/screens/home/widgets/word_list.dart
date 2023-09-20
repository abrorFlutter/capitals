import 'package:botanika/screens/home/widgets/word_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main_provider.dart';
import '../../../models/database_helper.dart';
import '../../../utils/constants.dart';

class WordList extends StatefulWidget {
  const WordList({Key? key}) : super(key: key);

  @override
  State<WordList> createState() => _WordListState();
}

class _WordListState extends State<WordList> {


  @override
  void initState() {
    super.initState();
    loadDB();
  }

  Future<void> loadDB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoaded = prefs.getBool(Constants.Is_Database_Init) ?? false;

    if(!isLoaded) {
      await  DatabaseHelper.instance.loadDB(context);
    }
    upDateQuery();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Consumer<MainProvider>(builder: (context, data, child) {
            return Scrollbar(
              thickness: 12.0,
              child: ListView.builder(
                itemCount: data.words.length ?? 0,
                itemBuilder: (context, index) {
                  return WordItem(data.words[index],data.showCity);
                },
              ),
            );
            },
      ),
    );
}

  void upDateQuery({String? word,bool? isCity}) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.initList(word: word,isCity: isCity);
  }

}
