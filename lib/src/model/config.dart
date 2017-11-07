part of model_base;

/**
 * Sandbox
 *  - separate client source
 *  - separate database structure
 *  - can only use on client 'sandbox'
 *  - same backend code
 *
 * Staging
 *  - separate client source
 *  - same database structure
 *  - can use on any client
 *  - same backend code
 */

enum BuildMode
{
  sandbox,
  staging,
  live
}


class Config extends ModelBase
{
  final BuildMode _build = BuildMode.sandbox;
  final String _version = "1.1.31";

  @override
  Config.decode(Map<String, dynamic> data) : super.decode(data)
  {
    _properties = new Map.from(data);
    smsCount = int.parse(_properties["sms_count"]);
    uploadQuota = int.parse(_properties["upload_quota"]);
    modules = JSON.decode(_properties["modules"]);
    services = JSON.decode(_properties["services"]);

    if (_build == BuildMode.sandbox) _client = "sandbox";
    else
    {
      int dotIndex = Uri.base.host.indexOf(".");
      _client = Uri.base.host.substring(0, (dotIndex > 0) ? dotIndex : Uri.base.host.length);
      if (_client == "localhost") _client = "demo"; /* TODO change to whichever client currently tested (must also be changed on api.introduktion.nu) */
    }
  }

  @override
  Map<String, dynamic> encode()
  {
    Map<String, dynamic> data = super.encode();
    return data;
  }

  String get version => (_build == BuildMode.sandbox) ? _version + " (sandbox)" : _version;

  String get color1 => _properties["color1"];
  String get color2 => _properties["color2"];
  String get color3 => _properties["color3"];
  String get customCSS => _properties["custom_css"];
  String get imgLogo => _properties["logo_base64"];
  String get imgTimelineBackground => _properties["timeline_background_base64"];
  String get favicon => _properties["favicon_base64"];
  String get emailFrom => _properties["email_from"];
  String get smsFrom => _properties["sms_from"];
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
  void set emailFrom(String value) { _properties["email_from"] = value; }
  void set smsFrom(String value) { _properties["sms_from"] = value; }
  void set smsCount(int value) { _properties["sms_count"] = value; }
  void set uploadQuota(int value) { _properties["upload_quota"] = value; }
  void set modules(List<String> value) { _properties["modules"] = value; }
  void set services(List<String> value) { _properties["services"] = value; }

  String _client;
}