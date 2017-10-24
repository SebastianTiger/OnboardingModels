part of model_service;

@Injectable()
class ActionService extends ModelService<Action>
{
  ActionService() : super("action");

  Action create(Map<String, dynamic> model_data) => new Action.decode(model_data);

  Action getModel(String id) => _data.containsKey(id) ? _data[id]: null;

  @override
  Map<String, Action> _onDataFetched(List<Map<String, dynamic>> response, bool buffer)
  {
    Map<String, Action> output = new Map();
    response.forEach((row) => output[row["id"]] = new Action.decode(row));
    if (buffer) _data = output;
    return output;
  }
}
