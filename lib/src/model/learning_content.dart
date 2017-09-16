part of model_base;

class LearningContent extends ModelBase
{
  @override
  LearningContent() : super()
  {
    icon = "check";
    embed = false;
    contentType = "file";
  }

  @override
  LearningContent.decode(Map<String, dynamic> data) : super.decode(data)
  {
    name = data["name"];
    description = data["description"];
    contentType = data["content_type"];
    url = data["url"];
    urlTitle = data["url_title"];
    icon = data["icon"];
    embed = data["embed"] == "1";
    pushNotificationId = data["push_notification_id"];
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
    output["name"] = name;
    output["content_type"] = contentType;
    output["url"] = url;
    output["embedded"] = embed.toString();
    return output;
  }

  String toString() => (name == null) ? id : name;

  void copyData(LearningContent other)
  {
    name = other.name;
    description = other.description;
    contentType = other.contentType;
    url = other.url;
    urlTitle = other.urlTitle;
    icon = other.icon;
    embed = other.embed;
    pushNotificationId = other.pushNotificationId;
  }

  Map<String, dynamic> get courseIndexEncoded => {"id":id};
 // Map<String, dynamic> get userIndexEncoded => {"id":id, "viewed":viewed};

  String get name => _properties["name"];
  String get description => _properties["description"];
  String get contentType => _properties["content_type"];
  String get url => _properties["url"];
  String get urlTitle => _properties["url_title"];
  String get icon => _properties["icon"];
  bool get embed => _properties["embed"];
  String get pushNotificationId => _properties["push_notification_id"];

  void set name(String value) { _properties["name"] = value; }
  void set description(String value) { _properties["description"] = value; }
  void set contentType(String value) { _properties["content_type"] = value; }
  void set url(String value) { _properties["url"] = value; }
  void set urlTitle(String value) { _properties["url_title"] = value; }
  void set icon(String value) { _properties["icon"] = value; }
  void set embed(bool value) { _properties["embed"] = value; }
  void set pushNotificationId(String value) { _properties["push_notification_id"] = value; }

  bool viewed = false;
}