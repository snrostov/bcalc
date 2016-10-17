import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'heat.dart';
import 'package:csv/csv.dart';

Future<List<TSample>> loadMeteo() async {
  List<TSample> temps = <TSample>[];

  // http://rp5.ru/
  // "Местное время в Любани";"T";"Po";"P";"Pa";"U";"DD";"Ff";"ff10";"ff3";"N";"WW";"W1";"W2";"Tn";"Tx";"Cl";"Nh";"H";"Cm";"Ch";"VV";"Td";"RRR";"tR";"E";"Tg";"E'";"sss"
  var data = await new File("/Users/sergey/p/bcalc/luban_2015.gz").openRead();

  var lineStream = data
      .transform(GZIP.decoder)
      .transform(new Utf8Decoder())
      .transform(const CsvToListConverter(fieldDelimiter: ";"));

  DateTime prevTime = null;
  double prevTemp = null;
  await for (var line in lineStream) {
    if ((line[0] as String).startsWith("Местное время")) continue;
    if ((line[0] as String).startsWith("#")) continue;

    var time = line[0] as String;
    // 0123456789
    // 31.12.2015 21:00
    time = time.substring(6, 10) + "-" + time.substring(3, 5) + "-" + time.substring(0, 2) + time.substring(10);
    time = DateTime.parse(time);

    var temp = double.parse(line[1]);

    if (prevTime != null) {
      temps.add(new TSample(
          from: time,
          to: prevTime,
          tIn: 22.0, tOut: temp,
          hours: ((time.millisecondsSinceEpoch - prevTime.millisecondsSinceEpoch) / (1000 * 60 * 60)).abs())
      );
    }

    prevTime = time;
    prevTemp = temp;
  }
  return temps;
}
