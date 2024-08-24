import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skin_care/features/chats/controller/chat_bloc/chat_bloc.dart';
import 'package:skin_care/features/home/screens/product_detail_screen.dart';
import 'package:skin_care/features/home/screens/products_screen.dart';
import 'package:skin_care/core/theme/apptheme.dart';
import 'package:skin_care/features/onboarding/controller/splash_bloc.dart';
import 'package:skin_care/features/setting/screens/change_password.dart';
import 'package:skin_care/features/setting/screens/help_screen.dart';
import 'package:skin_care/features/setting/screens/language.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skin_care/shared/dynamictoast.dart';
import 'dependency_injection.dart';
import 'features/Profile/controller/profile_bloc.dart';
import 'features/Profile/controller/profile_event.dart';
import 'features/auth/controller/auth_bloc.dart';
import 'features/auth/screens/change_password.dart';
import 'features/auth/screens/enter_otp_scree.dart';
import 'features/auth/screens/forget_password.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/chats/screens/chatscreen.dart';
import 'features/chats/screens/image_history.dart';
import 'features/home/controllers/product/product_bloc.dart';
import 'features/home/screens/home_screen.dart';
import 'features/auth/screens/signup_screen.dart';
import 'features/bottom_nav_bar/Screens/bottom_bar.dart';
import 'features/home/screens/widgets/product/product_symptom_screen.dart';
import 'features/onboarding/screens/login_signup.dart';
import 'features/onboarding/screens/onboarding_screen.dart';
import 'features/home/controllers/home/home_bloc.dart';
import 'features/onboarding/screens/splash_screen.dart';
import 'features/setting/screens/policies.dart';
import 'features/setting/screens/privacy_policy_screen.dart';
import 'features/setting/screens/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart';

late Size mq;

// Platform  Firebase App Id
// android   1:373862877577:android:06b531825218d44fdef958
// ios       1:373862877577:ios:0dc0a262e8a06b35def958

void main() async {
  // runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();
  setup();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((_) {
  //   runApp(const MyApp());
  // });
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newlocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newlocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
      DynamicToast.show("Language updated successfully");
    });
  }

// NBsoRb289882h593gP2t
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(
          create: (context) => SplashBloc()
            ..add(
              SplashInitEvent(),
            ),
        ),
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()
            // ..add(
            //   HomeInitEvent(),
            // ),
            ),
        BlocProvider<ProductBloc>(create: (context) => ProductBloc()
            // ..add(
            //   ProductInitEvent(),
            // ),
            // productBloc.
            // ..add(ProductFetchFav())

            ),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => ProfileBloc()..add(GetUserDetail())),
        BlocProvider(create: (context) => ChatBloc()),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(storage.read('language') ?? 'en', ''),
        theme: ThemeData(colorScheme: lightColorScheme),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          LoginScreen.id: (c) => LoginScreen(),
          HomeScreen.id: (c) => const HomeScreen(),
          ProductScreen.id: (c) => ProductScreen(),
          ProductSymptomItemWidget.id: (c) => ProductSymptomItemWidget(),
          OnboardingScreen.id: (c) => const OnboardingScreen(),
          LoginSignUp.id: (c) => const LoginSignUp(),
          OtpScreen.id: (c) => OtpScreen(),
          ChangePassword.id: (c) => ChangePassword(),
          // LoginSignUp.id: (c) => LoginSignUp(),
          SignupScreen.id: (c) => SignupScreen(),
          BottomNavBar.id: (c) => const BottomNavBar(),
          ChatScreen.id: (c) => ChatScreen(),
          ImageHistory.id: (c) => ImageHistory(),
          Settings.id: (c) => Settings(),
          ForgetPassword.id: (c) => ForgetPassword(),
          HelpScreen.id: (c) => const HelpScreen(),
          PrivacySecurityScreen.id: (c) => const PrivacySecurityScreen(),
          CompanyPoliciesScreen.id: (c) => CompanyPoliciesScreen(),
          ChangePass.id: (c) => ChangePass(),
          Language.id: (c) => Language(),
          // product detail screen
          // ProductDetailsScreen.id:(c) => ProductDetailsScreen(product: ,),
          // CompanyPoliciesScreen
        },
      ),
    );
  }
}
