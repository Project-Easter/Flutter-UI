import 'package:books_app/constants/genres.dart';
import 'package:flutter/material.dart';

class MultipleChipChoice extends StatefulWidget {
  MultipleChipChoice(
      {Key? key,
      required this.value,
      required this.onChanged,
      required this.selected})
      : super(key: key);
  final List<String> value;
  void Function(List<String>) onChanged;
  dynamic selected;
  @override
  State<MultipleChipChoice> createState() => _MultipleChipChoiceState();
}

class _MultipleChipChoiceState extends State<MultipleChipChoice> {
  Map<String, bool> map = {for (String item in genres) item: false};
  late List<String> value = widget.value;
  List<String> tags = <String>[];

  @override
  void initState() {
    super.initState();
    getSelectedTags();
  }

  void getSelectedTags() {
    for (String element in widget.selected.cast<String>()) {
      map.update(element, (bool value) => true);
    }
  }

  void updateTags() {
    tags.clear();
    map.forEach((String key, bool value) {
      if (value) {
        tags.add(key);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 3.0,
        runSpacing: 2.0,
        children: genres
            .map((String e) => ChoiceChip(
                  backgroundColor: Colors.white,
                  selectedColor: Colors.grey,
                  labelStyle: const TextStyle(color: Colors.black),
                  label: Text(e),
                  onSelected: (bool val) {
                    map[e] = val;
                    setState(() {
                      updateTags();
                    });
                    widget.onChanged.call(tags);
                  },
                  selected: map[e]!,
                ))
            .toList());
  }
}
