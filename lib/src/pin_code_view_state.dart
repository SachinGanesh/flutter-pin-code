import 'package:equatable/equatable.dart';

abstract class PinCodeViewState extends Equatable {
  PinCodeViewState([List props = const <dynamic>[]]) : super(props);
}

class InitialPinCodeViewState extends PinCodeViewState {}

class SelectedPinCodeState extends PinCodeViewState {
  final int selLength;
  final bool hasError;

  SelectedPinCodeState(this.selLength, this.hasError)
      : super([selLength, hasError]);

  @override
  String toString() => 'SelectedPinCodeState';
}

class SuccessPinCodeState extends PinCodeViewState {
  final String pin;

  SuccessPinCodeState(this.pin) : super([pin]);

  @override
  String toString() => 'SuccessPinCodeState';
}
