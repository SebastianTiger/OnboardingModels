part of model_service;

@Injectable()
class CourseService extends ModelService<Course>
{
  CourseService() : super("course");

  @override
  Course getModel(String id) => (_data.containsKey(id)) ? _data[id] : null;

  /*
  @override
  Future<Course> fetchModel(String id) async
  {
    Course course = await super.fetchModel(id);
    return course;
  }
*/
  @override
  Course create(Map<String, dynamic> model_data) => new Course.decode(model_data);

  @override
  Map<String, Course> _onDataFetched(List<Map<String, dynamic>> response, bool buffer)
  {
    Map<String, Course> output = new Map();
    response.forEach((row)
    {
      String id = row["id"];
      Course course = new Course.decode(row);
      output[id] = course;
    });
    if (buffer) _data = output;
    return output;
  }
}
