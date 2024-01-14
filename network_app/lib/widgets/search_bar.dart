import 'package:flutter/material.dart';
import '../services/ip_check_api.dart';
import '../utils/website_names.dart';

class Search extends StatefulWidget {
  final Function(List<String>) onIPAddressesFetched; // Callback function
  final Function(String) onSelectWebsite;

  const Search({
    Key? key,
    required this.onIPAddressesFetched,
    required this.onSelectWebsite,
  }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  String selectedWebsite = '';
  List<String> websiteList = WebsiteNames.websiteList;
  bool _isLoading = false;

  void _handleSearch(String query) async {
    if (query.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      await fetchIPsFromAPI(widget.onIPAddressesFetched, query);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 200, right: 200, bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                hintText: 'Search for a website',
                hintStyle: TextStyle(color: Colors.white30),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                suffixIcon: PopupMenuButton<String>(
                  onSelected: (String value) {
                    setState(() {
                      selectedWebsite = value;
                      _searchController.text = value;
                      _handleSearch(value);
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return websiteList.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child:
                            Text(choice, style: TextStyle(color: Colors.white)),
                      );
                    }).toList();
                  },
                  icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                  color: Colors.grey[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Theme.of(context).hintColor),
                ),
              ),
              onSubmitted: (value) => _handleSearch(value),
            ),
          ),
          SizedBox(width: 10),
          _isLoading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).hintColor),
                  backgroundColor: Colors.grey[800],
                  strokeWidth: 5,
                )
              : IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: () => _handleSearch(_searchController.text),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(30),
                  // ),
                ),
        ],
      ),
    );
  }
}
