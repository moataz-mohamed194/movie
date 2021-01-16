import 'package:bloc/bloc.dart';

import '../../model/Repository/SQLDatabase.dart';
import 'SqlEvents.dart';
import 'SqlStates.dart';

class SqlBloc extends Bloc<SqlEvents, SqlStates> {
  final SQLDatabase repo;
  SqlBloc(this.repo) : super(ButtonInitialState());
  @override
  Stream<SqlStates> mapEventToState(SqlEvents event) async* {
    if (event is DeleteFromFavorite) {
      yield ButtonInitialState();
      print(state);
    } else {
      yield LikedButtonState();
      print(state);
    }
  }
}
