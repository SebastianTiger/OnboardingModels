import 'package:fo_components/fo_components.dart' show FoModel;

class FileModel extends FoModel
{
  FileModel(String name, this._type, this._size) : super(name);

  Map<String, String> toTableRow()
  {
    return {"name" : id, "type" : _type, "size" : _size};
  }

  //String get name => _name;
  String get type => _type;
  String get size => _size;

  //final String _name;
  final String _type;
  final String _size;
}