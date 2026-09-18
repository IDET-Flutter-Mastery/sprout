/// -----------------------------------------------------------------------
/// Plant model — DONE, no edits needed.
/// -----------------------------------------------------------------------
/// A single houseplant tracked by Sprout. `isThirsty` is derived from how
/// long it has been since `lastWatered`, so the "thirsty" badge updates
/// itself as time passes — no manual bookkeeping required.
/// -----------------------------------------------------------------------
class Plant {
  final String id;
  final String name;
  final String emoji;
  final DateTime lastWatered;
  final Duration wateringInterval;

  const Plant({
    required this.id,
    required this.name,
    required this.emoji,
    required this.lastWatered,
    this.wateringInterval = const Duration(days: 4),
  });

  bool get isThirsty =>
      DateTime.now().difference(lastWatered) > wateringInterval;

  int get daysSinceWatered =>
      DateTime.now().difference(lastWatered).inDays;

  Plant copyWith({
    String? id,
    String? name,
    String? emoji,
    DateTime? lastWatered,
    Duration? wateringInterval,
  }) {
    return Plant(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      lastWatered: lastWatered ?? this.lastWatered,
      wateringInterval: wateringInterval ?? this.wateringInterval,
    );
  }
}
