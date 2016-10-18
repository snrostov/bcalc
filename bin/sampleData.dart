import 'package:bcalc/fuel.dart';
import 'package:bcalc/structures.dart';
import 'package:bcalc/heat.dart';

List<QBox> loadStructure() {
  var sWalls = (8.16 + 11.4) * 2 * 2.641;
  var sWindows = (1.5 + 1.78 + 0.5 + 1.16 + 1.16 + 1.16 + 0.8 + 1.6) * 1.32;
  var sDoors = 0.9 * 2;

  return [
    new QBox(s: sWalls - sWindows - sDoors, k: 0.3246753247, n: 1.0), // walls
    new QBox(s: sWindows, k: 0.8, n: 1.0), // windows
    new QDoor(w: 0.9, h: 2.0, k: .9, n: 1.0), // door
    new QFloor(s: 8.6 * 11.4, k: 0.2192982456, n: 1.0), // floor
    new QBox(s: 8.6 * 11.4, k: 0.1663893511, n: 1.0), // ceil
  ];
}

// низшая теплота сгорания топлива, для природного газа
var naturalGazMinBurnT = 10.175;

Heater viallant_VU_282_5_5 = new Heater({
  gaz_m3: new FuelK(perKwH: 1/(naturalGazMinBurnT*0.92), perH: 0.0),
  electricity_kwh: new FuelK(perKwH: 0.0, perH: 0.145 * 0.5)
});

Map<FuelType, double> fuelCosts = <FuelType, double>{
  gaz_m3: 5.69444,
  electricity_kwh: 2.73 // 1.32
};
