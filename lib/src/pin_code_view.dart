/*
 * flutter_pin_code
 * Created by rin.lv
 * https://www.linkedin.com/in/hnrinlv/
 *
 * Copyright (c) 2019 Rin.LV, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pin_code/src/single_pin_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bloc.dart';

typedef PinCodeSuccess(String pin);

const DEF_PIN_LENGTH = 4;
const screenWidthPhone = 1242.0; //Apple iPhone XS Max
const screenHeightPhone = 2688.0;

class PinCodeView extends StatefulWidget {
  final Widget title;
  final Widget subTitle;
  final String errorMsg;
  final PinCodeSuccess onSuccess;
  final int correctPin;
  final bool enterPhoneMode;
  final Color bgColor;
  final Color textColor;
  final Color normalColor;
  final Color selectedColor;
  final Function onNumberPressed;
  final Function onNumberDeleted;

  const PinCodeView({
    Key key,
    this.title,
    this.subTitle,
    this.errorMsg,
    this.onSuccess,
    this.correctPin = 0,
    this.enterPhoneMode = false,
    this.bgColor = Colors.white,
    this.textColor = Colors.white,
    this.normalColor = Colors.black45,
    this.selectedColor = Colors.blue,
    this.onNumberPressed,
    this.onNumberDeleted,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StatePinCodeView();
}

class _StatePinCodeView extends State<PinCodeView> {
  PinCodeViewBloc _pinCodeViewBloc;
  bool hasError = false;
  int selLength = 0;
  int length = DEF_PIN_LENGTH;

  @override
  void initState() {
    if (widget.correctPin > 0) {
      length = widget.correctPin.toString().length;
    }
    _pinCodeViewBloc = PinCodeViewBloc(length, widget.correctPin);
    super.initState();
  }

  @override
  void dispose() {
    _pinCodeViewBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: screenWidthPhone,
      height: screenHeightPhone,
      allowFontScaling: false,
    )..init(context);
    return BlocListener(
      listener: (context, state) {
        if (state is SuccessPinCodeState) {
          widget.onSuccess(state.pin);
          return;
        }
        if (state is SelectedPinCodeState) {
          selLength = state.selLength;
          if (!widget.enterPhoneMode) {
            hasError = state.hasError;
            setState(() {});
            hideError();
          }
        }
      },
      bloc: _pinCodeViewBloc,
      child: Wrap(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: ScreenUtil.instance.setHeight(40),
                bottom: ScreenUtil.instance.setHeight(40)),
            child: Center(
              child: widget.title,
            ),
          ),
          widget.enterPhoneMode
              ? Container()
              : Container(
                  height: ScreenUtil.instance.setHeight(200),
                  child: Center(
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => SizedBox(
                        width: 15,
                      ),
                      itemBuilder: (context, index) {
                        return SinglePinView(
                          normalColor: widget.normalColor,
                          selectedColor: widget.selectedColor,
                          hasValue: index < selLength,
                          pinSize: 30,
                        );
                      },
                      itemCount: length,
                    ),
                  )),
          Visibility(
            visible: hasError,
            child: Container(
              padding: EdgeInsets.only(
                top: ScreenUtil.instance.setHeight(40),
              ),
              child: Center(
                child: Text(
                  widget.errorMsg,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: ScreenUtil.instance.setSp(42)),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: ScreenUtil.instance.setHeight(40),
                bottom: ScreenUtil.instance.setHeight(40)),
            child: Center(
              child: widget.subTitle,
            ),
          ),
          Card(
            elevation: 12,
            child: GridView.count(
              padding: EdgeInsets.only(
                  left: ScreenUtil.instance.setWidth(40),
                  right: ScreenUtil.instance.setWidth(40),
                  top: ScreenUtil.instance.setHeight(0),
                  bottom: ScreenUtil.instance.setHeight(0)),
              shrinkWrap: true,
              childAspectRatio: 1,
              crossAxisCount: 3,
              // mainAxisSpacing: 70,
              crossAxisSpacing: 1,
              children: <Widget>[
                buildButtonNumber(1),
                buildButtonNumber(2),
                buildButtonNumber(3),
                buildButtonNumber(4),
                buildButtonNumber(5),
                buildButtonNumber(6),
                buildButtonNumber(7),
                buildButtonNumber(8),
                buildButtonNumber(9),
                Container(),
                buildButtonNumber(0),
                buildContainerIcon(Icons.backspace),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Widget buildButtonNumber(int number) {
    return FlatButton(
      splashColor: Color(0x8837DFCB),
      color: widget.normalColor,
      onPressed: () {
        _pinCodeViewBloc.dispatch(InputPinCodeEvent(number));
        if (widget.onNumberPressed != null) {
          widget.onNumberPressed(number);
        }
      },
      child: Container(
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
                fontSize: ScreenUtil.instance.setSp(80),
                fontWeight: FontWeight.normal,
                color: widget.textColor),
          ),
        ),
      ),
    );
  }

  Widget buildContainerIcon(IconData iconData) {
    return FlatButton(
      color: Colors.white,
      onPressed: () {
        _pinCodeViewBloc.dispatch(DeletePinCodeEvent());
        if (widget.onNumberDeleted != null) {
          widget.onNumberDeleted();
        }
      },
      child: Container(
        child: Center(
          child: Icon(
            iconData,
            size: ScreenUtil.instance.setSp(90),
            color: Color(0xff37dfcb),
          ),
        ),
      ),
    );
  }

  void hideError() {
    if (hasError) {
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          hasError = false;
        });
      });
    }
  }
}
