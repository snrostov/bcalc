/// 1.1.2. Основные потери теплоты через ограждающие конструкции зданий

import 'package:bcalc/heat.dart';

class QBox implements Transformer<TSample, double> {
  double s; // м2
  double k; // Вт/(м2·oС)
  double n;
  double orientation; //

  QBox({this.s, this.k, this.n: 1.0, this.orientation: 1.0});

  @override
  double transform(TSample x) => s * (x.tIn - x.tOut) * k * orientation;

  @override
  String toString() {
    return 'QBox{s: $s, k: $k}';
  }
}

/// в) дополнительные потери теплоты на нагревание холод- ного воздуха, поступающего при кратковременном открывании наружных входов, не оборудованных воздушно-тепловыми за- весами, принимаются в зависимости от типа входных дверей и высоты здания Н, м
class QDoor extends QBox {
  double kAir = 0.27; // для двойных дверей с тамбурами между ними
  double h;
  double w;

  QDoor({w, h, k, n: 1.0, orientation: 1.0, this.kAir: 0.27}) :
        super(s: w * h, k: k, n: n, orientation: orientation) {
    this.w = w;
    this.h = h;
  }

  @override
  double transform(TSample x) => super.transform(x) * (1 + h * kAir);
}

// todo: QInfiltration // Расчет расхода теплоты на нагрев инфильтрующегося наружного воздуха

/// Дополнительные бытовые теплопоступления в помещения
class QFloor extends QBox {
  double kLife = 0.0; // 10.0;

  QFloor({s, k, n: 1.0, orientation: 1.0}) :
        super(s: s, k: k, n: n, orientation: orientation);

  @override
  double transform(TSample x) => super.transform(x) - kLife * s;
}