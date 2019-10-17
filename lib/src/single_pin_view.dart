/*
 * flutter_pin_code
 * Created by rin.lv
 * https://www.linkedin.com/in/hnrinlv/
 *
 * Copyright (c) 2019 Rin.LV, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SinglePinView extends StatelessWidget {
  final bool hasValue;
  final Color normalColor;
  final Color selectedColor;
  final double pinSize;

  const SinglePinView(
      {Key key,
      this.hasValue,
      this.normalColor,
      this.selectedColor,
      this.pinSize: 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: ScreenUtil.instance.setWidth(10),
          right: ScreenUtil.instance.setWidth(10),
          top: 0),
      child: Align(
        alignment: Alignment.center,
        child: hasValue
            ? Container(
                height: this.pinSize,
                width: this.pinSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedColor,
                ),
              )
            : Container(
                height: this.pinSize,
                width: this.pinSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x40a3a2ac),
                ),
              ),
      ),
    );
  }
}
