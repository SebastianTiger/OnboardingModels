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
    start = ModelBase.dfDate.format(new DateTime.now().add(const Duration(days: 30)));

    actionData = new List();
    learningContentData = new List();

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

    if (data["actions"] != null) actionData = JSON.decode(data["actions"]);
    else actionData = new List();

    if (data["learning_contents"] != null) learningContentData = JSON.decode(data["learning_contents"]);
    else learningContentData = new List();
  }

  @override
  Map<String, dynamic> encode()
  {
    Map<String, dynamic> data = super.encode();
    data["actions"] = JSON.encode(actionData);
    data["learning_contents"] = JSON.encode(learningContentData);

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

  List<Map<String, dynamic>> get actionData => _properties["action_data"];
  List<Map<String, dynamic>> get learningContentData => _properties["learning_content_data"];

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

  void set actionData(List<Map<String, String>> value)
  {
    _properties["action_data"] = new List.from(value);
  }

  void set learningContentData(List<Map<String, dynamic>> value)
  {
    _properties["learning_content_data"] = new List.from(value);
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