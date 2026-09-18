import 'package:flutter/foundation.dart';

/// -----------------------------------------------------------------------
/// CP1 — Build ThirstyFilterController (Section 2)
/// -----------------------------------------------------------------------
/// This is the plain-Dart ChangeNotifier from the lecture's "before
/// Riverpod" section. It powers the filter switch on the Classic screen
/// (screens/legacy_plant_screen.dart) via a ListenableBuilder.
///
/// Do this:
///   1. Extend ChangeNotifier.
///   2. Add a private `bool _thirstyOnly = false;` field.
///   3. Add a public getter `thirstyOnly` that returns it.
///   4. Add a `toggle()` method that flips the value and calls
///      notifyListeners().
///
/// Definition of done: on the Classic screen, flipping the switch updates
/// only the switch/badge — nothing else on screen rebuilds. Try adding a
/// print() inside the build() of a sibling widget to prove it.
/// -----------------------------------------------------------------------
class ThirstyFilterController extends ChangeNotifier {
  // TODO (CP1): add the private field, getter, and toggle() method.
}
