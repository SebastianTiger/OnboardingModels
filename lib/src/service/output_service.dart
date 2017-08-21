import 'package:angular2/angular2.dart';

@Injectable()
class OutputService
{
  void set(String message, [String title = 'error_occurred'])
  {
    _message = message;
    _title = title;
    _open = true;
  }

  void set open(bool value)
  {
    _open = value;
    if (!_open)
    {
      _title = null;
      _message = null;
    }
  }

  String get title => _title;
  String get message => _message;
  bool get open => _open;

  String _title;
  String _message;
  bool _open;
}