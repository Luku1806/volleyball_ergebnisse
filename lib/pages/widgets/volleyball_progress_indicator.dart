import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class VolleyballProgressIndicator extends StatelessWidget {
  @override
  Widget build(context) {
    return SpinKitSpinningCircle(
      duration: Duration(seconds: 3),
      itemBuilder: (context, index) => Icon(
        Icons.sports_volleyball_outlined,
        color: Theme.of(context).primaryColor,
        size: 55,
      ),
    );
  }
}
