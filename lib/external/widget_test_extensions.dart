import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

extension WidgetTestExtensions on Widget {
  Widget wrapWithMaterialApp() => MaterialApp(
        home: this,
      );
  Widget wrapWithMultiProvider({@required List<SingleChildWidget> providers}) =>
      MultiProvider(
        providers: providers,
        child: this,
      );
}
