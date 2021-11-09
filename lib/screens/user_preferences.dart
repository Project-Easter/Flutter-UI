import 'package:books_app/constants/colors.dart';
import 'package:books_app/constants/genres.dart';
import 'package:books_app/providers/user.dart';
import 'package:books_app/services/auth.dart';
import 'package:books_app/services/database_service.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
// import 'package:chips_choice/chips_choice.dart';
// import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String uID = FirebaseAuthService().getUID;
DatabaseService _databaseService = DatabaseService(uid: uID);

class GenreChoice extends StatefulWidget {
  // const GenreChoice({ Key? key }) : super(key: key);

  @override
  _GenreChoiceState createState() => _GenreChoiceState();
}

class UserPreference extends StatefulWidget {
  final UserData? userData;
  const UserPreference(this.userData);
  @override
  _UserPreferenceState createState() => _UserPreferenceState();
}

class _GenreChoiceState extends State<GenreChoice> {
  List<String> tags = <String>[];
  @override
  Widget build(BuildContext context) {
    print('*******');
    // print(_author.text);
    // print(a);
    print(tags);
    // print(_user.value)

    return ChipsChoice<String>.multiple(
      value: tags,
      onChanged: (List<String> val) => setState(() {
        tags = val;
        // a = a;
        // b = b;
      }),
      choiceItems: C2Choice.listFrom<String, String>(
        source: genres,
        value: (int i, String v) => v,
        label: (int i, String v) => v,
        tooltip: (int i, String v) => v,
      ),
      choiceStyle: const C2ChoiceStyle(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderColor: Colors.green,
      ),
      choiceActiveStyle: const C2ChoiceStyle(
        color: blackButton,
      ),
      wrapped: true,
    );
  }
}

class _UserPreferenceState extends State<UserPreference> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // final TextEditingController _author = TextEditingController();
  // final TextEditingController _book = TextEditingController();

  List<String> tags = <String>[];
  String a = '';
  String b = '';

  @override
  Widget build(BuildContext context) {
    String favBook;
    String favAuthor;
    // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    if (a == '' && b == '') {
      favBook = widget.userData!.preferences!['favBook'] as String;
      favAuthor = widget.userData!.preferences!['favAuthor'] as String;
      dynamic data = widget.userData!.preferences!['genres'].cast<String>();
      List<String> genres = data
          .toString()
          .substring(1, data.toString().length - 1)
          .split(',')
          .toList();
      for (int i = 0; i < genres.length; i++) {
        final String ele = genres[i].trim();
        tags.add(ele);
      }
      print(genres);
      a = favBook;
      b = favAuthor;
    } else {
      favBook = a;
      favAuthor = b;
    }
    // final String? favBook = widget.userData!.preferences!['favBook'] as String?;
    // final String? favAuthor =
    // widget.userData!.preferences!['favAuthor'] as String?;
    // final String location =
    //     widget.userData.preferences['locationRange'] as String;

    final TextEditingController _author =
        TextEditingController(text: favAuthor);
    final TextEditingController _book = TextEditingController(text: favBook);

    return Form(
      key: _formKey,
      child: AlertDialog(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Center(
          child: Text(
            'User Preferences',
            style:
                GoogleFonts.lato(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        // ignore: sized_box_for_whitespace
        content: Container(
          height: 320,
          width: 250,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _book,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: 'Favourite Book',
                    fillColor: Theme.of(context).colorScheme.primary,
                    hintStyle: GoogleFonts.lato(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Book name cannot be empty';
                    }
                    return null;
                  },
                  onChanged: (String v) {
                    a = v;
                    print(v);
                  },
                  onSaved: (String? val) {
                    _book.text = val!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _author,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      hintText: 'Favourite Author',
                      hintStyle: GoogleFonts.lato(
                          color: Theme.of(context).colorScheme.primary)),
                  onSaved: (String? val) {
                    _author.text = val!;
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Author cannot be empty';
                    }
                    return null;
                  },
                  onChanged: (String v) {
                    b = v;
                    // _author.text=v;
                    print(v);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Select Book genres', style: GoogleFonts.lato()),
                // _genresChoice(),
                Builder(builder: (BuildContext ctx) {
                  return ChipsChoice<String>.multiple(
                    value: tags,
                    onChanged: (List<String> val) => setState(() {
                      tags = val;
                      a = a;
                      b = b;
                    }),
                    choiceItems: C2Choice.listFrom<String, String>(
                      source: genres,
                      value: (int i, String v) => v,
                      label: (int i, String v) => v,
                      tooltip: (int i, String v) => v,
                    ),
                    choiceStyle: const C2ChoiceStyle(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderColor: Colors.green,
                    ),
                    choiceActiveStyle: const C2ChoiceStyle(
                      color: blackButton,
                    ),
                    wrapped: true,
                  );
                }),

                // GenreChoice(),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            onPressed: () async {
              //Validate Author and BookName
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                _onSubmitTap();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('User preferences have been saved',
                        style: TextStyle(color: blackButton)),
                    duration: Duration(seconds: 3),
                  ));
                }
              }
            },
            child: Text(
              'Save',
              style: GoogleFonts.lato(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
          ),
          MaterialButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: GoogleFonts.lato(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _onSubmitTap() async {
    final List<dynamic> items = tags.toList();

    final List<String> selectedGenres = <String>[];
    for (final dynamic element in items) {
      final String x = element.toString();

      selectedGenres.add(x);
    }

    await _databaseService.updateGenres(selectedGenres);
    await _databaseService.updatePreferences(b, a);
    Navigator.pop(context);
  }
}
