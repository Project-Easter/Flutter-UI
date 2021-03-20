import 'package:books_app/Constants/genres.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Models/books.dart';

//------------Stack Overflow COde ----------------
class MultiSelectDialogItem<V> {
  const MultiSelectDialogItem(this.value, this.label);

  final V value;
  final String label;
}

class MultiSelectDialog<V> extends StatefulWidget {
  MultiSelectDialog({Key key, this.items, this.initialSelectedValues})
      : super(key: key);

  final List<MultiSelectDialogItem<V>> items;
  final Set<V> initialSelectedValues;

  @override
  State<StatefulWidget> createState() => _MultiSelectDialogState<V>();
}

class _MultiSelectDialogState<V> extends State<MultiSelectDialog<V>> {
  final _selectedValues = Set<V>();

  void initState() {
    super.initState();
    if (widget.initialSelectedValues != null) {
      _selectedValues.addAll(widget.initialSelectedValues);
    }
  }

  void _onItemCheckedChange(V itemValue, bool checked) {
    // print("Selected Item:${itemValue}");
    setState(() {
      if (checked) {
        _selectedValues.add(itemValue);
      } else {
        _selectedValues.remove(itemValue);
      }
    });
  }

  void _onCancelTap() {
    // Navigator.pop(context);
    Navigator.of(context).pop();
  }

  void _onSubmitTap() {
    // Navigator.pop(context);
    // print("Selected Item List:");
    // print(_selectedValues);
    //TODO:Convert type V to List<String>,PP-CN
    // for (V v in _selectedValues) {
    //   print(v);
    // }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
          onPressed: _onSubmitTap,
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

//------------Stack Overflow Code ----------------
class LocationRange extends StatefulWidget {
  @override
  _LocationRangeState createState() => _LocationRangeState();
}

class _LocationRangeState extends State<LocationRange> {
  double _currentSlidervalue = 10;
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
          value: _currentSlidervalue,
          min: 0,
          max: 40,
          onChanged: (double value) {
            setState(() {
              _currentSlidervalue = value;
            });
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

userPreferences(BuildContext context) {
//------------Stack Overflow CodeList ----------------
//------------Stack Overflow CodeList ----------------
  showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      barrierLabel: 'Animation',
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return UserPreference();
      });
}

//Form Builder

class UserPreference extends StatefulWidget {
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
        return MultiSelectDialog(
          items: genres.map<MultiSelectDialogItem<String>>((String val) {
            return MultiSelectDialogItem<String>(
                (i++).toString(), val.toString());
          }).toList(),
          initialSelectedValues: [1, j].toSet(),
        );
      },
    );
    print(selectedValues);
  }

  void myfunction() {}

  //
  // TextEditingController _author;
  // TextEditingController _book;
  final _author = TextEditingController();
  final _book = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: Center(
          child: Text(
            'User Preferences',
            style: GoogleFonts.muli(),
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Container(
          height: 300,
          width: 250,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                LocationRange(),
                TextFormField(
                  controller: _book,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: 'Favourite Book',
                    hintStyle: GoogleFonts.muli(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Book name cannot be empty';
                    }
                    return null;
                  },
                  onChanged: (v) {
                    print(v);
                  },
                  onSaved: (val) {
                    _book.text = val;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _author,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      hintText: 'Favourite Author',
                      hintStyle: GoogleFonts.muli()),
                  onSaved: (val) {
                    _author.text = val;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Author cannot be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
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
                print(_book.text);
                print(_author.text);
                try {
                  dynamic res = await Provider.of<Books>(context, listen: false)
                      .getRecommended(_book.text);
                  if (res != null) {
                    print(res);
                    Navigator.pop(context, false);
                  }
                } catch (e) {
                  print(e.toString());
                }
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
