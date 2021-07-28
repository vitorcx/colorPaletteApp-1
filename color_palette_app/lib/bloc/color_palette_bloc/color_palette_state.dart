import 'package:color_palette_app/models/color_palette_model.dart';

abstract class ColorPaletteState {}

class ColorPaletteLoading extends ColorPaletteState {}

class ColorPaletteErrorState extends ColorPaletteState {
  final String message;
  ColorPaletteErrorState({required this.message});
}

class ColorPaletteLoaded extends ColorPaletteState {
  final List<ColorPalette> list;

  ColorPaletteLoaded({required this.list});
}

class ColorPaletteAdded extends ColorPaletteState {}

class ColorPaletteEdited extends ColorPaletteState {}

class ColorPaletteEmptyList extends ColorPaletteState {}
