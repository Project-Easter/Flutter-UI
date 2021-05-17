import 'dart:convert';
import 'package:flutter/services.dart';

class Config {
    static const String PATH = "assets/config.json";

    Future<Map<String, dynamic>> load() async {
        var config = await rootBundle.loadString(PATH);
        return jsonDecode(config) as Map<String, dynamic>;
    }
}