# Sprout — State Management Foundations Lab Starter

A tiny, cheerful plant-watering tracker, and the companion project for the
**State Management Foundations** lecture (ChangeNotifier → Riverpod).

No backend, no API keys, no setup beyond `flutter pub get` — the "server"
is a small in-memory fake (`lib/repositories/plant_repository.dart`) that
behaves like a real one: a live stream you can watch, and a write method
that pushes updates to every listener.

## Setup

```
flutter pub get
flutter run
```

You'll land on a menu with three tiles — **Classic (setState)**, **Sprout
(Riverpod)**, and **Quick Challenge · Counter**. Each corresponds to a
stage of the lecture and can be worked on independently.

## Where you'll be working

```
lib/
├── models/plant.dart                          (done — no edits needed)
├── repositories/plant_repository.dart          (done — the fake backend)
├── controllers/
│   └── thirsty_filter_controller.dart      ← CP1
├── providers/
│   ├── plant_repository_provider.dart          (done)
│   ├── thirsty_only_provider.dart              (done — shown in theory)
│   ├── plants_provider.dart                ← CP2
│   ├── counter_provider.dart               ← Quick Challenge
│   └── thirsty_count_provider.dart         ← Final Exercise (take-home)
├── screens/
│   ├── home_menu_screen.dart                   (done)
│   ├── legacy_plant_screen.dart            ← CP1 (wiring)
│   ├── plant_list_screen.dart              ← CP3, CP4
│   └── counter_challenge_screen.dart           (done — the provider needs work)
└── widgets/plant_tile.dart                     (done)
```

## Checkpoints

### CP1 — Build ThirstyFilterController
**File:** `controllers/thirsty_filter_controller.dart`, wired up in
`screens/legacy_plant_screen.dart`.

Extend `ChangeNotifier`, add a private `_thirstyOnly` field with a public
getter, and a `toggle()` method that flips it and calls
`notifyListeners()`. Then replace the placeholder `SwitchListTile` in the
Classic screen with a `ListenableBuilder` wired to your controller.

**Definition of done:** flipping the switch updates only the switch —
nothing else on screen rebuilds.

### CP2 — Turn Plant Data Into a StreamProvider
**File:** `providers/plants_provider.dart`

Watch `plantRepositoryProvider` and return `repo.watchPlants()`.

**Definition of done:** `ref.watch(plantsProvider)` produces an
`AsyncValue` that resolves to the four starter plants.

### CP3 — Wire the Screen to Live Data
**File:** `screens/plant_list_screen.dart`

Watch both `plantsProvider` and `thirstyOnlyProvider`, and use
`.when(loading:, error:, data:)` to render a filtered, scrollable list.

**Definition of done:** the Sprout screen shows a live list of plants; the
switch actually filters it.

### CP4 — Add a Plant, Live
**File:** `screens/plant_list_screen.dart` (`_onAddPlantPressed`)

Call `repo.addPlant(name)` via `ref.read`, then
`ref.invalidate(plantsProvider)` to force a refetch.

**Definition of done:** tapping the FAB, typing a name, and confirming
adds a new row without restarting the app.

### Quick Challenge — Riverpod Counter
**File:** `providers/counter_provider.dart`

A `Notifier<int>` with an `increment()` method. The screen
(`counter_challenge_screen.dart`) is already wired up.

### Final Exercise (Take-Home) — Derived Provider
**File:** `providers/thirsty_count_provider.dart`

Derive a plain `int` — how many plants are currently thirsty — from
`plantsProvider`. Display it as a badge next to the filter switch; bonus
points for hiding it when the count is 0.

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| `UnimplementedError` on the Sprout screen | `plantsProvider` (CP2) not finished yet | Implement CP2 first — CP3/CP4 depend on it |
| Filter switch does nothing on Classic screen | CP1 not wired into `legacy_plant_screen.dart` | Create the controller and wrap the switch in a `ListenableBuilder` |
| New plant never appears | `ref.invalidate` missing or called before `addPlant` resolves | `await` `addPlant()` fully, then invalidate |
| Riverpod errors immediately at startup | `ProviderScope` missing | Already set up in `main.dart` — don't remove it |
