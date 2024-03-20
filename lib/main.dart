import 'package:sugar/services/su_config.dart';
import 'package:sugar/su_app.dart';

import 'constants/su_enum.dart';

void main() {
  SUConfig.env = SUEnvironment.production;
  startApp();
}
