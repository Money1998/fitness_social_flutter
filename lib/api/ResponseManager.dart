import 'WebFields.dart';

class ResponseManager {
  static dynamic parser(String requestCode, var result) {
    print(requestCode);
    if (requestCode == "Google") {
    return (result["predictions"]);
    }
    return result[WebFields.data];
  }
}
