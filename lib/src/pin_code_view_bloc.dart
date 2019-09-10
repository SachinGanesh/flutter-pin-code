import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PinCodeViewBloc extends Bloc<PinCodeViewEvent, PinCodeViewState> {
  final int correctPin;
  final int pinLength;

  List<int> listPin = List();

  PinCodeViewBloc(this.pinLength, this.correctPin);

  @override
  PinCodeViewState get initialState => InitialPinCodeViewState();

  @override
  Stream<PinCodeViewState> mapEventToState(
    PinCodeViewEvent event,
  ) async* {
    switch (event.runtimeType) {
      case InputPinCodeEvent:
        yield* inputPinCode((event as InputPinCodeEvent).number);
        break;
      case DeletePinCodeEvent:
        yield* deletePinCode();
        break;
    }
  }

  Stream<PinCodeViewState> inputPinCode(int number) async* {
    if (listPin.length < pinLength) {
      listPin.add(number);
      yield SelectedPinCodeState(listPin.length, false);
      if (pinLength == listPin.length) {
        if (correctPin == 0) {
          listPin.clear();
          yield SuccessPinCodeState();
          return;
        }
        var pinMap = String.fromCharCodes(listPin);
        if (pinMap == correctPin.toString()) {
          listPin.clear();
          yield SuccessPinCodeState();
        } else {
          yield SelectedPinCodeState(listPin.length, true);
          await Future.delayed(Duration(seconds: 3));
          yield SelectedPinCodeState(0, false);
        }
      }
    }
  }

  Stream<PinCodeViewState> deletePinCode() async* {
    if (listPin.length == 0) {
      return;
    }
    listPin.removeLast();
    yield SelectedPinCodeState(listPin.length, false);
  }
}
