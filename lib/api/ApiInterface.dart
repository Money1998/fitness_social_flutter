
abstract class ApiCallBacks{
  void onSuccess(dynamic object,String strMsg,String requestCode);
  void onError(String errorMsg,String requestCode);
  void onConnectionError(String error,String requestCode);
}