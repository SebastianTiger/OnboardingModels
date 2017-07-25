import 'dart:async';
import 'package:angular2/angular2.dart';
import '../model/model_base.dart' show CalendarEvent;
import 'package:onboarding_models/src/service/service_base.dart';

@Injectable()
class CalendarService extends ServiceBase
{
  CalendarService();

  Future put(CalendarEvent model) async
  {
    try
    {
      await httpPUT("calendar", model.encode());
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
}
