import 'fuel.dart';

class QTime {
  final double kw;
  final double h;

  const QTime({this.kw, this.h});

  operator +(QTime b) => new QTime(kw: kw + b.kw, h: h + b.h);

  @override
  String toString() {
    return 'Heat{kw: $kw, h: $h}';
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
  double minPower = 10.9;
  double maxPower = 31.1;

  Heater(this.k);

  @override
  Map<FuelType, double> transform(QTime x) {
    Map<FuelType, double> result = new Map<FuelType, double>();
    k.forEach((f, k) {
      result[f] = k.perKwH * x.kw * x.h + k.perH * x.h;
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