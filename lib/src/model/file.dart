import 'package:fo_components/fo_components.dart' show DataTableModel;

class FileModel extends DataTableModel
{
  FileModel(this._name, this._type, this._size) : super(_name);

  Map<String, String> toTableRow()
  {
    return {"name" : _name, "type" : _type, "size" : _size};
  }

  String get name => _name;
  String get type => _type;
  String get size => _size;

  final String _name;
  final String _type;
  final String _size;
}