part of model_base;

class Course extends ModelBase
{
  @override
  Course() : super()
  {
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

    if (data["actions"] != null)
    {
      List<Map<String, dynamic>> actionTable = JSON.decode(data["actions"]);
      for (Map<String, dynamic> row in actionTable)
      {
        Action action = new Action();
        action.id = row["id"];
        action.day = row["day"];
        action.time = row["time"];
        actions.add(action);
      }
    }
    if (data["learning_contents"] != null)
    {
      List<Map<String, dynamic>> learningContentTable = JSON.decode(data["learning_contents"]);
      for (Map<String, dynamic> row in learningContentTable)
      {
        LearningContent learningContent = new LearningContent();
        learningContent.id = row["id"];
        learningContents.add(learningContent);
      }
    }
  }

  @override
  Map<String, dynamic> encode()
  {
    Map<String, dynamic> data = super.encode();
    data["actions"] = JSON.encode(actions.map((action) => action.courseIndexEncoded).toList());
    data["learning_contents"] = JSON.encode(learningContents.map((learning_content) => learning_content.courseIndexEncoded).toList());

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
          && actions.isNotEmpty
          && learningContents.isNotEmpty
          && video1 != null && video1.isNotEmpty
          && video2 != null && video2.isNotEmpty
          && video3 != null && video3.isNotEmpty;

  List<Action> actions = new List();
  List<LearningContent> learningContents = new List();

  String get name => _properties["name"];
  String get video1 => _properties["video1"];
  String get video2 => _properties["video2"];
  String get video3 => _properties["video3"];

  void set name(String value) { _properties["name"] = value; }
  void set video1(String value) { _properties["video1"] = value; }
  void set video2(String value) { _properties["video2"] = value; }
  void set video3(String value) { _properties["video3"] = value; }

  LinkedInModule linkedInModule = new LinkedInModule();
}