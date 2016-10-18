import 'dart:async';
import 'dart:collection';
import 'package:bcalc/fuel.dart';
import 'package:bcalc/heat.dart';
import 'package:bcalc/meteo.dart';
import 'package:bcalc/structures.dart';
import 'package:stack_trace/stack_trace.dart';
import 'sampleData.dart';

class Agg {
  DateTime from;
  DateTime to;

  double tOutS = .0;
  double q = .0;
  double hours = .0;
  double heatHours = .0;
  double coolingHours = .0;
  Map<FuelType, double> fuel = new Map<FuelType, double>();

  Map<FuelType, double> get cost {
    Map<FuelType, double> result = new Map<FuelType, double>();
    fuel.forEach((t, v) {
      result[t] = v * fuelCosts[t];
    });
    return result;
  }

  int samples = 0;

  printIt() {
    if (samples > 0) {
      print("samples: ${samples}");
      print("heat days: ${heatHours / 24} (${(heatHours * 100 / hours).round()}%), "
          "avg out T: ${tOutS / samples}, total kWh: ${q}");
      print("fuel: $fuel");
      print("cost: $cost");
    } else {
      print("(nothing)");
    }
  }
}

typedef Key(TSample t);

class AggGroup {
  String name;
  Map map = new SplayTreeMap();
  Key groupBy;
  Key filter;

  AggGroup({this.name, this.groupBy: null, this.filter: null});

  Agg get(TSample t, bool isHeaterOn) {
    if (filter == null || filter(t)) {
      var key;
      if (this.groupBy != null) {
        key = this.groupBy(t);
        if (key is List) key = new Tuple(key);
      } else key = "";
      return map.putIfAbsent(key, () => new Agg());
    } else return new Agg();
  }

  printIt() {
    print("");
    print("============== $name ==============");
    print("");

    map.forEach((k, v) {
      print("== $k");
      v.printIt();
    });
  }
}

class Tuple implements Comparable {
  List<Comparable> list = [];

  Tuple(this.list);

  @override
  String toString() => list.toString();

  @override
  int compareTo(Tuple other) {
    for (var i = 0; i < other.list.length; i++) {
      var compareTo = list[i].compareTo(other.list[i]);
      if (compareTo != 0) return compareTo;
    }
    return 0;
  }
}

calc() async {
  print("Loading data...");

  List<QBox> house = loadStructure();
  var heater = viallant_VU_282_5_5;
  List<TSample> temps = await loadMeteo();

  print("Sampling...");

  List<AggGroup> groups = [
    new AggGroup(name: "all"),
    new AggGroup(name: "by month", groupBy: (TSample t) => [t.from.month, timeOfDayKind(t)]),
  ];

  for (var t in temps) {
    var fuel = new Map();
    var q = .0;
    var isHeaterOn = t.tIn > t.tOut && t.tOut < 18.0;
    if (isHeaterOn) {
      for (var e in house) {
        q += e.transform(t);
      }

      fuel = heater.transform(new QTime(kwh: q / 1000, h: t.hours));
    }

    for (var g in groups) {
      var agg = g.get(t, isHeaterOn);

      agg.tOutS += t.tOut;
      agg.hours += t.hours;
      agg.q += q;
      agg.samples++;
      add(agg.fuel, fuel);
      if (isHeaterOn) agg.heatHours += t.hours;
    }
  }

  for (var g in groups) {
    g.printIt();
  }
}

String timeOfDayKind(TSample t) => isNight(t) ? "1.night" : "0.day";

bool isNight(TSample t) => (t.from.hour > 22 || t.from.hour < 7);

main(List<String> args) {
  calc();
}
