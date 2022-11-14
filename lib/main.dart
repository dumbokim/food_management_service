import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:food_ppopgi/pages/main/review/register_review.dart';
import 'package:food_ppopgi/pages/pages.dart';
import 'package:food_ppopgi/pages/splash/splash_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riv;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:admob_flutter/admob_flutter.dart';

const supabaseUrl = 'https://spvzivxrznsrgqdanbbh.supabase.co';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Admob.initialize();

  await dotenv.load(
      fileName:
          ".env"); // mergeWith optional, you can include Platform.environment for Mobile/Desktop app

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
        title: 'Food management service',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashPage(),
          '/main': (context) => MainPage(),
          '/restaurant/review': (context) => ReviewListPage(),
          '/restaurant/review/register': (context) => RegisterReviewPage(),
        },
      ),
    );
  }
}
