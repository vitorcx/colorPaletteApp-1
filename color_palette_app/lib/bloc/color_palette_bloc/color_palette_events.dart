import 'package:color_palette_app/models/color_palette_model.dart';

abstract class ColorPaletteEvent {}

class ColorPaletteFetchList extends ColorPaletteEvent {}

class ColorPaletteDelete extends ColorPaletteEvent {
  final String id;

  ColorPaletteDelete({required this.id});
}

class ColorPaletteEdit extends ColorPaletteEvent {
  final ColorPalette colorPalette;

  ColorPaletteEdit(this.colorPalette);
}

class ColorPaletteCreate extends ColorPaletteEvent {
  final ColorPalette newColorPalette;

  ColorPaletteCreate(this.newColorPalette);
}
