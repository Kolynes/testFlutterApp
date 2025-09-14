import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:test_flutter/config.dart';
import 'package:test_flutter/dio.dart';
import 'package:test_flutter/hive.dart';
import 'package:test_flutter/repositories/repositories.dart';
import 'package:test_flutter/services/services.dart';
import 'package:test_flutter/viewmodel/viewmodels.dart';

class Interceptors {
  final RetryInterceptor retryInterceptor;

  Interceptors({required this.retryInterceptor});
}

class Services {
  final BusinessService businessService;

  Services({required this.businessService});
}

class Repositories {
  final BusinessRepository businessRepository;

  Repositories({required this.businessRepository});
}

class ViewModels {
  final BusinessViewModel businessViewModel;

  ViewModels({required this.businessViewModel});
}

class Container {
  final Dio dio;
  final Services services;
  final Repositories repositories;
  final ViewModels viewModels;
  final Interceptors interceptors;

  Container({
    required this.dio,
    required this.services,
    required this.repositories,
    required this.viewModels,
    required this.interceptors,
  });
}

Dio dio(ClientConfig config) {
  final dio = Dio(baseOptions(config));

  return dio;
}

Interceptors interceptors(Dio dio) {
  final retryInterceptor = RetryInterceptor(dio: dio);

  dio.interceptors.add(retryInterceptor);

  return Interceptors(retryInterceptor: retryInterceptor);
}

Services services(Dio dio) {
  final businessService = BusinessService(dio);
  return Services(businessService: businessService);
}

Repositories repositories(Services services, BoxCollection collection) {
  final businessRepository = BusinessRepository(services.businessService, collection);
  return Repositories(businessRepository: businessRepository);
}

ViewModels viewModels(Repositories repositories) {
  final businessViewModel = BusinessViewModel(repository: repositories.businessRepository);
  return ViewModels(businessViewModel: businessViewModel);
}

Future<Container> container() async {
  await dotenv.load(fileName: ".env");
  final config = Config.instance(dotenv.env);
  final dioInstance = dio(config.client);
  final collection = await appCollection(config.collection);
  final interceptorsObject = interceptors(dioInstance);
  final servicesObject = services(dioInstance);
  final repositoriesObject = repositories(servicesObject, collection);
  final viewModelsObject = viewModels(repositoriesObject);

  return Container(
    dio: dioInstance,
    interceptors: interceptorsObject,
    services: servicesObject,
    repositories: repositoriesObject,
    viewModels: viewModelsObject,
  );
}