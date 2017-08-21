part of model_base;

enum EVENT_TYPE
{
  logged_in,
  received_invitation,
  received_push_notification_email,
  received_push_notification_sms,
  viewed_learning_content,
  was_created,
  was_deleted,
}

class LogEvent extends ModelBase
{
  LogEvent(String course, String user, EVENT_TYPE event_type, {String info = null, String long_info = null}) : super()
  {
    this.course = course;
    this.user = user;
    this.info = info;
    this.longInfo = long_info;
    this.timestamp = ModelBase.df.format(new DateTime.now());

    this.eventType = event_type.toString().substring("EVENT_TYPE.".length);
  }

  LogEvent.decode(Map<String, String> data) : super.decode(data)
  {
    course = data["course"];
    user = data["user"];
    timestamp = data["timestamp"];
    eventType = data["event_type"];

    info = data["info"];
    longInfo = data["long_info"];
  }

  @override
  Map<String, String> toTableRow()
  {
    return
      {
        "plan":course,
        "user":user,
        "event":eventType,
        "info":info,
        "timestamp":ModelBase.df.format(DateTime.parse(timestamp))
      };
  }

  String get course => _properties["course"];
  String get user => _properties["user"];
  String get timestamp => _properties["timestamp"];
  String get info => _properties["info"];
  String get longInfo => _properties["long_info"];
  String get eventType => _properties["event_type"];

  void set course(String value) { _properties["course"] = value; }
  void set user(String value) { _properties["user"] = value; }
  void set timestamp(String value) { _properties["timestamp"] = value; }
  void set info(String value) { _properties["info"] = value; }
  void set longInfo(String value) { _properties["long_info"] = value; }
  void set eventType(String value) { _properties["event_type"] = value; }

}