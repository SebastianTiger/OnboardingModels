class LinkedInModule
{
  LinkedInModule()
  {
    coworkerUrls = [];
    learningContentId = "";
    active = false;
  }

  LinkedInModule.decode(Map<String, dynamic> data)
  {
    coworkerUrls = data["coworker_urls"];
    learningContentId = data["learning_content_id"];
    active = data["active"] == "1";
  }

  Map<String, dynamic> get data
  {
    Map<String, dynamic> data = new Map();
    data["coworker_urls"] = coworkerUrls;
    data["learning_content_id"] = learningContentId;
    data["active"] = active ? "1" : "0";
    return data;
  }

  List<String> coworkerUrls;
  String learningContentId;
  bool active;
}