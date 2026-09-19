/// -----------------------------------------------------------------------
/// PlantSpecies — DONE, no edits needed.
/// -----------------------------------------------------------------------
/// A small catalog of plant "types" you can pick from when adding a new
/// plant. Each one carries its own emoji and a realistic watering
/// interval, so a Cactus and a Fern don't dry out at the same rate.
/// -----------------------------------------------------------------------
class PlantSpecies {
  const PlantSpecies(this.label, this.emoji, this.wateringInterval);

  final String label;
  final String emoji;
  final Duration wateringInterval;
}

const List<PlantSpecies> kPlantSpecies = [
  PlantSpecies('Pothos', '\u{1F33F}', Duration(days: 7)),
  PlantSpecies('Succulent', '\u{1FAB4}', Duration(days: 14)),
  PlantSpecies('Basil', '\u{1F331}', Duration(days: 3)),
  PlantSpecies('Fern', '\u{1F340}', Duration(days: 5)),
  PlantSpecies('Cactus', '\u{1F335}', Duration(days: 18)),
  PlantSpecies('Orchid', '\u{1F338}', Duration(days: 6)),
  PlantSpecies('Sunflower', '\u{1F33B}', Duration(days: 4)),
  PlantSpecies('Hibiscus', '\u{1F33A}', Duration(days: 4)),
];

/// How thirsty a freshly-added plant should start out — expressed as an
/// offset from its species' own watering interval, so "very thirsty"
/// means the same thing whether it's a 3-day Basil or an 18-day Cactus.
enum InitialThirst {
  fresh('Just watered', 0),
  gettingLow('A little dry', -1),
  veryThirsty('Very thirsty', 2);

  const InitialThirst(this.label, this.intervalOffsetDays);

  final String label;
  final int intervalOffsetDays;

  /// Converts this level into an actual "days since watered" number for
  /// a given species' interval, clamped so it's never negative.
  int daysAgoFor(Duration wateringInterval) {
    final raw = wateringInterval.inDays + intervalOffsetDays;
    return raw < 0 ? 0 : raw;
  }
}
