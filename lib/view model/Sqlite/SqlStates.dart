class SqlStates {}

class ButtonInitialState extends SqlStates {}

class LikedButtonState extends SqlStates {}
class GetSaved extends SqlStates{
  var data;
  GetSaved(this.data);

}

class ErrorState extends SqlStates {
  String message;
  ErrorState({this.message});
}
