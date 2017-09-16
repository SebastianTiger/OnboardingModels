part of model_service;

@Injectable()
class UserService extends ModelService
{
  UserService(this._actionService, this._learningContentService) : super("user");

  @override
  Future<User> fetchModel(String id) async
  {
    User user = await super.fetchModel(id);
    populateActionsAndLearningContents(user);
    return user;
  }

  Future<User> fetchByUsername(String username) async
  {
    Map<String, User> users = await super.fetchAll(where: "username=$username");

    /**
     * An exception here indicates that the digicy user registry has become out
     * of sync with the auth user registry (the user exists in auth but not in
     * digicy user registry)
     */
    if (users.length != 1) throw new Exception("User \"$username\" was not found");
    return users.values.first;
  }

  @override
  User create(Map<String, dynamic> model_data) => new User.decode(model_data);

  User getModel(String id)
  {
    if (!_data.containsKey(id)) return null;
    return _data[id];
  }

  void populateActionsAndLearningContents(User user)
  {
    if (user == null || _learningContentService == null || _actionService == null) return;

    user.actions.where((a) => a.name == null).forEach((a)
    => a.copyData(_actionService.getModel(a.id)));

    user.learningContents.where((lc) => lc.name == null).forEach((lc)
    => lc.copyData(_learningContentService.getModel(lc.id)));
  }

  @override
  Map<String, User> _onDataFetched(List<Map<String, dynamic>> response, bool buffer)
  {
    Map<String, User> output = new Map();
    response.forEach((row)
    {
      String id = row["id"];
      User usr = new User.decode(row);
      populateActionsAndLearningContents(usr);
      output[id] = usr;
    });
    if (buffer) _data = output;
    return output;
  }

  final ActionService _actionService;
  final LearningContentService _learningContentService;
}