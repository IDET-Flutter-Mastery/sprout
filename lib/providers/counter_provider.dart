import 'package:flutter_riverpod/flutter_riverpod.dart';

/// -----------------------------------------------------------------------
/// QUICK CHALLENGE — Build a Riverpod Counter
/// -----------------------------------------------------------------------
/// Pairs with: screens/counter_challenge_screen.dart
///
/// Do this:
///   1. Extend Notifier<int>, with build() returning 0.
///   2. Add an increment() method that sets state = state + 1.
///   3. Register it below as counterProvider.
/// -----------------------------------------------------------------------
class CounterNotifier extends Notifier<int> {
  @override
  int build() {
    // TODO (Quick Challenge): return the initial value, 0.
    throw UnimplementedError('TODO (Quick Challenge): implement build()');
  }

  void increment() {
    // TODO (Quick Challenge): set state = state + 1.
  }
}

final counterProvider = NotifierProvider<CounterNotifier, int>(CounterNotifier.new);
