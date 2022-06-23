import 'package:get/get.dart';

double get viewPaddingTop => Get.mediaQuery.viewPadding.top;

const String APP_NAME = 'NTA-Attendance';

const String FIRE_BASE_MESSAGE_TOKEN = 'key=AAAA-QmYUyY:APA91bF6N19eyqNKCnmCwd-fXDADSPrvgiRFGdVNGt7D3WyclzjXdFhPsbKA9ddNWsKnE3F-aFlN5vJ0huNstW87Ny48JVSRgNfDW4ixjFOH2PQRFYvfEjaquveZGoJ93pGB5HUrsdmQ';

/// FLAVOR = dev => development
/// FLAVOR = prod => product
const String FLAVOR = String.fromEnvironment('FLAVOR');
