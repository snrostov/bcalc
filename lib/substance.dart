class Substance {
  /// Удельная теплоемкость, кДж/(кг·°С)
  double specificHeatCapacity;

  /// Температура воздуха, градусы цельсия
  double tempCelsius;

  /// Temperature (K)
  double get tempKelvin => tempCelsius + 273.15;
}

class Solid {

}

class Vapor {

}