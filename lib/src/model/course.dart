part of model_base;

class Course extends ModelBase
{
  @override
  Course() : super()
  {
    actionData = new List();
    learningContentData = new List();
    name = "";
    video1 = "";
    video2 = "";
    video3 = "";
  }

  @override
  Course.decode(Map<String, dynamic> data) : super.decode(data)
  {
    name = data["name"];
    video1 = data["video1"];
    video2 = data["video2"];
    video3 = data["video3"];

    try
    {
      Map<String, dynamic> moduleData = JSON.decode(data["module_data"]);
      if (moduleData.containsKey("linkedin")) linkedInModule = new LinkedInModule.decode(moduleData["linkedin"]);
      /// TODO decode any new modules here
    }
    on FormatException catch (e) { print(e); }

    actionData = (data["actions"] == null) ? new List() : JSON.decode(data["actions"]);
    learningContentData = (data["learning_contents"] == null) ? new List() : JSON.decode(data["learning_contents"]);
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
    output["name"] = name;
    return output;
  }

  @override
  String toString() => name;

  bool get valid =>
      name != null && name.isNotEmpty
          && video1 != null && video1.isNotEmpty
          && video2 != null && video2.isNotEmpty
          && video3 != null && video3.isNotEmpty;

  List<Map<String, String>> get actionData => _properties["action_data"];
  List<Map<String, dynamic>> get learningContentData => _properties["learning_content_data"];

  String get name => _properties["name"];
  String get video1 => _properties["video1"];
  String get video2 => _properties["video2"];
  String get video3 => _properties["video3"];

  void set actionData(List<Map<String, String>> value) { _properties["action_data"] = new List.from(value); }
  void set learningContentData(List<Map<String, dynamic>> value) { _properties["learning_content_data"] = new List.from(value); }

  void set name(String value) { _properties["name"] = value; }
  void set video1(String value) { _properties["video1"] = value; }
  void set video2(String value) { _properties["video2"] = value; }
  void set video3(String value) { _properties["video3"] = value; }

  LinkedInModule linkedInModule = new LinkedInModule();
}