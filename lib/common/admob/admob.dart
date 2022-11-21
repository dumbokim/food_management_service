import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdmobBannerView extends StatefulWidget {
  const AdmobBannerView({Key? key}) : super(key: key);

  @override
  State<AdmobBannerView> createState() => _AdmobBannerViewState();
}

class _AdmobBannerViewState extends State<AdmobBannerView> {
  bool _isLoaded = true;

  @override
  Widget build(BuildContext context) {
    return _isLoaded
        ? Column(
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
                    if (event == AdmobAdEvent.failedToLoad) {
                      setState(() {
                        _isLoaded = false;
                      });
                      return;
                    }

                    if (_isLoaded == false) {
                      setState(() {
                        _isLoaded = true;
                      });
                    }
                  },
                ),
              )
            ],
          )
        : const SizedBox();
  }
}
