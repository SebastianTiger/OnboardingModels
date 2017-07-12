part of model_service;

@Injectable()
class UserService extends ModelService
{
  UserService(this._actionService, this._learningContentService, this._configService) : super("user")
  {
    _authQuery.apiUrl = "https://auth.minoch.com/v1/";
  }

  @override
  Future delete(User user) async
  {
    await super.delete(user);
    await _authQuery.post("users/unregister", {"client":_configService.model.subdomain});
  }

  @override
  Future<String> put(User user) async
  {
    try
    {
      await _authQuery.put("users", {"client":"test", "email":user.email, "firstname":user.firstname, "lastname":user.lastname});
    }
    catch (e)
    {
      print(e.target);

    }
    String id = await super.put(user);
    return id;
  }

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

  Future<User> login(String username, String password) async
  {
    try
    {
      return await fetchModel(await _dq.post("/user_auth", {"msg":"login", "username":username, "password":password}));
    }
    catch (e)
    {
      print(e);
      print(e.target.responseText);
      return null;
    }
  }

  void populateActionsAndLearningContents(User user)
  {
    user.actions.where((a) => a.name == null).forEach((a)
    => a.copyData(_actionService.getModel(a.id)));

    user.learningContents.where((lc) => lc.name == null).forEach((lc)
    => lc.copyData(_learningContentService.getModel(lc.id)));
  }

  @override
  Map<String, User> _onDataFetched(String response, bool buffer)
  {
    List<Map<String, String>> table = JSON.decode(response);
    Map<String, User> output = new Map();
    table.forEach((row) => output[row["id"]] = new User.decode(row));
    if (buffer) _data = output;
    return output;
  }

  final ActionService _actionService;
  final ConfigService _configService;
  final LearningContentService _learningContentService;

  final DigQuery _authQuery = new DigQuery();
}