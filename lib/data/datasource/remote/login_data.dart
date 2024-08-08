import 'package:queue_project/core/class/crud.dart';
import 'package:queue_project/linkapi.dart';

class LoginData {
  Crud crud;
  LoginData(this.crud);

  logEmail(email, fcm, password) async {
    var response = await crud.postData(AppLink.loginremail, {
      "email": email,
      "fcm_token": fcm,
      "password": password,
    }, {});
    return response.fold((l) => l, (r) => r);
  }
}
