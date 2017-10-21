part of model_base;

class Action extends ModelBase
{
  @override
  Action() : super()
  {
    pushNotificationRegistry = new List();
  }

  @override
  Action.decode(Map<String, dynamic> data) : super.decode(data)
  {
    name = data["name"];
    description = data["description"];
    location = data["location"];
    learningContentId = data["learning_content_id"];
    pushNotificationRegistry = (data.containsKey("push_notification_registry")) ? JSON.decode(data["push_notification_registry"]) : new List();
  }

  @override
  Map<String, dynamic> encode()
  {
    Map<String, dynamic> data = super.encode();
    data["push_notification_registry"] = JSON.encode(pushNotificationRegistry);

    return data;
  }

  @override
  Map<String, String> toTableRow()
  {
    Map<String, String> output = new Map();
    output["name"] = name;
    output["location"] = location;
    return output;
  }

  void copyData(Action other)
  {
    name = other.name;
    description = other.description;
    location = other.location;
    learningContentId = other.learningContentId;
    pushNotificationRegistry = other.pushNotificationRegistry == null ? new List() : new List.from(other.pushNotificationRegistry);
  }

  Map<String, dynamic> get courseIndexEncoded => {"id":id, "day":day, "time":time, "highlight":highlight};
  Map<String, dynamic> get userIndexEncoded => {"id":id, "date":ModelBase.dfDate.format(date), "time":time};

  String get name => _properties["name"];
  String get description => _properties["description"];
  String get location => _properties["location"];
  String get learningContentId => _properties["learning_content_id"];
  List<Map<String, dynamic>> get pushNotificationRegistry => _properties["push_notification_registry"];

  void set name(String value) { _properties["name"] = value; }
  void set description(String value) { _properties["description"] = value; }
  void set location(String value) { _properties["location"] = value; }
  void set learningContentId(String value) { _properties["learning_content_id"] = value; }
  void set pushNotificationRegistry(List<Map<String, dynamic>> value) { _properties["push_notification_registry"] = value; }

  int day = 0;
  DateTime date;
  String time = "12:00";
  bool highlight = false;
  bool popupOpen = false;
}