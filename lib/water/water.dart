import 'package:bcalc/substance.dart';

class Water extends Substance {
  /// Удельная теплоемкость, кДж/(кг·°С)
  double specificHeatCapacity = 4.19;

  ///
  double density = 998.2;

  double molarMass = 0.01801528;

  double dynamicViscosity = 0.00101;

  double kinematicViscosity = 0.01012; // todo: depend on T

  double soundSpeed = 1348.0;
}

class WaterVapor extends Water implements Vapor {

}

class Ace extends Water implements Solid {

}