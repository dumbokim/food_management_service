import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:food_ppopgi/pages/adoption/adoption.dart';
import 'package:food_ppopgi/pages/main/review/register_review.dart';
import 'package:food_ppopgi/pages/pages.dart';
import 'package:food_ppopgi/pages/splash/splash_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riv;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:admob_flutter/admob_flutter.dart';

import 'common/common.dart';

const supabaseUrl = 'https://spvzivxrznsrgqdanbbh.supabase.co';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Admob.initialize(
    testDeviceIds: [
      'CDB822C5370ABACD9F9DF7A4A596A0C4',
    ],
  );

  await dotenv.load(fileName: ".env");

  final supabaseKey = dotenv.get('SUPABASE_KEY');

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return riv.ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food management service',
        theme: ThemeData(
          primarySwatch: MaterialColor(
            0xFF6508DF,
            const <int, Color>{
              50: const Color(0xFF6508DF),
              100: const Color(0xFF6508DF),
              200: const Color(0xFF6508DF),
              300: const Color(0xFF6508DF),
              400: const Color(0xFF6508DF),
              500: const Color(0xFF6508DF),
              600: const Color(0xFF6508DF),
              700: const Color(0xFF6508DF),
              800: const Color(0xFF6508DF),
              900: const Color(0xFF6508DF),
            },
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashPage(),
          '/main': (context) => MainPage(),
          '/request/register': (context) => RegisterRequestPage(),
          '/restaurant/review': (context) => ReviewListPage(),
          '/restaurant/review/register': (context) => RegisterReviewPage(),
          '/adoption/list': (context) => AdoptionListPage(),
        },
      ),
    );
  }
}
