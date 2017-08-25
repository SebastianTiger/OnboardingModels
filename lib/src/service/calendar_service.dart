import 'dart:async';
import 'package:angular2/angular2.dart';
import '../model/model_base.dart' show CalendarEvent;
import 'package:onboarding_models/src/service/http_service.dart';

@Injectable()
class CalendarService extends HttpService
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
      throw new Exception(e);
    }
  }
}
