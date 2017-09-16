part of model_base;

class CalendarEvent extends ModelBase
{
  @override
  CalendarEvent(String filename, List<String> summaries, List<String> descriptions, List<String> locations, List<DateTime> dates) : super()
  {
    _properties["filename"] = filename;
    _properties["summaries"] = summaries;
    _properties["locations"] = locations;
    _properties["descriptions"] = descriptions;
    _properties["starts"] = new List();
    _properties["ends"] = new List();

    for (DateTime dt in dates)
    {
      DateTime start = dt;
      DateTime end = dt.add(const Duration(hours: 1));
      _properties["starts"].add("${dateFormat.format(start)}");
      _properties["ends"].add("${dateFormat.format(end)}");
    }
  }

  @override
  Map<String, dynamic> encode()
  {
    Map<String, dynamic> data = super.encode();

    data["descriptions"] = _properties["descriptions"];
    data["locations"] = _properties["locations"];
    data["summaries"] = _properties["summaries"];
    data["starts"] = _properties["starts"];
    data["ends"] = _properties["ends"];

    return data;
  }

  String toICAL()
  {
    String output = "";
    String timestamp = dateFormat.format(new DateTime.now()) + "Z";
    for (int index = 0; index < _properties["descriptions"].length; index++)
    {
      output += "BEGIN:VEVENT\n";
      output += "UID:${_properties['filename']}-$index\n";
      output += "DTSTAMP:$timestamp\n";
      output += "DTSTART;TZID=Europe/Stockholm:${_properties['starts'][index]}\n"; /* TODO Internationalization */
      output += "DTEND;TZID=Europe/Stockholm:${_properties['ends'][index]}\n";
      output += "SUMMARY:${_properties['summaries'][index]}\n";
      output += "LOCATION:${_properties["locations"][index]}\n";
      output += "DESCRIPTION:${_properties["descriptions"][index]}\n";
      output += "END:VEVENT\n";
    }
    return output;
  }

  final DateFormat dateFormat = new DateFormat("yyyyMMdd'T'HHmmss");
}