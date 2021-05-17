import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  String labelText = "";
  String hintText = "Search for books you love";
  Color color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (s) {},
      onTap: () {
        setState(() {
          color = Colors.white;
          hintText = "";
        });
      },
      autofocus: false,
      cursorColor: Colors.black87, // modified
      decoration: InputDecoration(
        labelText: 'Search for books you love',
        labelStyle: TextStyle(color: Colors.black54),
        filled: true,
        fillColor: color,
        hintText: hintText,
        prefixIcon: Icon(
          Icons.search,
          color: Color(0xFF666666),
          size: 20.0,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(40),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
          borderRadius: BorderRadius.circular(40),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF181926),
          ),
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }
}
