import 'package:flutter/material.dart';
import 'package:skin_care/dependency_injection.dart';
import 'package:skin_care/features/setting/model/language_model.dart';
import 'package:skin_care/main.dart';

String selected = "english";

class Language extends StatefulWidget {
  static const id = 'Language';
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  String hint = "Select Language";
  // List<String> dropdownitem = ["en", "spanish", "french"];

  @override
  void initState() {
    Languages.languagelist().map((Languages item) {});
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Language Page"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.symmetric(
          vertical: 40,
        ),
        child: DropdownButton<Languages>(
          hint: Text(hint),
          // value: Languages(1, "🇺🇸", "English", "en"),
          underline: SizedBox(),
          icon: Icon(Icons.language),
          onChanged: (Languages? language) {
            // print(language!.name);
            if (language != null)
              MyApp.setLocale(context, Locale(language.code, ''));

            storage.write('language', language!.code);
            setState(() {
              hint = language.name;
            });
          },
          items: Languages.languagelist().map((Languages item) {
            return DropdownMenuItem<Languages>(
                value: item,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(item.code), Text(item.name), Text(item.flag)],
                ));
          }).toList(),
        ),
      ),
    );
  }
}
