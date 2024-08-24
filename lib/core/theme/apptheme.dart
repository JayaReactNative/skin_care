import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  //text style
  
  static TextStyle mediumText = GoogleFonts.ptSerif(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    shadows: [
      Shadow(
        blurRadius: 1.0,
        color: Colors.black.withOpacity(0.15),
        offset: const Offset(0.5, 0.5),
      ),
    ],
  );

  static TextStyle headings = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle heading1 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  
  static TextStyle headline1 = GoogleFonts.ptSerif(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle headline2 = GoogleFonts.ptSerif(
    fontSize: 24.0,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static TextStyle headline3 = GoogleFonts.ptSerif(
    fontSize: 20.0,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static TextStyle heading2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static TextStyle headline4 = GoogleFonts.ptSerif(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static final TextStyle descriptive = TextStyle(
    fontSize: 19,
    color: Colors.black,
  );

  static final TextStyle small = TextStyle(
    fontSize: 12,
    color: Colors.black,
  );
  

  static TextStyle errorText = const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: Colors.red,
  );

  static TextStyle bodyText1 = GoogleFonts.roboto(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );

  static TextStyle bodyText2 = GoogleFonts.roboto(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );

  static TextStyle captionText = GoogleFonts.roboto(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: Colors.black38,
  );

  static const Color white = Colors.white;
  // most used text color
  static const Color mostusedtextcolor = Color.fromARGB(239, 255, 0, 0);

  //  most used container color
  static const Color mostusedcontainer = Color.fromARGB(255, 255, 226, 226);
  // fields border color
  static const Color textfield_border_color =
      const Color.fromARGB(255, 222, 222, 222);

  // Define primary and accent colors
  static const Color primaryColor = Color.fromARGB(255, 228, 255, 220);
  static const Color accentColor = Colors.green;
  static const Color darkGreeColor = Color(0xFF2F6B26);

  static const Color black = Colors.black;
  static const Color grey = Colors.grey;

  // Define background colors
  static const Color backgroundColor = Colors.white;
  static const Color scaffoldBackgroundColor = Colors.white;

  // Define text colors
  static const Color textColor = Colors.black;
  static const Color subtitleColor = Colors.grey;

  // Add more color definitions as needed

  // Define light theme
  static ThemeData lightTheme() {
    return ThemeData(
      primaryColor: primaryColor,
      hintColor: accentColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
        titleMedium: TextStyle(color: subtitleColor),
        titleSmall: TextStyle(color: subtitleColor),
        // Add more text styles as needed
      ),
      // Add more theme properties as needed
    );
  }

  // Define dark theme
  // static ThemeData darkTheme() {
  //   return ThemeData.dark().copyWith(
  //       // Customize dark theme properties
  //       );
  // }
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF2F6B26),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFB0F49E),
  onPrimaryContainer: Color(0xFF002200),
  secondary: Color(0xFF006874),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFF97F0FF),
  onSecondaryContainer: Color(0xFF001F24),
  tertiary: Color(0xFF286C00),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFA3F877),
  onTertiaryContainer: Color(0xFF072100),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color.fromARGB(255, 255, 255, 255),
  onBackground: Color(0xFF001F25),
  surface: Color.fromARGB(255, 255, 255, 255),
  onSurface: Color(0xFF001F25),
  surfaceVariant: Color(0xFFDFE4D7),
  onSurfaceVariant: Color(0xFF43483F),
  outline: Color.fromARGB(255, 196, 196, 196),
  onInverseSurface: Color(0xFFD6F6FF),
  inverseSurface: Color(0xFF00363F),
  inversePrimary: Color(0xFF95D784),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF2F6B26),
  outlineVariant: Color(0xFFC3C8BC),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF95D784),
  onPrimary: Color(0xFF003A00),
  primaryContainer: Color(0xFF15520F),
  onPrimaryContainer: Color(0xFFB0F49E),
  secondary: Color(0xFF4FD8EB),
  onSecondary: Color(0xFF00363D),
  secondaryContainer: Color(0xFF004F58),
  onSecondaryContainer: Color(0xFF97F0FF),
  tertiary: Color(0xFF88DB5E),
  onTertiary: Color(0xFF113800),
  tertiaryContainer: Color(0xFF1C5200),
  onTertiaryContainer: Color(0xFFA3F877),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF001F25),
  onBackground: Color(0xFFA6EEFF),
  surface: Color(0xFF001F25),
  onSurface: Color(0xFFA6EEFF),
  surfaceVariant: Color(0xFF43483F),
  onSurfaceVariant: Color(0xFFC3C8BC),
  outline: Color(0xFF8D9387),
  onInverseSurface: Color(0xFF001F25),
  inverseSurface: Color(0xFFA6EEFF),
  inversePrimary: Color(0xFF2F6B26),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF95D784),
  outlineVariant: Color(0xFF43483F),
  scrim: Color(0xFF000000),
);
