part of model_service;

@Injectable()
class LogService extends ModelService
{
  LogService() : super("log");

  @override
  LogEvent getModel(String id) => (_data.containsKey(id)) ? _data[id] : null;

  @override
  LogEvent create(Map<String, dynamic> data) => new LogEvent.decode(data);

  @override
  Map<String, LogEvent> _onDataFetched(List<Map<String, dynamic>> response, bool buffer)
  {
    Map<String, LogEvent> output = new Map();
    response.forEach((row) => output[row["id"]] = new LogEvent.decode(row));
    if (buffer) _data = output;
    return output;
  }
}