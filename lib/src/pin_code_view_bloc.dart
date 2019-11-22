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
      print(">>>> #$number");
      listPin.add(number);
      yield SelectedPinCodeState(listPin.length, false);
      // if (pinLength == listPin.length) {
      //   var pinMap = StringBuffer();
      //   listPin.forEach((num) {
      //     pinMap.write(num);
      //   });
      //   // listPin.clear();
      //   if (correctPin == 0) {
      //     yield SuccessPinCodeState(pinMap.toString());
      //     return;
      //   }
      //   if (pinMap.toString() == correctPin.toString()) {
      //     yield SuccessPinCodeState(pinMap.toString());
      //   } else {
      //     yield SelectedPinCodeState(0, true);
      //   }
      // }
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
