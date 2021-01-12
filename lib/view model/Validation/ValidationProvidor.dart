import 'package:flutter/material.dart';
import 'ValidationBloc.dart';

class ValidationProvider extends InheritedWidget {
 final ValidationBloc bloc ;

  ValidationProvider({Key key, Widget child}) :bloc=ValidationBloc(), super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static ValidationBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ValidationProvider) as ValidationProvider).bloc;
  }
}
