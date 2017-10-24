part of model_service;

@Injectable()
class LearningContentService extends ModelService<LearningContent>
{
  LearningContentService() : super("learning_content");

  LearningContent getModel(String id) => _data.containsKey(id) ? _data[id] : null;

  @override
  LearningContent create(Map<String, dynamic> model_data) => new LearningContent.decode(model_data);

  @override
  Map<String, LearningContent> _onDataFetched(List<Map<String, dynamic>> response, bool buffer)
  {
    Map<String, LearningContent> output = new Map();
    response.forEach((row) => output[row["id"]] = new LearningContent.decode(row));
    if (buffer) _data = output;
    return output;
  }
}
