import 'dart:developer';

import 'package:flutter/foundation.dart';

/// Used instead of print statements. Print statements don't go well with xcode
/// debugger
debugLog({@required String message, @required String name}) {
  log(
    message,
    name: name,
    stackTrace: StackTrace.current,
  );
}

/// TODO: Implement something like a production log with [sentry.io]
