/*
 * flutter_pin_code
 * Created by rin.lv
 * https://www.linkedin.com/in/hnrinlv/
 *
 * Copyright (c) 2019 Rin.LV, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

class SinglePinView extends StatelessWidget {
  final bool hasValue;
  final Color normalColor;
  final Color selectedColor;

  const SinglePinView(
      {Key key, this.hasValue, this.normalColor, this.selectedColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 4, right: 4),
      child: Center(
        child: Text(
          hasValue ? '●' : '○',
          style: TextStyle(
              fontSize: 30, color: hasValue ? selectedColor : normalColor),
        ),
      ),
    );
  }
}
