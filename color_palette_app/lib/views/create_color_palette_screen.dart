import 'package:color_palette_app/bloc/color_form_bloc/color_form_bloc.dart';
import 'package:color_palette_app/bloc/color_form_bloc/color_form_event.dart';
import 'package:color_palette_app/bloc/color_form_bloc/color_form_state.dart';
import 'package:color_palette_app/bloc/color_palette_bloc/color_palette_bloc.dart';
import 'package:color_palette_app/bloc/color_palette_bloc/color_palette_events.dart';
import 'package:color_palette_app/models/color_palette_model.dart';
import 'package:color_palette_app/views/color_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateColorPaletteScreen extends StatefulWidget {
  final bool editing;

  CreateColorPaletteScreen({required this.editing});

  @override
  _CreateColorPaletteScreenState createState() =>
      _CreateColorPaletteScreenState();
}

class _CreateColorPaletteScreenState extends State<CreateColorPaletteScreen> {
  final TextEditingController _controller = TextEditingController();
  late ColorsFormBloc colorsFormBloc;

  @override
  Widget build(BuildContext context) {
    colorsFormBloc = BlocProvider.of<ColorsFormBloc>(context);
    _controller.text = colorsFormBloc.state.title;
    _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length));
    AppBar appBar =
        AppBar(title: Text('Nova Paleta de Cores'), centerTitle: true);
    double screenHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          alignment: Alignment.bottomCenter,
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            TextField(
                textAlign: TextAlign.center,
                controller: _controller,
                onChanged: (value) {
                  colorsFormBloc.add(ChangeColorsFormEvent(
                      index: -1,
                      id: colorsFormBloc.state.id,
                      title: value,
                      colors: colorsFormBloc.state.colors));
                }),
            Column(
              children: [
                for (int i = 0; i < 5; i++) ColorField(index: i),
              ],
            ),
            IconButton(
              alignment: Alignment.center,
              icon: Icon(Icons.refresh),
              onPressed: () {
                colorsFormBloc.add(RandomizeColorsFormEvent(
                    title: colorsFormBloc.state.title,
                    id: colorsFormBloc.state.id));
              },
              color: Colors.black,
              iconSize: 80,
            ),
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  widget.editing
                      ? editExistingColorPalette(colorsFormBloc.state)
                      : saveNewColorPalette(colorsFormBloc.state);
                  Navigator.of(context).pop();
                },
                child: Text("SALVAR"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        side: BorderSide(color: Colors.black))),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void saveNewColorPalette(ColorsFormState state) {
    List<int> colors = colorsFormBloc.state.colors;
    final newColorPalette =
        ColorPalette(id: '', colors: colors, title: _controller.text);
    BlocProvider.of<ColorPaletteBloc>(context)
        .add(ColorPaletteCreate(newColorPalette));
  }

  void editExistingColorPalette(ColorsFormState state) {
    final newColorPalette =
        ColorPalette(id: state.id, colors: state.colors, title: state.title);

    ColorPaletteBloc colorPaletteBloc =
        BlocProvider.of<ColorPaletteBloc>(context);

    colorPaletteBloc.add(ColorPaletteEdit(newColorPalette));
  }
}
