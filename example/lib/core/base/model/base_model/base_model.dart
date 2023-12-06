abstract class BaseModel<T> {
  const BaseModel();

  Map<String, dynamic> toJson();

  T fromJson(Map<String, dynamic> json);
}
