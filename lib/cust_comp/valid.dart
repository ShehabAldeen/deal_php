import 'package:dealwithphp/cust_comp/message.dart';

validInput(String val, int min, int max) {
  if (val.length > max) {
    return "$messageInputMix $max";
  }
  if (val.length < min) {
    return "$messageInputMin $min";
  }
  if (val.isEmpty) {
    return "$messageInputEmpty";
  }
}
