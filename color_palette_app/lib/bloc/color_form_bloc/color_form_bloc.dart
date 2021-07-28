import 'dart:math';
import 'package:color_palette_app/bloc/color_form_bloc/color_form_event.dart';
import 'package:color_palette_app/bloc/color_form_bloc/color_form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorsFormBloc extends Bloc<ColorsFormEvent, ColorsFormState> {
  ColorsFormBloc(ColorsFormState initialState) : super(initialState);

  @override
  Stream<ColorsFormState> mapEventToState(ColorsFormEvent event) async* {
    if (event is ChangeColorsFormEvent) {
      ColorsFormState state = ColorsFormState(
          id: event.id, colors: event.colors, title: event.title);
      int newColor = Random().nextInt(0xffffffff);
      if (event.index >= 0) //index > 0 => válido
        state.colors[event.index] = newColor;
      yield state;
    } else if (event is RandomizeColorsFormEvent) {
      List<int> randomColors =
          List.generate(5, (index) => Random().nextInt(0xffffffff));
      ColorsFormState state = ColorsFormState(
          id: event.id, title: event.title, colors: randomColors);
      yield state;
    } else {
      throw Exception('Event not found');
    }
  }
}
