import 'package:dock_flutter_example/core/core.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@immutable
@JsonSerializable()
final class LoginResponseModel extends BaseModel<LoginResponseModel> {
  const LoginResponseModel({this.id});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);

  final String? id;

  @override
  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);

  @override
  LoginResponseModel fromJson(Map<String, dynamic> json) {
    return _$LoginResponseModelFromJson(json);
  }
}
