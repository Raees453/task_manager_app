import 'package:fluttertoast/fluttertoast.dart';

class WidgetUtils {
  static void displayToast(String? message) {
    if (message == null) return;

    Fluttertoast.showToast(msg: message);
  }
}
