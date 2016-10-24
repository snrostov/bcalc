import 'dart:math';
import 'package:bcalc/vent/air.dart';
import 'package:bcalc/vent/airFlow.dart';
import 'package:bcalc/water/water.dart';
import 'package:bcalc/water/waterFlow.dart';

//class AirFlowWaterHeater {
//  AirFlow airFlow;
//
//  Water inputWater;
//
//  double outputWater;
//
//  /// живое сечение для прохода воды, м2
//  double waterFlowOpenSection;
//
//  double a;
//
//  /// массовый расход воды, кг/ч
//  double getRequiredWaterFlow(Air srcAir, double outputAirT) =>
//      airFlow.requiredHeat(srcAir, outputAirT)
//          / (0.28 * inputWater.specificHeatCapacity * (inputWater.tempCelsius - outputWater));
//
//  /// скорость воды в трубках калориферов, м/с
//  double getWaterSpeed(Air srcAir, double outputAirT) =>
//      getRequiredWaterFlow(srcAir, outputAirT) / (waterFlowOpenSection * 1000 * 3600);
//
//  /// Гидродинамическое сопротивление калорифера походу воды ∆Ртр, кПа
//  double getWaterResistance(Air srcAir, double outputAirT) =>
//      a * pow(getWaterSpeed(srcAir, outputAirT), 2);
//}

class AirFlowWaterFlow {
  AirFlow air;
  WaterFlow water;

  AirFlowWaterFlow(this.air, this.water);
}

class AirWaterHeater {
  /// живое сечение для прохода воды, м2
  double waterFlowOpenSection;

  AirFlowWaterFlow transform(AirFlowWaterFlow input) =>
      new AirFlowWaterFlow()
}