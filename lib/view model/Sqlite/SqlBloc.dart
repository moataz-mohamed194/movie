import 'package:bloc/bloc.dart';

import '../../model/Repository/SQLDatabase.dart';
import 'SqlEvents.dart';
import 'SqlStates.dart';

//TODO: PLEASE for the god sake read the documentation
//* https://bloclibrary.dev/#/gettingstarted

class SqlBloc extends Bloc<SqlEvents, SqlStates> {
  final SQLDatabase repo;
  SqlBloc(this.repo) : super(ButtonInitialState());
  //* map state should return states only not booleans

  @override
  Stream<SqlStates> mapEventToState(SqlEvents event) async* {
    if (event is DeleteFromFavorite) {
      //TODO: add the insert method here

      yield ButtonInitialState();
      print(state);
    } else {
      //TODO: add the insert method here
      yield LikedButtonState();
      print(state);
    }
  }
}
