part of model_base;

class PushNotification extends ModelBase
{
  @override
  PushNotification() : super()
  {
    email = true;
    sms = true;
    emailEmbedded = true;

    emailMessage = "";
    smsMessage = "";
  }

  @override
  PushNotification.decode(Map<String, dynamic> data) : super.decode(data)
  {
    name = data["name"];
    emailSubject = data["email_subject"];
    emailMessage = data["email_message"];
    smsMessage = data["sms_message"];
    email = data["email"] == "1";
    sms = data["sms"] == "1";
    emailEmbedded = data["email_embedded"] == "1";
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
    output["email"] = email.toString();
    output["sms"] = sms.toString();
    return output;
  }

  @override
  String toString() => name;

  String get name => _properties["name"];
  String get emailSubject => _properties["email_subject"];
  String get emailMessage => _properties["email_message"];
  String get smsMessage => _properties["sms_message"];
  bool get email => _properties["email"];
  bool get sms => _properties["sms"];
  bool get emailEmbedded => _properties["email_embedded"];

  void set name(String value) { _properties["name"] = value; }
  void set emailSubject(String value) { _properties["email_subject"] = value; }
  void set emailMessage(String value) { _properties["email_message"] = value; }
  void set smsMessage(String value) { _properties["sms_message"] = value; }
  void set email(bool value) { _properties["email"] = value; }
  void set sms(bool value) { _properties["sms"] = value; }
  void set emailEmbedded(bool value) { _properties["email_embedded"] = value; }
}