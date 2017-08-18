part of model_base;

class LogEvent extends ModelBase
{
  LogEvent(String course, String user, String event_type, {String info = null, String long_info = null}) : super()
  {
    this.course = course;
    this.user = user;
    this.eventType = event_type;
    this.info = info;
    this.longInfo = long_info;
    this.timestamp = ModelBase.df.format(new DateTime.now());
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
        "användare":user,
        "händelse":eventType,
        "info":info,
        "tidpunkt":ModelBase.df.format(DateTime.parse(timestamp))
      };
  }

  String get course => _properties["course"];
  String get user => _properties["user"];
  String get timestamp => _properties["timestamp"];
  String get eventType => _properties["event_type"];
  String get info => _properties["info"];
  String get longInfo => _properties["long_info"];

  void set course(String value) { _properties["course"] = value; }
  void set user(String value) { _properties["user"] = value; }
  void set timestamp(String value) { _properties["timestamp"] = value; }
  void set eventType(String value) { _properties["event_type"] = value; }
  void set info(String value) { _properties["info"] = value; }
  void set longInfo(String value) { _properties["long_info"] = value; }
}