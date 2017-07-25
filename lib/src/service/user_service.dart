part of model_service;

@Injectable()
class UserService extends ModelService
{
  UserService(this._actionService, this._learningContentService) : super("user");

  @override
  Future<User> fetchModel(String id) async
  {
    User user = await super.fetchModel(id);
    if (user != null) populateActionsAndLearningContents(user);
    return user;
  }

  @override
  User create(Map<String, dynamic> model_data) => new User.decode(model_data);

  User getModel(String id)
  {
    if (!_data.containsKey(id)) return null;
    User user = _data[id];
    populateActionsAndLearningContents(user);
    return user;
  }

  void populateActionsAndLearningContents(User user)
  {
    user.actions.where((a) => a.name == null).forEach((a)
    => a.copyData(_actionService.getModel(a.id)));

    user.learningContents.where((lc) => lc.name == null).forEach((lc)
    => lc.copyData(_learningContentService.getModel(lc.id)));
  }

  @override
  Map<String, User> _onDataFetched(Map<String, dynamic> response, bool buffer)
  {
    List<Map<String, String>> table = response['body'];
    Map<String, User> output = new Map();
    table.forEach((row) => output[row["id"]] = new User.decode(row));
    if (buffer) _data = output;
    return output;
  }

  final ActionService _actionService;
  final LearningContentService _learningContentService;
}