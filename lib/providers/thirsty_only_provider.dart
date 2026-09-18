import 'package:flutter_riverpod/flutter_riverpod.dart';

/// -----------------------------------------------------------------------
/// thirstyOnlyProvider — DONE, no edits needed.
/// -----------------------------------------------------------------------
/// This is the Riverpod-native sibling of the ThirstyFilterController you
/// build by hand in CP1. Same idea (a boolean that can be toggled), but
/// expressed as a Notifier so it lives inside the ProviderScope instead of
/// as a manually-created object.
/// -----------------------------------------------------------------------
class ThirstyOnlyNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() {
    state = !state;
  }
}

final thirstyOnlyProvider =
    NotifierProvider<ThirstyOnlyNotifier, bool>(ThirstyOnlyNotifier.new);
