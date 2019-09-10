import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
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
  @override
  String toString() => 'SuccessPinCodeState';
}
