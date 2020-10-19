import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 优惠券类型的UI
class CouponShapeBorder extends ShapeBorder {
  final int holeCount; //我们打洞的个数
  final double lineRate; //确定白线在控件中的位置 按照0 - 1 来算
  final bool dash; //判断是否是虚线
  final Color color; //线的颜色

  CouponShapeBorder(
      {this.holeCount = 6,
      this.lineRate = 0.718,
      this.dash = true,
      this.color = Colors.white});

  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => null;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    // TODO: implement getInnerPath
    return null;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    // TODO: implement getOuterPath
    var path = Path();
    var w = rect.width;
    var h = rect.height;
    var d = h / (1 + 2 * holeCount);

    ///这个路径就是直接吧我们的rect放上去就是我们的控件本身的path  不需要进行任何裁剪和其他操作
    path.addRect(rect);

    _formHoldLeft(path, d);
    _formHoldRight(path, w, d);
    _formHoleTop(path, rect);
    _formHoleBottom(path, rect);

    ///这个是官方文档需要我们填的  但是也需要我们的path是从getInnerPath中返回的(这个重写函数感觉写不写没多大影响！！！有兴趣的可以试试)
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  _formHoldLeft(Path path, double d) {
    for (int i = 0; i < holeCount; i++) {
      var left = -d / 2;
      var top = 0.0 + d + 2 * d * (i);
      var right = left + d;
      var bottom = top + d;
      path.addArc(Rect.fromLTRB(left, top, right, bottom), -pi / 2, pi);
    }
  }

  _formHoldRight(Path path, double w, double d) {
    for (int i = 0; i < holeCount; i++) {
      var left = -d / 2 + w;
      var top = 0.0 + d + 2 * d * (i);
      var right = left + d;
      var bottom = top + d;
      path.addArc(Rect.fromLTRB(left, top, right, bottom), pi / 2, pi);
    }
  }

  void _formHoleBottom(Path path, Rect rect) {
    path.addArc(
        Rect.fromCenter(
            center: Offset(lineRate * rect.width, rect.height),
            width: 13.0,
            height: 13.0),
        pi,
        pi);
  }

  void _formHoleTop(Path path, Rect rect) {
    path.addArc(
        Rect.fromCenter(
            center: Offset(lineRate * rect.width, 0),
            width: 13.0,
            height: 13.0),
        0,
        pi);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    // TODO: implement paint
    var paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    var d = rect.height / (1 + 2 * holeCount);
    if (dash) {
      //虚线
      _drawDashLine(canvas, Offset(lineRate * rect.width, d / 2),
          rect.height / 16, rect.height - 13, paint);
    } else {
      //实线
      canvas.drawLine(Offset(lineRate * rect.width, d / 2),
          Offset(lineRate * rect.width, rect.height - d / 2), paint);
    }
  }

  _drawDashLine(
      Canvas canvas, Offset start, double count, double length, Paint paint) {
    var step = length / count / 2;
    for (int i = 0; i < count; i++) {
      var offset = start + Offset(0, 2 * step * i);
      canvas.drawLine(offset, offset + Offset(0, step), paint);
    }
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    return null;
  }
}
