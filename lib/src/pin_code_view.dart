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
import 'bloc.dart';

typedef PinCodeSuccess(String pin);

const DEF_PIN_LENGTH = 4;

class PinCodeView extends StatefulWidget {
  final Widget title;
  final Widget subTitle;
  final String errorMsg;
  final PinCodeSuccess onSuccess;
  final int correctPin;
  final Color bgColor;
  final Color textColor;
  final Color normalColor;
  final Color selectedColor;

  const PinCodeView(
      {Key key,
      this.title,
      this.subTitle,
      this.errorMsg,
      this.onSuccess,
      this.correctPin = 0,
      this.bgColor = Colors.white,
      this.textColor = Colors.white,
      this.normalColor = Colors.black45,
      this.selectedColor = Colors.blue})
      : super(key: key);

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
    return BlocListener(
      listener: (context, state) {
        if (state is SuccessPinCodeState) {
          widget.onSuccess(state.pin);
          return;
        }
        if (state is SelectedPinCodeState) {
          selLength = state.selLength;
          hasError = state.hasError;
          setState(() {});
          hideError();
        }
      },
      bloc: _pinCodeViewBloc,
      child: Wrap(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Center(
              child: widget.title,
            ),
          ),
          Container(
              height: 40,
              child: Center(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SinglePinView(
                      normalColor: widget.normalColor,
                      selectedColor: widget.selectedColor,
                      hasValue: index < selLength,
                    );
                  },
                  itemCount: length,
                ),
              )),
          Visibility(
            visible: hasError,
            child: Container(
              padding: EdgeInsets.only(
                top: 10,
              ),
              child: Center(
                child: Text(
                  widget.errorMsg,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Center(
              child: widget.subTitle,
            ),
          ),
          GridView.count(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            shrinkWrap: true,
            childAspectRatio: 3,
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
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
      color: widget.normalColor,
      onPressed: () {
        _pinCodeViewBloc.dispatch(InputPinCodeEvent(number));
      },
      child: Container(
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
                fontSize: 16,
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
      },
      child: Container(
        child: Center(
          child: Icon(
            iconData,
            size: 30,
            color: widget.normalColor,
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
