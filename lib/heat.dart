import 'fuel.dart';

class QTime {
  final double kwh;
  final double h;

  const QTime({this.kwh, this.h});

  operator +(QTime b) => new QTime(kwh: kwh + b.kwh, h: h + b.h);

  @override
  String toString() {
    return 'Heat{kw: $kwh, h: $h}';
  }
}

abstract class Transformer<T, R> {
  R transform(T x);
}

class FuelK {
  double perKwH;
  double perH;

  FuelK({this.perKwH, this.perH});
}

class Heater implements Transformer<QTime, Map<FuelType, double>> {
  final Map<FuelType, FuelK> k;

  Heater(this.k);

  @override
  Map<FuelType, double> transform(QTime x) {
    Map<FuelType, double> result = new Map<FuelType, double>();
    k.forEach((f, k) {
      result[f] = k.perKwH * x.kwh * x.h + k.perH * x.h;
    });
    return result;
  }
}

class TSample {
  DateTime from;
  DateTime to;

  double tIn; // oС
  double tOut; // oС
  double hours;

  TSample({this.from, this.to, this.tIn, this.tOut, this.hours}); // hour
}