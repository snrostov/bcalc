import 'package:bcalc/vent/air.dart';

/// Воздушный поток
class AirFlow {
  Air air;

  /// расход воздуха, м3/ч
  double airFlow;

  /// Необходимое количество теплоты для нагревания воздуза, Вт
  double requiredHeat(Air srcAir, tTarget) =>
      0.28 * airFlow * srcAir.density * Air.specificHeatCapacity * (tTarget - srcAir.tempCelsius);
}