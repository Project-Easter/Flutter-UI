import 'package:books_app/Constants/genres.dart';
import 'package:books_app/Services/auth.dart';
import 'package:books_app/Services/database_service.dart';
import 'package:books_app/Utils/backend/user_data_requests.dart';
import 'package:books_app/Utils/helpers.dart';
//import 'package:books_app/Utils/keys_storage.dart';
import 'package:books_app/providers/user.dart';
import 'package:chips_choice/chips_choice.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

String uID = FirebaseAuthService().getUID;
double sliderValue = 10.0;

class LocationRange extends StatefulWidget {
  dynamic locationRange;
  LocationRange(this.locationRange);

  @override
  _LocationRangeState createState() => _LocationRangeState();
}

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

// DatabaseService _databaseService = DatabaseService(uid: uID);

// class MultiSelectDialog<V> extends StatefulWidget {
//   final List<MultiSelectDialogItem<V>> items;

//   final Set<V> initialSelectedValues;
//   const MultiSelectDialog({Key key, this.items, this.initialSelectedValues})
//       : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _MultiSelectDialogState<V>();
// }

class MultiSelectDialogItem<V> {
  final V value;
  final String label;
  const MultiSelectDialogItem(this.value, this.label);
}

// ignore: must_be_immutable
class UserPreference extends StatefulWidget {
  final UserData userData;
  const UserPreference(this.userData);
  @override
  _UserPreferenceState createState() => _UserPreferenceState();
}

// class _MultiSelectDialogState<V> extends State<MultiSelectDialog<V>> {
//   final Set<V> _selectedValues = <V>{};

//   @override
//   Widget build(BuildContext context) {
//     print('Select genres');
//     print(uID);
//     return AlertDialog(
//       title: const Text('Select Genres'),
//       contentPadding: const EdgeInsets.only(top: 12.0),
//       content: SingleChildScrollView(
//         child: ListTileTheme(
//           contentPadding: const EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
//           child: ListBody(
//             children: widget.items.map(_buildItem).toList(),
//           ),
//         ),
//       ),
//       actions: <Widget>[
//         MaterialButton(
//           child: const Text('CANCEL'),
//           onPressed: _onCancelTap,
//         ),
//         MaterialButton(
//           child: const Text('OK'),
//           onPressed: () => _onSubmitTap(_selectedValues),
//         )
//       ],
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     if (widget.initialSelectedValues != null) {
//       _selectedValues.addAll(widget.initialSelectedValues);
//     }
//   }

//   Widget _buildItem(MultiSelectDialogItem<V> item) {
//     final bool checked = _selectedValues.contains(item.value);
//     return CheckboxListTile(
//       value: checked,
//       title: Text(item.label),
//       controlAffinity: ListTileControlAffinity.leading,
//       onChanged: (bool checked) => _onItemCheckedChange(item.value, checked),
//     );
//   }

//   void _onCancelTap() {
//     Navigator.of(context).pop();
//   }

//   void _onItemCheckedChange(V itemValue, bool checked) {
//     setState(() {
//       if (checked) {
//         _selectedValues.add(itemValue);
//       } else {
//         _selectedValues.remove(itemValue);
//       }
//     });
//   }

//   Future<void> _onSubmitTap(Set<V> selectedItems) async {
//     final List<dynamic> items = selectedItems.toList();
//     items.removeRange(0, 1);
//     print(items);
//     final List<String> selectedGenres = <String>[];
//     for (final dynamic element in items) {
//       final String x = element.toString();
//       print(genres[int.parse(x)]);
//       selectedGenres.add(genres[int.parse(x)]);
//     }

//     print(selectedGenres);
//     await _databaseService.updateGenres(selectedGenres);
//     Navigator.of(context).pop();
//   }
// }

class _UserPreferenceState extends State<UserPreference> {
  final TextEditingController _author = TextEditingController();
  final TextEditingController _book = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> tags = [];

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

  @override
  Widget build(BuildContext context) {
    final String favBook = widget.userData.preferences['favBook'] as String;
    final String favAuthor = widget.userData.preferences['favAuthor'] as String;
    final String location =
        widget.userData.preferences['locationRange'] as String;
    final double locationRange = double.parse(location);
    final TextEditingController _author =
        TextEditingController(text: favAuthor);
    final TextEditingController _book = TextEditingController(text: favBook);

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
                // const SizedBox(
                //   height: 10,
                // ),
                // ButtonTheme(
                //   minWidth: 220,
                //   height: 40,
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(11)),
                //       primary: Colors.blue,
                //     ),
                //     onPressed: () {
                //       // _showMultiSelect(context);
                //     },
                //     child: Text(
                //       'Select Book Genres',
                //       style: GoogleFonts.muli(
                //           color: Colors.white,
                //           fontSize: 15,
                //           fontWeight: FontWeight.w500),
                //     ),
                //   ),
                // ),
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
}