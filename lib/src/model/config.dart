part of model_base;

class Config extends ModelBase
{
  @override
  Config.decode(Map<String, dynamic> data) : super.decode(data)
  {
    _properties = new Map.from(data);
    smsCount = int.parse(_properties["sms_count"]);
    uploadQuota = int.parse(_properties["upload_quota"]);
    modules = JSON.decode(_properties["modules"]);
    services = JSON.decode(_properties["services"]);

    int dotIndex = Uri.base.host.indexOf(".");
    _client = Uri.base.host.substring(0, (dotIndex > 0) ? dotIndex : Uri.base.host.length);
    if (_client == "localhost") _client = "larbyran"; /* TODO CHANGE TO SANDBOX */
  }

  @override
  Map<String, dynamic> encode()
  {
    Map<String, dynamic> data = super.encode();
    return data;
  }

  String get color1 => _properties["color1"];
  String get color2 => _properties["color2"];
  String get color3 => _properties["color3"];
  String get customCSS => _properties["custom_css"];
  String get imgLogo => _properties["logo_base64"];
  String get imgTimelineBackground => _properties["timeline_background_base64"];
  String get favicon => _properties["favicon_base64"];
  int get smsCount => _properties["sms_count"];
  int get uploadQuota =>  _properties["upload_quota"];
  List<String> get modules => _properties["modules"];
  List<String> get services => _properties["services"];
  String get client => _client;

  void set color1(String value) { _properties["color1"] = value; }
  void set color2(String value) { _properties["color2"] = value; }
  void set color3(String value) { _properties["color3"] = value; }
  void set customCSS(String value) { _properties["custom_css"] = value; }
  void set imgLogo(String value) { _properties["logo_base64"] = value; }
  void set imgTimelineBackground(String value) { _properties["timeline_background_base64"] = value; }
  void set favicon(String value) { _properties["favicon_base64"] = value; }
  void set smsCount(int value) { _properties["sms_count"] = value; }
  void set uploadQuota(int value) { _properties["upload_quota"] = value; }
  void set modules(List<String> value) { _properties["modules"] = value; }
  void set services(List<String> value) { _properties["services"] = value; }

  String _client;
}