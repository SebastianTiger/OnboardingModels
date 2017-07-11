import 'dart:async';
import 'package:angular2/angular2.dart';
import '../util/dig_query.dart';
import '../model/model_base.dart' show CalendarEvent;

@Injectable()
class CalendarService
{
  CalendarService();

  Future put(CalendarEvent model) async
  {
    try
    {
      _loading = true;
      await _dq.put("/calendar", model.encode());
      _loading = false;
    }
    on NoSuchMethodError catch (e)
    {
      throw new Exception(e);
    }
    catch (e)
    {
      throw new Exception(e.target.responseText);
    }
  }

  bool get isLoading => _loading;

  bool _loading = false;
  final DigQuery _dq = new DigQuery();
}
