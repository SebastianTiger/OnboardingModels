library model_base;
import 'dart:convert';
//import 'dart:html';
import 'package:intl/intl.dart' show DateFormat;
import 'package:fo_components/fo_components.dart' show DataTableModel;

part 'action.dart';
part 'calendar_event.dart';
part 'config.dart';
part 'course.dart';
part 'learning_content.dart';
part 'push_notification.dart';
part 'user.dart';

abstract class ModelBase extends DataTableModel
{
  ModelBase() : super(null);

  ModelBase.decode(Map<String, dynamic> data) : super(data["id"])
  {
    data.remove("id");
  }

  Map<String, dynamic> encode()
  {
    Map<String, dynamic> data = new Map();

    /// Auto-encode regular properties
    _properties.forEach((key, value)
    {
      if (value is String || value is num || value is bool) data[key] = value;
      else if (value is DateTime) data[key] = df.format(value);
    });
    data["id"] = id;
    return data;
  }

  Map<String, dynamic> get properties => _properties;
  Map<String, dynamic> _properties = new Map();


  static final DateFormat df = new DateFormat('y-MM-dd HH:mm:ss');
  static final DateFormat dfDate = new DateFormat('y-MM-dd');
}