import 'dart:math';


/// Воздух
class Air {
  /// Удельная теплоемкость воздуха, кДж/(кг·°С)
  static const double specificHeatCapacity = 1.005;

  /// Температура воздуха, градусы цельсия
  double tempCelsius;

  /// Абсолуютное давление, Па
  double absolutePressure;

  /// Относительная влажность, %
  double relativeHumidity;

  /// Temperature (K)
  double get tempKelvin => tempCelsius + 273.15;

  /// Парциальное давление насыщенного пара, мбар
  double get saturationVaporPressureMbar => 6.1078 * pow(10, 7.5 * tempCelsius / (tempCelsius + 237.3));

  /// Парциальное давление насыщенного пара, Па
  double get saturationVaporPressurePa => saturationVaporPressureMbar / 100;

  /// Давление водяного пара, Па
  double get waterVaporPressure => relativeHumidity * saturationVaporPressurePa;

  // Парциальное давление сухого воздуха, Па
  double get partialDryAirPressure => absolutePressure - waterVaporPressure;

  /// Молярная масса сухого воздуха, 0.028964 kg/mol
  static const double dryAirMolarMass = 0.028964;

  /// Молярная масса водяного пара, 0.018016 kg/mol
  static const double waterVaporMolarMass = 0.018016;

  /// Универсальнся газовая постоянная, 8.314 J/(K·mol)
  static const double universalGazConst = 8.314;

  /// Плотность (кг/м³)
  double get density =>
      (partialDryAirPressure * dryAirMolarMass + waterVaporPressure * waterVaporMolarMass)
          / (universalGazConst * tempKelvin);

  /// Показатель адиабаты
  static const double heatCapacityRatio = 7 / 5;

  static double soundSpeedAlpha = sqrt((heatCapacityRatio * universalGazConst) / dryAirMolarMass);

  /// Скорость звука
  double get soundSpeed => soundSpeedAlpha * sqrt(tempKelvin);

/// Акустическое сопротивление
// double get acousticImpedance =>
}