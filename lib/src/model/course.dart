part of model_base;

class Course extends ModelBase
{
  @override
  Course() : super()
  {
    name = "";
    footerLearningContent1 = "";
    footerLearningContent2 = "";
    video1 = "";
    video2 = "";
    video3 = "";
  }

  @override
  Course.decode(Map<String, dynamic> data) : super.decode(data)
  {
    footerLearningContent1 = data["footer_learning_content1"];
    footerLearningContent2 = data["footer_learning_content2"];
    name = data["name"];
    video1 = data["video1"];
    video2 = data["video2"];
    video3 = data["video3"];

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
    return data;
  }

  @override
  Map<String, String> toTableRow()
  {
    Map<String, String> output = new Map();
    output["namn"] = name;
    return output;
  }

  @override
  String toString() => name;

  bool get valid =>
      name != null && name.isNotEmpty
          && actions.isNotEmpty
          && learningContents.isNotEmpty
          && footerLearningContent1 != null && footerLearningContent1.isNotEmpty
          && footerLearningContent2 != null && footerLearningContent2.isNotEmpty
          && video1 != null && video1.isNotEmpty
          && video2 != null && video2.isNotEmpty
          && video3 != null && video3.isNotEmpty;

  List<Action> actions = new List();
  List<LearningContent> learningContents = new List();

  String get footerLearningContent1 => _properties["footer_learning_content1"];
  String get footerLearningContent2 => _properties["footer_learning_content2"];
  String get name => _properties["name"];
  String get video1 => _properties["video1"];
  String get video2 => _properties["video2"];
  String get video3 => _properties["video3"];

  void set footerLearningContent1(String value) { _properties["footer_learning_content1"] = value; }
  void set footerLearningContent2(String value) { _properties["footer_learning_content2"] = value; }
  void set name(String value) { _properties["name"] = value; }
  void set video1(String value) { _properties["video1"] = value; }
  void set video2(String value) { _properties["video2"] = value; }
  void set video3(String value) { _properties["video3"] = value; }
}