import 'package:queue_project/core/class/crud.dart';
import 'package:queue_project/linkapi.dart';

class QueueData {
  Crud crud;
  QueueData(this.crud);

  queue(userid, serviceid, headers) async {
    var response = await crud.postData(
        "${AppLink.API_URL}queue/${userid}",
        {
          "service_id": serviceid,
        },
        headers);
    return response.fold((l) => l, (r) => r);
  }
}
