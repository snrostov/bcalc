import 'package:bcalc/fuel.dart';
import 'package:bcalc/structures.dart';
import 'package:bcalc/heat.dart';

List<QBox> loadStructure() {
  var wallS = (8.16 + 11.4) * 2 * 2.641;
  var windowsS = (1.5 + 1.78 + 0.5 + 1.16 + 1.16 + 1.16 + 0.8 + 1.6) * 1.32;
  var dorsS = 0.9 * 2;

  var house = <QBox>[
    new QBox(s: wallS - windowsS - dorsS, k: 1 / 3.08, n: 1.0), // walls
    new QBox(s: windowsS, k: 0.8, n: 1.0), // windows
    new QDoor(w: 0.9, h: 2.0, k: .7, n: 1.0), // door
    new QFloor(s: 8.6 * 11.4, k: 1 / 4.56, n: 1.0), // floor
    new QBox(s: 8.6 * 11.4, k: 1 / 6.01, n: 1.0), // ceil
  ];
  return house;
}

Heater viallant_VU_282_5_5 = new Heater({
  gaz_m3: new FuelK(perKwH: 0.91, perH: 0.0),
  electricity_kwh: new FuelK(perKwH: 0.0, perH: 0.145 * 0.5)
});

Map<FuelType, double> fuelCosts = <FuelType, double>{
  gaz_m3: 5.69444,
  electricity_kwh: 2.73 // 1.32
};
