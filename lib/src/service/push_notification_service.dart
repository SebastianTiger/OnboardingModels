part of model_service;

@Injectable()
class PushNotificationService extends ModelService
{
  PushNotificationService() : super("push_notification");

  PushNotification getModel(String id) => _data.containsKey(id) ? _data[id]: null;

  @override
  PushNotification create(Map<String, dynamic> model_data) => new PushNotification.decode(model_data);

  @override
  Map<String, PushNotification> _onDataFetched(String response, bool buffer)
  {
    List<Map<String, dynamic>> table = JSON.decode(response);
    Map<String, PushNotification> output = new Map();
    table.forEach((row) => output[row["id"]] = new PushNotification.decode(row));
    if (buffer) _data = output;
    return output;
  }
}
