import 'package:equatable/equatable.dart';

class SqlStates extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class ButtonInitialState extends SqlStates{}
class ButtonState extends SqlStates{
  bool res;
  ButtonState({this.res});
}class FetchSuccess extends SqlStates{

  var posts;
  FetchSuccess({this.posts});
}
class ErrorState extends SqlStates{
  String message;
  ErrorState({this.message});
}