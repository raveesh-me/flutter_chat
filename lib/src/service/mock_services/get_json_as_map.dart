import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:simpleholmuskchat/src/helpers/logger.dart';

Future<dynamic> getLocalJsonAsObject(String ref) async {
  final String jsonString = await rootBundle.loadString(ref);
  final result = json.decode(jsonString);
  debugLog(
    message: result.toString(),
    name: 'getLocalJsonAsObject',
  );
}
