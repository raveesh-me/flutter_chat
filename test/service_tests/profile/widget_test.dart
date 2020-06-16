import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:simpleholmuskchat/external/widget_test_extensions.dart';
import 'package:simpleholmuskchat/src/models/profile.dart';
import 'package:simpleholmuskchat/src/screens/home_screen/home_screen_profile_page.dart';

main() {
  group("User profile", () {
    testWidgets("profile page displays the user passed by the provider",
        (WidgetTester tester) async {
      final stubProfile = Profile(
        'id-by-provider',
        'name',
        'https://url.url',
      );
      await tester.pumpWidget(HomeScreenProfilePage()
          .wrapWithMaterialApp()
          .wrapWithMultiProvider(providers: [
        Provider<Profile>.value(value: stubProfile),
      ]));
      final pictureFinder = find.byType(Placeholder);
      final idFinder = find.text(stubProfile.toString());
      expect(pictureFinder, findsOneWidget);
      expect(idFinder, findsOneWidget);
    });
    testWidgets("There should be an edit button", (WidgetTester tester) async {
      await tester.pumpWidget(HomeScreenProfilePage()
          .wrapWithMaterialApp()
          .wrapWithMultiProvider(providers: [
        Provider.value(value: Profile('id', 'name', 'ava'))
      ]));
      final editIconFinder = find.byIcon(Icons.edit);
      expect(editIconFinder, findsOneWidget);
    });
    testWidgets("pressing the edit function should change the profile",
        (WidgetTester tester) async {
      final initialProfile = Profile('id', 'name', 'avatarUrl');
      final changedProfile = Profile('id2', 'name', 'avatarUrl');
      await tester.pumpWidget(HomeScreenProfilePage()
          .wrapWithMaterialApp()
          .wrapWithMultiProvider(
              providers: [Provider.value(value: initialProfile)]));
      final editButtonFinder = find.byIcon(Icons.edit);
      final initialTextFinder = find.text(initialProfile.toString());
      expect(initialTextFinder, findsOneWidget);
      expect(editButtonFinder, findsOneWidget);
      await tester.tap(editButtonFinder);
      await tester.pumpAndSettle();
      final changedTextFinder = find.text(changedProfile.toString());
      expect(initialTextFinder, findsNothing);
      expect(changedTextFinder, findsOneWidget);
    });
  });
}
