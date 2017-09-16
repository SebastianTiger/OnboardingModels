import 'package:angular/angular.dart';

@Injectable()
class OutputService
{
  void set(String message, [String title = 'error_occurred', bool show_ok_button = false])
  {
    _message = message;
    _title = title;
    _open = true;
    _showOkButton = show_ok_button;
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
  bool get showOkButton => _showOkButton;

  String _title;
  String _message;
  bool _showOkButton = false;
  bool _open;
}