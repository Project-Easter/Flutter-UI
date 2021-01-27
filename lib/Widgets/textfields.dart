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
          aspectRatio: 343 / 52,
          child: Container(
            child: TextFormField(
              key: ValueKey('confirm'),
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              enableSuggestions: false,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter with your confirmation code';
                }
                return null;
              },
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: 'Enter your confirmation code',
                hintStyle: GoogleFonts.poppins(
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
