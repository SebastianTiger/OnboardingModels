part of model_base;

class User extends ModelBase
{
  @override
  User() : super()
  {
    _properties["created"] = new DateTime.now();
    state = "video1";
    active = true;
    emailEmbedded = true;

    firstname = lastname = username = email = phone = emailMessage = emailSubject = smsMessage = "";
  }

  @override
  User.decode(Map<String, dynamic> data) : super.decode(data)
  {
    _properties["created"] = DateTime.parse(data["created"]);
    firstname = data["firstname"];
    lastname = data["lastname"];
    username = data["username"];
    email = data["email"];
    phone = data["phone"];
    start = data["start_date"];
    notified = (data.containsKey("notified") && data["notified"] != null) ? DateTime.parse(data["notified"]) : null;
    emailMessage = data["email_message"];
    smsMessage = data["sms_message"];
    emailSubject = data["email_subject"];
    emailEmbedded = data["email_embedded"] == "1";
    state = data["state"];
    course = data["course"];
    active = data["active"] == "1";
    try
    {
      Map<String, dynamic> moduleData = JSON.decode(data["module_data"]);
      if (moduleData.containsKey("linkedin")) linkedInModule = new LinkedInModule.decode(moduleData["linkedin"]);
      /// TODO decode any new modules here
    }
    on FormatException catch (e) { print(e); }

    if (data["actions"] != null)
    {
      List<Map<String, dynamic>> actionTable = JSON.decode(data["actions"]);
      for (Map<String, dynamic> row in actionTable)
      {
        Action action = new Action();
        action.id = row["id"];
        action.date = DateTime.parse(row["date"]);
        action.date = new DateTime(action.date.year, action.date.month, action.date.day, 12);
        action.time = row["time"];
        action.day = action.date.difference(startAsDateTime).inDays;
        actions.add(action);
      }
      actions.sort((a, b) => a.date.difference(b.date).inDays);
    }
    if (data["learning_contents"] != null)
    {
      List<Map<String, dynamic>> learningContentTable = JSON.decode(data["learning_contents"]);
      for (Map<String, dynamic> row in learningContentTable)
      {
        LearningContent learningContent = new LearningContent();
        learningContent.id = row["id"];

        if (row["viewed"] is String) learningContent.viewed = row["viewed"] == "1";
        else if (row["viewed"] is int) learningContent.viewed = row["viewed"] == 1;
        else learningContent.viewed = row["viewed"];
        _learningContents.add(learningContent);
      }
    }
  }

  @override
  Map<String, dynamic> encode()
  {
    Map<String, dynamic> data = super.encode();
    data["actions"] = JSON.encode(actions.map((action) => action.userIndexEncoded).toList());

    List<Map<String, dynamic>> encodedLearningContents = new List();
    for (LearningContent lc in _learningContents)
    {
      encodedLearningContents.add({"id":lc.id, "viewed":lc.viewed});
    }
    data["learning_contents"] = JSON.encode(encodedLearningContents);

    Map<String, dynamic> moduleData = new Map();
    if (linkedInModule != null) moduleData["linkedin"] = linkedInModule.data;
    /// TODO encode any new modules here

    data["module_data"] = JSON.encode(moduleData);

    return data;
  }

  @override
  Map<String, String> toTableRow()
  {
    Map<String, String> output = new Map();
    output["name"] = "$firstname $lastname";
    output["username"] = username;
    output["email"] = email;
    output["phone"] = phone;
    output["start"] = start;
    output["status"] = active ? "active" : "inactive";
    return output;
  }

  @override
  String toString() => username;

  List<Action> _actions = new List();
  List<LearningContent> _learningContents = new List();

  /**
   * Returns the same action as the one supplied in [value], but tied to the user
   * TODO change this so that it only has user-specific Action properties, and not a full Action object?
   */
  Action getUserAction(Action value) => actions.firstWhere((action) => action == value, orElse: () => null);


  /**
   * Returns the same learning content as the one supplied in [value], but tied to the user
   * TODO change this so that the user only has user-specific LearningContent properties, and not a full LearningContent object?
   */
  LearningContent getUserLearningContent(LearningContent value) => _learningContents.firstWhere((lc) => lc == value, orElse: () => null);

  String parsePlaceholders(String input)
  {
    if (username != null) input = input.replaceAll("%user_username%", username);
    if (firstname != null) input = input.replaceAll("%user_firstname%", firstname);
    if (lastname != null) input = input.replaceAll("%user_lastname%", lastname);
    if (email != null) input = input.replaceAll("%user_email%", email);
    if (phone != null) input = input.replaceAll("%user_phone%", phone);
    if (start != null) input = input.replaceAll("%user_start_date%", start);
    return input;
  }

  bool get hasEmail => email != null && email.isNotEmpty;
  bool get hasPhone => phone != null && phone.isNotEmpty;
  List<Action> get actions => _actions;
  List<LearningContent> get learningContents => _learningContents;
  DateTime get startAsDateTime => _properties["start_date"];
  DateTime get created => _properties["created"];
  String get firstname => _properties["firstname"];
  String get lastname => _properties["lastname"];
  String get username => _properties["username"];
  String get email => _properties["email"];
  String get phone => _properties["phone"];
  DateTime get notified => _properties["notified"];
  String get start => (_properties["start_date"] == null) ? null : ModelBase.dfDate.format(_properties["start_date"]);
  String get emailMessage => _properties["email_message"];
  String get smsMessage => _properties["sms_message"];
  String get emailSubject => _properties["email_subject"];
  bool get emailEmbedded => _properties["email_embedded"];
  String get state => _properties["state"];
  String get course => _properties["course"];
  bool get active => _properties["active"];

  void set actions(List<Action> value)
  {
    if (start == null)
    {
      start = ModelBase.dfDate.format(new DateTime.now().add(const Duration(days: 30)));
    }

    _actions = new List.from(value);
    for (Action action in _actions)
    {
      action.date = startAsDateTime.add(new Duration(days: action.day));
    }
  }

  /**
   * Set learning contents, but make sure previous learning contents keep their 'viewed' status
   */
  void set learningContents(List<LearningContent> value)
  {
    List<LearningContent> buffer = new List.from(_learningContents);
    _learningContents.clear();

    for (LearningContent lc in value)
    {
      if (buffer.contains(lc)) _learningContents.add(buffer.firstWhere((blc) => blc.id == lc.id));
      else _learningContents.add(lc);
    }

    _learningContents = new List.from(_learningContents);
  }
  void set firstname(String value) { _properties["firstname"] = value; }
  void set lastname(String value) { _properties["lastname"] = value; }
  void set username(String value) { _properties["username"] = value; }
  void set email(String value) { _properties["email"] = value; }
  void set phone(String value) { _properties["phone"] = value; }
  void set notified(DateTime value) { _properties["notified"] = value; }
  void set start(String value)
  {
    try
    {
      DateTime date = DateTime.parse(value);
      _properties["start_date"] = new DateTime(date.year, date.month, date.day, 12);
    }
    catch(e) { print(e); }
  }
  void set emailMessage(String value) { _properties["email_message"] = value; }
  void set smsMessage(String value) { _properties["sms_message"] = value; }
  void set emailSubject(String value) { _properties["email_subject"] = value; }
  void set emailEmbedded(bool value) { _properties["email_embedded"] = value; }
  void set state(String value) { _properties["state"] = value; }
  void set course(String value) { _properties["course"] = value; }
  void set active(bool value) { _properties["active"] = value; }

  String token;

  LinkedInModule linkedInModule = new LinkedInModule();
}