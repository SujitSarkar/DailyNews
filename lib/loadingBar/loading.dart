import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

circleSpin(){
  return Container(
    alignment: Alignment.center,
    child: SpinKitCircle(
      color: Colors.blue,
      size: 50.0,
    ),
  );
}