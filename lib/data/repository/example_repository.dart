import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_movies_app/core/constants/remote_constants.dart';
import 'package:flutter_movies_app/domain/repository/example_respository_abstract.dart';

class ExampleRepository extends ExampleRepositoryAbstract {
  final Dio _client;
  ExampleRepository({required Dio client}) : _client = client;
}
