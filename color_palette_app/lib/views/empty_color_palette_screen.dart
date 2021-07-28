import 'dart:math';

import 'package:color_palette_app/bloc/color_form_bloc/color_form_bloc.dart';
import 'package:color_palette_app/bloc/color_form_bloc/color_form_state.dart';
import 'package:color_palette_app/bloc/color_palette_bloc/color_palette_bloc.dart';
import 'package:color_palette_app/views/create_color_palette_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmptyListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Text(
            'Você ainda não tem nenhuma \n paleta de cores :(',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 50),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: BlocProvider.of<ColorPaletteBloc>(context),
                      ),
                      BlocProvider<ColorsFormBloc>(
                        create: (_) => ColorsFormBloc(
                            //id nulo pois é caso de criação de nova paleta
                            ColorsFormState(
                                id: '',
                                colors: List.generate(
                                    5, (index) => Random().nextInt(0xffffffff)),
                                title: 'Nova Paleta')),
                      )
                    ],
                    child: CreateColorPaletteScreen(editing: false),
                  );
                },
              ));
            },
            child: Text(
              'Experimente criar uma\n agora!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
