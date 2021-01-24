import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CounterEvent { add, remove }

class UIBloc extends Bloc<CounterEvent, bool> {
  UIBloc(bool initialState) : super(initialState);

  @override
  Stream<bool> mapEventToState(CounterEvent event) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (event) {
      case CounterEvent.add:
        prefs.setBool('login', true);


        yield true;
        break;
      case CounterEvent.remove:
        yield false;
        prefs.setBool('login', false);
        break;
    }
  }
}
