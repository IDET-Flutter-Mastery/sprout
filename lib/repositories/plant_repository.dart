import 'dart:async';
import 'dart:math';

import '../models/plant.dart';

/// -----------------------------------------------------------------------
/// PlantRepository — DONE, no edits needed.
/// -----------------------------------------------------------------------
/// A small, self-contained fake "backend" so the whole lecture works
/// offline with no server setup. It behaves like a real data source:
/// - watchPlants() returns a Stream that emits whenever the plant list
///   changes (a new plant added, or just the passage of time).
/// - addPlant() mutates the in-memory list and pushes a fresh snapshot
///   to every listener.
///
/// This is exactly the kind of thing a StreamProvider loves to wrap.
/// -----------------------------------------------------------------------
class PlantRepository {
  PlantRepository() {
    _controller = StreamController<List<Plant>>.broadcast(
      onListen: _emit,
    );
    // Periodically re-emit so isThirsty (which is time-based) stays fresh
    // for anything already listening.
    _ticker = Timer.periodic(const Duration(seconds: 20), (_) => _emit());
  }

  final _random = Random();
  late final StreamController<List<Plant>> _controller;
  late final Timer _ticker;

  final List<Plant> _plants = [
    Plant(
      id: 'p1',
      name: 'Pothos',
      emoji: '\u{1F33F}',
      lastWatered: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Plant(
      id: 'p2',
      name: 'Snake Plant',
      emoji: '\u{1FAB4}',
      lastWatered: DateTime.now().subtract(const Duration(days: 6)),
      wateringInterval: const Duration(days: 10),
    ),
    Plant(
      id: 'p3',
      name: 'Basil',
      emoji: '\u{1F33A}',
      lastWatered: DateTime.now().subtract(const Duration(days: 5)),
      wateringInterval: const Duration(days: 3),
    ),
    Plant(
      id: 'p4',
      name: 'Succulent',
      emoji: '\u{1FAB4}',
      lastWatered: DateTime.now().subtract(const Duration(days: 1)),
      wateringInterval: const Duration(days: 14),
    ),
  ];

  /// A live stream of the current plant list. Every time something
  /// changes (or the clock ticks forward), a fresh snapshot is emitted.
  Stream<List<Plant>> watchPlants() => _controller.stream;

  /// Adds a new plant to the collection and notifies listeners.
  ///
  /// `daysAgoWatered` lets the caller decide how "used" the plant already
  /// is the moment it's added — 0 means freshly watered (happy), a number
  /// past the species' `wateringInterval` means it starts out thirsty.
  Future<void> addPlant({
    required String name,
    required String emoji,
    required Duration wateringInterval,
    int daysAgoWatered = 0,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300)); // pretend network hop
    _plants.add(
      Plant(
        id: 'p${_plants.length + 1}_${_random.nextInt(9999)}',
        name: name,
        emoji: emoji,
        lastWatered: DateTime.now().subtract(Duration(days: daysAgoWatered)),
        wateringInterval: wateringInterval,
      ),
    );
    _emit();
  }

  /// Marks a plant as freshly watered (handy for demoing state changes).
  Future<void> waterPlant(String id) async {
    final index = _plants.indexWhere((p) => p.id == id);
    if (index == -1) return;
    _plants[index] = _plants[index].copyWith(lastWatered: DateTime.now());
    _emit();
  }

  /// Removes a plant from the collection and notifies listeners.
  Future<void> deletePlant(String id) async {
    _plants.removeWhere((p) => p.id == id);
    _emit();
  }

  void _emit() {
    if (!_controller.isClosed) {
      _controller.add(List.unmodifiable(_plants));
    }
  }

  void dispose() {
    _ticker.cancel();
    _controller.close();
  }
}
