import 'package:books_app/Models/books.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FilterItems extends StatefulWidget {
  @override
  _FilterItemsState createState() => _FilterItemsState();
}

class _FilterItemsState extends State<FilterItems> {
  String selectedValue;
  //Clean up, make this stateless.
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: <Widget>[
        buildFilterItems('Sort title A-Z', Provider.of<Books>(context).sortAZ),
        buildFilterItems('Sort title Z-A', Provider.of<Books>(context).sortZA),
        buildFilterItems(
            'Sort by author', Provider.of<Books>(context).sortAuthor),
        buildFilterItems(
            'Sort by rating', Provider.of<Books>(context).sortRating),
      ],
    );
  }

  GestureDetector buildFilterItems(String text, Function sort) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        sort();
        setState(() {
          selectedValue = text;
        });
        // Navigator.pop(context);
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
            Radio(
                value: text,
                groupValue: selectedValue,
                activeColor: selectedValue == text ? Colors.black87 : null,
                onChanged: (dynamic s) {
                  sort();
                  setState(() {
                    selectedValue = s as String;
                  });
                  // Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
