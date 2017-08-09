part of model_service;

@Injectable()
class CourseService extends ModelService
{
  CourseService(this._actionService, this._learningContentService) : super("course");

  @override
  Course getModel(String id)
  {
    if (!_data.containsKey(id)) return null;
    return _data[id];
  }

  @override
  Future<Course> fetchModel(String id) async
  {
    Course course = await super.fetchModel(id);
    _populateActionsAndLearningContents(course);
    return course;
  }

  @override
  Course create(Map<String, dynamic> model_data) => new Course.decode(model_data);

  void _populateActionsAndLearningContents(Course course)
  {
    if (course == null || _learningContentService == null || _actionService == null) return;
    course.actions.where((a) => a.name == null).forEach((a)
    => a.copyData(_actionService.getModel(a.id)));

    course.learningContents.where((lc) => lc.name == null).forEach((lc)
    => lc.copyData(_learningContentService.getModel(lc.id)));
  }

  @override
  Map<String, Course> _onDataFetched(List<Map<String, dynamic>> response, bool buffer)
  {
    Map<String, Course> output = new Map();
    response.forEach((row)
    {
      String id = row["id"];
      Course course = new Course.decode(row);
      _populateActionsAndLearningContents(course);
      output[id] = course;
    });
    if (buffer) _data = output;
    return output;
  }

  final ActionService _actionService;
  final LearningContentService _learningContentService;
}
