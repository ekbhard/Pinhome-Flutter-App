import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/blocs/personal_area_form_bloc.dart';

class PersonalAreaProvider extends InheritedWidget {
  final bloc = new PersonalAreaFormBloc();

  // constructor, forward to Parent InheritedWidget
  PersonalAreaProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget _) {
    // Todo implantation
    return true;
  }

  static PersonalAreaFormBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(PersonalAreaProvider)
            as PersonalAreaProvider)
        .bloc;
  }
}
