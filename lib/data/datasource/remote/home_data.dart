import 'package:queue_project/core/class/crud.dart';
import 'package:queue_project/linkapi.dart';

class HomeData {
  Crud crud;
  HomeData(this.crud);

  getServices() async {
    var response = await crud.getData(
      AppLink.services,
    );
    return response.fold((l) => l, (r) => r);
  }
}
