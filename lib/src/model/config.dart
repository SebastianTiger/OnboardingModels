part of model_base;

class Config extends ModelBase
{
  @override
  Config() : super();

  @override
  Config.decode(Map<String, dynamic> data) : super.decode(data)
  {
    _properties = new Map.from(data);
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
  String get subdomain => _properties["subdomain"];

  void set color1(String value) { _properties["color1"] = value; }
  void set color2(String value) { _properties["color2"] = value; }
  void set color3(String value) { _properties["color3"] = value; }
  void set customCSS(String value) { _properties["custom_css"] = value; }
  void set imgLogo(String value) { _properties["logo_base64"] = value; }
  void set imgTimelineBackground(String value) { _properties["timeline_background_base64"] = value; }
  void set favicon(String value) { _properties["favicon_base64"] = value; }
  //void set subdomain(String value) { _properties["subdomain"] = value; }
}