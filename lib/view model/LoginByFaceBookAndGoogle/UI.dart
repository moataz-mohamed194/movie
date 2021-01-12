import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum counterEvent { add, remove }

class UIBloc extends Bloc<counterEvent, bool> {
  UIBloc(bool initialState) : super(initialState);
  @override
  bool get initialState => false;
  @override
  Stream<bool> mapEventToState(counterEvent event) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (event) {
      case counterEvent.add:
        yield true;
        prefs.setBool('login', true);
        break;
      case counterEvent.remove:
        yield false;
        prefs.setBool('login', false);
        break;
    }
  }
}