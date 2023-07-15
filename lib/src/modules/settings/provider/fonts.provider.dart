import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/constants.dart';
import '../../../db/hive.dart';
import '../../../utils/extensions/extensions.dart';
import '../model/settings.model.dart';
import 'settings.provider.dart';

// final allFontsProvider = FutureProvider((_) => GoogleFonts.asMap().keys.toList());

final allFontStylesProvider = FutureProvider(
  (_) => [
    {
      'font': GoogleFonts.nunito(),
      'name': 'Nunito',
    },
    {
      'font': GoogleFonts.roboto(),
      'name': 'Roboto',
    },
    {
      'font': GoogleFonts.lato(),
      'name': 'Lato',
    },
    {
      'font': GoogleFonts.raleway(),
      'name': 'Raleway',
    },
    {
      'font': GoogleFonts.oswald(),
      'name': 'Oswald',
    },
    {
      'font': GoogleFonts.merriweather(),
      'name': 'Merriweather',
    },
    {
      'font': GoogleFonts.prompt(),
      'name': 'Prompt',
    },
    {
      'font': GoogleFonts.poppins(),
      'name': 'Poppins',
    },
    {
      'font': GoogleFonts.lora(),
      'name': 'Lora',
    },
    {
      'font': GoogleFonts.rubik(),
      'name': 'Rubik',
    },
    {
      'font': GoogleFonts.karla(),
      'name': 'Karla',
    },
  ],
);

typedef FontNotifier = NotifierProvider<FontProvider, String>;

final fontProvider = FontNotifier(FontProvider.new);

class FontProvider extends Notifier<String> {
  @override
  String build() => ref.watch(settingsProvider.select((v) => v.fontFamily));

  Future<void> changeFont(String font) async {
    // await compute(_changeFont, _Data(ref.read(settingsProvider), font));
    await Boxes.appSettings.put(
        appName.toCamelWord,
        (Boxes.appSettings.get(appName.toCamelWord) ?? AppSettings())
            .copyWith(fontFamily: font));
  }
}

// class _Data {
//   _Data(this.setting, this.font);

//   final String font;
//   final AppSettings setting;
// }

// Future<void> _changeFont(_Data data) async{
//   await initHiveDB();
//   data.setting.fontFamily = data.font;
//   await Boxes.appSettings.put(appName, data.setting);
// }
