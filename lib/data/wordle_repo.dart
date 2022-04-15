import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<String>> loadwords(int wordlength) async {
  final data =
      await rootBundle.loadString("assets/${wordlength}-letter-words.json");
  return (jsonDecode(data) as List<String>);
}
