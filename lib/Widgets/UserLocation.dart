import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget searchBar() {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _confirm = TextEditingController();
  return Form(
    key: _formKey,
    child: Column(
      children: [
        AspectRatio(
          aspectRatio: 300 / 55,
          child: Container(
            child: TextFormField(
              key: ValueKey('Location'),
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              enableSuggestions: false,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your Location';
                }
                return null;
              },
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search_rounded),
                hintText: 'Enter your Location',
                hintStyle: GoogleFonts.muli(
                  fontSize: 14,
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.circular(12)),
                contentPadding: EdgeInsets.all(10),
              ),
              onTap: () {},
              onSaved: (value) {
                _confirm.text = value;
              },
            ),
          ),
        ),
      ],
    ),
  );
}
