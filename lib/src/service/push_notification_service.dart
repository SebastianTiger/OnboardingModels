part of model_service;

@Injectable()
class PushNotificationService extends ModelService<PushNotification>
{
  PushNotificationService() : super("push_notification");

  PushNotification getModel(String id) => _data.containsKey(id) ? _data[id]: null;

  @override
  PushNotification create(Map<String, dynamic> model_data) => new PushNotification.decode(model_data);

  @override
  Map<String, PushNotification> _onDataFetched(List<Map<String, dynamic>> response, bool buffer)
  {
    Map<String, PushNotification> output = new Map();
    response.forEach((row) => output[row["id"]] = new PushNotification.decode(row));
    if (buffer) _data = output;
    return output;
  }
}
