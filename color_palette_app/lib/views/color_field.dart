import 'package:color_palette_app/bloc/color_form_bloc/color_form_bloc.dart';
import 'package:color_palette_app/bloc/color_form_bloc/color_form_event.dart';
import 'package:color_palette_app/bloc/color_form_bloc/color_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorField extends StatelessWidget {
  final int index;
  const ColorField({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorsFormBloc, ColorsFormState>(
      builder: (context, state) {
        Color color = Color(state.colors[index]).withAlpha(0xff);
        return Container(
            padding: EdgeInsets.all(10),
            color: color,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'R: ${color.red}   G: ${color.green}   B: ${color.blue}',
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<ColorsFormBloc>(context).add(
                          ChangeColorsFormEvent(
                              colors: state.colors,
                              index: index,
                              title: state.title,
                              id: state.id));
                    },
                    icon: Icon(Icons.refresh))
              ],
            ));
      },
    );
  }
}
