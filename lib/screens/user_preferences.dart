import 'package:books_app/constants/genres.dart';
//import 'package:books_app/utils/keys_storage.dart';
import 'package:books_app/providers/user.dart';
import 'package:books_app/services/auth.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double sliderValue = 10.0;
String uID = FirebaseAuthService().getUID;

class LocationRange extends StatefulWidget {
  dynamic locationRange;
  LocationRange(this.locationRange);

  @override
  _LocationRangeState createState() => _LocationRangeState();
}

class MultiSelectDialogItem<V> {
  final V value;
  final String label;
  const MultiSelectDialogItem(this.value, this.label);
}

class UserPreference extends StatefulWidget {
  final UserData userData;
  const UserPreference(this.userData);
  @override
  _UserPreferenceState createState() => _UserPreferenceState();
}

// ignore: must_be_immutable
class _LocationRangeState extends State<LocationRange> {
  double _currentSlidervalue = 10.0;
  String s;
  @override
  Widget build(BuildContext context) {
    s = _currentSlidervalue.toStringAsFixed(2);
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Set Location Range',
            style: GoogleFonts.poppins(fontSize: 15),
          ),
        ),
        Slider(
          label: _currentSlidervalue.round().toString(),
          value: widget.locationRange as double ?? _currentSlidervalue,
          min: 0,
          max: 50,
          onChanged: (double value) {
            setState(() {
              widget.locationRange = value;
              _currentSlidervalue = value;
            });
            sliderValue = value;
          },
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '$s km',
            style: GoogleFonts.poppins(),
          ),
        )
      ],
    );
  }
}

class _UserPreferenceState extends State<UserPreference> {
  final TextEditingController _author = TextEditingController();
  final TextEditingController _book = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> tags = [];

  @override
  Widget build(BuildContext context) {
    // final String favBook = widget.userData.preferences['favBook'] as String;
    // final String favAuthor = widget.userData.preferences['favAuthor'] as String;
    final String location =
        widget.userData.preferences['locationRange'] as String;
    final double locationRange = double.parse(location);
    // final TextEditingController _author =
    //     TextEditingController(text: favAuthor);
    // final TextEditingController _book = TextEditingController(text: favBook);

    return Form(
      key: _formKey,
      child: AlertDialog(
        title: Center(
          child: Text(
            'User Preferences',
            style: GoogleFonts.muli(),
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        // ignore: sized_box_for_whitespace
        content: Container(
          height: 300,
          width: 250,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                LocationRange(locationRange),
                TextFormField(
                  controller: _book,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.start,
                  // initialValue: favBook,
                  decoration: InputDecoration(
                    hintText: 'Favourite Book',
                    hintStyle: GoogleFonts.muli(),
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Book name cannot be empty';
                    }
                    return null;
                  },
                  onChanged: (String v) {
                    print(v);
                  },
                  onSaved: (String val) {
                    _book.text = val;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  // initialValue: favAuthor,
                  controller: _author,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      hintText: 'Favourite Author',
                      hintStyle: GoogleFonts.muli()),
                  onSaved: (String val) {
                    _author.text = val;
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Author cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Select Book genres', style: GoogleFonts.muli()),
                _genresChoice(),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            onPressed: () async {
              //Validate Author and BookName
              if (_formKey.currentState.validate()) {
                _onSubmitTap();
                _formKey.currentState.save();
                Navigator.pop(context);
              }
            },
            child: Text(
              'Save',
              style: GoogleFonts.muli(fontWeight: FontWeight.bold),
            ),
          ),
          MaterialButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: GoogleFonts.muli(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget _genresChoice() {
    return ChipsChoice<String>.multiple(
      value: tags,
      onChanged: (List<String> val) => setState(() => tags = val),
      choiceItems: C2Choice.listFrom<String, String>(
        source: genres,
        value: (i, v) => v,
        label: (i, v) => v,
      ),
      choiceStyle: const C2ChoiceStyle(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderColor: Colors.grey,
      ),
      wrapped: true,
    );
  }

  Future<void> _onSubmitTap() async {
    final List<dynamic> items = tags.toList();
    items.removeRange(0, 1);
    print(items);
    final List<String> selectedGenres = <String>[];
    for (final dynamic element in items) {
      final String x = element.toString();
      print(genres[int.parse(x)]);
      selectedGenres.add(genres[int.parse(x)]);
    }
    print(selectedGenres);
    // await _databaseService.updateGenres(selectedGenres);
  }
}
