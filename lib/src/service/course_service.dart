part of model_service;

@Injectable()
class CourseService extends ModelService
{
  CourseService(this._actionService, this._learningContentService) : super("course");

  @override
  Course getModel(String id)
  {
    if (!_data.containsKey(id)) return null;

    Course course = _data[id];
    populateActionsAndLearningContents(course);
    return course;
  }

  @override
  Course create(Map<String, dynamic> model_data) => new Course.decode(model_data);

  void populateActionsAndLearningContents(Course course)
  {
    course.actions.where((a) => a.name == null).forEach((a)
    => a.copyData(_actionService.getModel(a.id)));

    course.learningContents.where((lc) => lc.name == null).forEach((lc)
    => lc.copyData(_learningContentService.getModel(lc.id)));
  }

  @override
  Map<String, Course> _onDataFetched(Map<String, dynamic> response, bool buffer)
  {
    List<Map<String, String>> table = response['body'];
    Map<String, Course> output = new Map();
    table.forEach((row) => output[row["id"]] = new Course.decode(row));
    if (buffer) _data = output;
    return output;
  }

  final ActionService _actionService;
  final LearningContentService _learningContentService;
}
