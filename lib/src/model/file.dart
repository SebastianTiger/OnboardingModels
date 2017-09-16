import 'package:fo_components/fo_components.dart' show FoModel;

class FileModel extends FoModel
{
  FileModel(String name, this._type, this._sizeKb) : super(name);

  Map<String, String> toTableRow()
  {
    return {"name" : id, "type" : _type, "size_kb" : _sizeKb.toString()};
  }

  String get type => _type;
  int get sizeKb => _sizeKb;

  final String _type;
  final int _sizeKb;
}