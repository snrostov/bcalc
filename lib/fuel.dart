class FuelType {
  String name;
  String unit;

  FuelType(this.name, this.unit);

  @override
  String toString() {
    return '$name ($unit)';
  }
}

class FuelSource {
  FuelType type;
  double cost;
}

class Fuel {
  FuelType type;
  double count;
}

void add(Map<FuelType, double> result, Map<FuelType, double> a) {
  a.forEach((k, v) {
    var prev = result[k];
    if (prev == null) prev = 0;
    result[k] = prev + v;
  });
}

FuelType gaz_m3 = new FuelType("gaz", "m3");
FuelType electricity_kwh = new FuelType("electricity", "kWh");