import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdmobBannerView extends StatelessWidget {
  const AdmobBannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: AdmobBanner(
            adUnitId: dotenv.get('ADMOB_BANNER_ID'),
            adSize: AdmobBannerSize.BANNER,
            onBannerCreated: (AdmobBannerController controller) {
              // Dispose is called automatically for you when Flutter removes the banner from the widget tree.
              // Normally you don't need to worry about disposing this yourself, it's handled.
              // If you need direct access to dispose, this is your guy!
              // controller.dispose();
            },
            listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
              // handleEvent(event, args, 'Banner');
            },
          ),
        )
      ],
    );
  }

// void handleEvent(
//     AdmobAdEvent event, Map<String, dynamic>? args, String adType) {
//   switch (event) {
//     case AdmobAdEvent.loaded:
//       showSnackBar('New Admob $adType Ad loaded!');
//       break;
//     case AdmobAdEvent.opened:
//       showSnackBar('Admob $adType Ad opened!');
//       break;
//     case AdmobAdEvent.closed:
//       showSnackBar('Admob $adType Ad closed!');
//       break;
//     case AdmobAdEvent.failedToLoad:
//       showSnackBar('Admob $adType failed to load. :(');
//       break;
//     case AdmobAdEvent.rewarded:
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return WillPopScope(
//             onWillPop: () async {
//               ScaffoldMessenger.of(context).hideCurrentSnackBar();
//               return true;
//             },
//             child: AlertDialog(
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Text('Reward callback fired. Thanks Andrew!'),
//                   Text('Type: ${args!['type']}'),
//                   Text('Amount: ${args['amount']}'),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//       break;
//     default:
//   }
// }
//
// void showSnackBar(String content) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(content),
//       duration: Duration(milliseconds: 1500),
//     ),
//   );
// }
}
