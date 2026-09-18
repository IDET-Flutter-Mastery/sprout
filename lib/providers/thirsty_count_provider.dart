import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'plants_provider.dart';

/// -----------------------------------------------------------------------
/// FINAL EXERCISE (Take-Home) — Build a Derived Provider
/// -----------------------------------------------------------------------
/// Pairs with: the closing slides of the lecture.
///
/// Goal: prove you understand that providers can depend on other
/// providers, by deriving a simple count from two existing ones.
///
/// Do this:
///   1. Watch plantsProvider (an AsyncValue<List<Plant>>).
///   2. When it has data, count how many plants have `isThirsty == true`.
///   3. Return that count as a plain `int` (default to 0 while loading
///      or on error).
///   4. Display the count as a small badge next to the "Thirsty only"
///      switch in plant_list_screen.dart.
///   5. Bonus: hide the badge entirely when the count is 0.
/// -----------------------------------------------------------------------
final thirstyCountProvider = Provider<int>((ref) {
  // TODO (Final Exercise): derive the thirsty count from plantsProvider.
  throw UnimplementedError('TODO (Final Exercise): implement thirstyCountProvider');
});
