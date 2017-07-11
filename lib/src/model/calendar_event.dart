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

    final DateFormat df = new DateFormat("yyyyMMdd'T'HHmmss");
    for (DateTime dt in dates)
    {
      DateTime start = dt;
      DateTime end = dt.add(const Duration(hours: 1));
      _properties["starts"].add("${df.format(start)}");
      _properties["ends"].add("${df.format(end)}");
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
}