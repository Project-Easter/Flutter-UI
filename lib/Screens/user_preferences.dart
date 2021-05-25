import 'package:books_app/Constants/genres.dart';
import 'package:books_app/Models/user.dart';
import 'package:books_app/Services/auth.dart';
import 'package:books_app/Services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Constants/genres.dart';

String uID = AuthService().getUID as String;
DatabaseService _databaseService = DatabaseService(uid: uID);

double sliderValue = 10.0;

class MultiSelectDialogItem<V> {
  const MultiSelectDialogItem(this.value, this.label);
  final V value;
  final String label;
}

class MultiSelectDialog<V> extends StatefulWidget {
  const MultiSelectDialog({Key key, this.items, this.initialSelectedValues})
      : super(key: key);

  final List<MultiSelectDialogItem<V>> items;
  final Set<V> initialSelectedValues;

  @override
  State<StatefulWidget> createState() => _MultiSelectDialogState<V>();
}

class _MultiSelectDialogState<V> extends State<MultiSelectDialog<V>> {
  final Set<V> _selectedValues = <V>{};

  @override
  void initState() {
    super.initState();
    if (widget.initialSelectedValues != null) {
      _selectedValues.addAll(widget.initialSelectedValues);
    }
  }

  void _onItemCheckedChange(V itemValue, bool checked) {
    setState(() {
      if (checked) {
        _selectedValues.add(itemValue);
      } else {
        _selectedValues.remove(itemValue);
      }
    });
  }

  void _onCancelTap() {
    Navigator.of(context).pop();
  }

  void _onSubmitTap(Set<V> selectedItems) async {
    final List items = selectedItems.toList();
    items.removeRange(0, 1);
    print(items);
    final List<String> selectedGenres = [];
    for (final dynamic element in items) {
      final String x = element.toString();
      print(genres[int.parse(x)]);
      selectedGenres.add(genres[int.parse(x)]);
    }

    print(selectedGenres);
    await _databaseService.updateGenres(selectedGenres);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    print('Select genres');
    print(uID);
    return AlertDialog(
      title: Text('Select Genres'),
      contentPadding: EdgeInsets.only(top: 12.0),
      content: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
          child: ListBody(
            children: widget.items.map(_buildItem).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          child: Text('CANCEL'),
          onPressed: _onCancelTap,
        ),
        MaterialButton(
          child: Text('OK'),
          onPressed: () => _onSubmitTap(_selectedValues),
        )
      ],
    );
  }

  Widget _buildItem(MultiSelectDialogItem<V> item) {
    final checked = _selectedValues.contains(item.value);
    return CheckboxListTile(
      value: checked,
      title: Text(item.label),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) => _onItemCheckedChange(item.value, checked),
    );
  }
}

// ignore: must_be_immutable
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
          max: 40,
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

// userPreferences(BuildContext context) {
// //------------Stack Overflow CodeList ----------------
// //------------Stack Overflow CodeList ----------------
//   showGeneralDialog(
//       barrierColor: Colors.black.withOpacity(0.5),
//       barrierLabel: 'Animation',
//       barrierDismissible: true,
//       transitionDuration: Duration(milliseconds: 500),
//       context: context,
//       pageBuilder: (context, animation1, animation2) {
//         return UserPreference();
//       });
// }

//Form Builder

class UserPreference extends StatefulWidget {
  final UserData userData;
  const UserPreference(this.userData);
  @override
  _UserPreferenceState createState() => _UserPreferenceState();
}

class _UserPreferenceState extends State<UserPreference> {
  void _showMultiSelect(BuildContext context) async {
    int i = 0;
    int j = i;
    final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        print('Building Items');
        i = 0;
        j = 1;
        return MultiSelectDialog(
          items: genres.map<MultiSelectDialogItem<String>>((String val) {
            return MultiSelectDialogItem<String>(
                (i++).toString(), val.toString());
          }).toList(),
          initialSelectedValues: {1, j},
        );
      },
    );
    //Tried Ressting the values

    print(selectedValues);
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final String favBook = widget.userData.preferences['favBook'] as String;
    final String favAuthor = widget.userData.preferences['favAuthor'] as String;
    final String location =
        widget.userData.preferences['locationRange'] as String;
    final double locationRange = double.parse(location);
    final _author = TextEditingController(text: favAuthor);
    final _book = TextEditingController(text: favBook);
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
                  onChanged: (v) {
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
                ButtonTheme(
                  minWidth: 220,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11)),
                      primary: Colors.blue,
                    ),
                    onPressed: () {
                      _showMultiSelect(context);
                    },
                    child: Text(
                      'Select Book Genres',
                      style: GoogleFonts.muli(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            onPressed: () async {
              //Validate Author and BookName
              if (_formKey.currentState.validate()) {
                //do some
                // print(_book.text);
                // print(_author.text);
                // print("Slider Value");
                // print(sliderValue.round());
                ///
                //Save Values to DB
                await _databaseService.updatePreferences(_book.text,
                    _author.text, sliderValue.round().toString() ?? '');
                //API Call To get prefered Book
                //TODO:Make a future builder in Dashboard and Update UI
                // try {
                //   dynamic res = Provider.of<Books>(context, listen: false)
                //       .getRecommended(_book.text);
                //   if (res != null) {
                //     Navigator.pop(context, false);
                //   }
                // } catch (e) {
                //   print(e.toString());
                // }
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
