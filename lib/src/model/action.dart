part of model_base;

class Action extends ModelBase
{
  @override
  Action() : super();

  @override
  Action.decode(Map<String, dynamic> data) : super.decode(data)
  {
    name = data["name"];
    description = data["description"];
    location = data["location"];
    learningContentId = data["learning_content_id"];
  }

  @override
  Map<String, dynamic> encode()
  {
    Map<String, dynamic> data = super.encode();
    return data;
  }

  @override
  Map<String, String> toTableRow()
  {
    Map<String, String> output = new Map();
    output["id"] = id;
    output["namn"] = name;
    output["plats"] = location;
    return output;
  }

  void copyData(Action other)
  {
    name = other.name;
    description = other.description;
    location = other.location;
    learningContentId = other.learningContentId;
  }

  Map<String, dynamic> get courseIndexEncoded => {"id":id, "day":day, "time":time, "highlight":highlight};
  Map<String, dynamic> get userIndexEncoded => {"id":id, "date":ModelBase.dfDate.format(date), "time":time};

  String get name => _properties["name"];
  String get description => _properties["description"];
  String get location => _properties["location"];
  String get learningContentId => _properties["learning_content_id"];

  void set name(String value) { _properties["name"] = value; }
  void set description(String value) { _properties["description"] = value; }
  void set location(String value) { _properties["location"] = value; }
  void set learningContentId(String value) { _properties["learning_content_id"] = value; }

  int day = 0;
  DateTime date;
  String time = "12:00";
  bool highlight = false;

  bool popupOpen = false;
}