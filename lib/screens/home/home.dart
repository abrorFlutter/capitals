import 'package:botanika/main.dart';
import 'package:botanika/screens/home/widgets/word_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  bool _isCity = false;
  bool _isDark = false;
  String searchQuery = "Search query";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: _isSearching ? const BackButton() : Container(),
        title: _isSearching ? _buildSearchField() : const Text("Search data..."),
        actions: _buildActions(),
      ),
      body: const WordList(),
    );
  }


  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: "Search Data...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);

    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
    IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
      IconButton(onPressed: () {
        final mainProvider = Provider.of<MainProvider>(context, listen: false);
        mainProvider.change();
        _isCity = !_isCity;
      },
          icon: const Icon(Icons.change_circle_outlined)
      ),
      IconButton(onPressed: () {
          _isDark = !_isDark;
          ThemeStream.setTheme.add(_isDark);
          mainProvider.setDarkMode(_isDark);
      },
          icon: _isDark ? const Icon(Icons.dark_mode) : const Icon(Icons.dark_mode_outlined) ,
      ),
    ];
  }

  // Icon iconWidget( bool mode) {
  //   return
  // }

  void _startSearch() {
    ModalRoute.of(context)
        ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
      searchQuery = newQuery;
      upDateQuery(word: searchQuery);
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  void upDateQuery({String? word}) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.initList(word: word,isCity: _isCity);
  }

}
