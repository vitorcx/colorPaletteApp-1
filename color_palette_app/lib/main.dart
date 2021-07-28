import 'package:color_palette_app/bloc/color_palette_bloc/color_palette_bloc.dart';
import 'package:color_palette_app/bloc/color_palette_bloc/color_palette_state.dart';
import 'package:color_palette_app/views/list_color_palettes_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(ColorPaletteApp());
}

class ColorPaletteApp extends StatefulWidget {
  const ColorPaletteApp({Key? key}) : super(key: key);

  @override
  _ColorPaletteAppState createState() => _ColorPaletteAppState();
}

class _ColorPaletteAppState extends State<ColorPaletteApp> {
  final Future<FirebaseApp> _intializaiton = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white, accentColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _intializaiton,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao conectar com o Firebase!'));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return BlocProvider<ColorPaletteBloc>(
              create: (context) => ColorPaletteBloc(ColorPaletteLoading()),
              child: ListColorPalettes(),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
