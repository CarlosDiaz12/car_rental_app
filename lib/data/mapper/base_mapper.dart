abstract class BaseMapper<Model, Dto> {
  Dto toDto(Model model);
  Model toModel(Dto dto);
}
