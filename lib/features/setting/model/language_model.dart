import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Languages {
  final int id;
  final String flag;
  final String name;
  final String code;
  Languages(this.id, this.flag, this.name, this.code);
  static List<Languages> languagelist() {
    return <Languages>[
      Languages(1, "🇺🇸", "English", "en"),
      // Languages(2, "🇪🇸", "Spanish", "es"),
      // Languages(3, "🇫🇷", "French", "fr"),
      Languages(4, "🇮🇩", "Indonesian", "id"),
      Languages(5, "🇰🇷", "Korean", "ko"),
      Languages(6, "🇨🇳", "Chinese", "zh"),
    ];
  }
}

AppLocalizations translate(BuildContext context) {
  return AppLocalizations.of(context)!;
}
