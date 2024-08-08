import 'package:queue_project/core/class/crud.dart';
import 'package:queue_project/linkapi.dart';

class RegisterData {
  Crud crud;
  RegisterData(this.crud);

  regEmail(name, email, phone, password) async {
    var response = await crud.postData(AppLink.registerEmail, {
      "name": name,
      "phone_number": phone,
      "email": email,
      "password": password,
    }, {});
    return response.fold((l) => l, (r) => r);
  }
}
