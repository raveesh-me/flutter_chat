import 'dart:convert';

import 'package:flutter/services.dart';

Future<dynamic> getLocalJsonAsObject(String ref) async {
  final String jsonString = await rootBundle.loadString(ref);
  return json.decode(jsonString);
}
