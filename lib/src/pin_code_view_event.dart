import 'package:equatable/equatable.dart';

abstract class PinCodeViewEvent extends Equatable {
  PinCodeViewEvent([List props = const <dynamic>[]]) : super(props);
}

class InputPinCodeEvent extends PinCodeViewEvent {
  final int number;

  InputPinCodeEvent(this.number);

  @override
  String toString() => 'InputPinCodeEvent';
}

class DeletePinCodeEvent extends PinCodeViewEvent {
  @override
  String toString() => 'DeletePinCodeEvent';
}
