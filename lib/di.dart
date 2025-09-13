import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:test_flutter/config.dart';
import 'package:test_flutter/dio.dart';
import 'package:test_flutter/hive.dart';
import 'package:test_flutter/repositories/repositories.dart';
import 'package:test_flutter/services/services.dart';
import 'package:test_flutter/viewmodel/viewmodels.dart';

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
  final Services services;
  final Repositories repositories;
  final ViewModels viewModels;
  final BoxCollection collection;

  Container({
    required this.collection,
    required this.services,
    required this.repositories,
    required this.viewModels,
  });
}

Services services(ClientConfig config) {
  final dio = Dio(baseOptions(config));
  final businessService = BusinessService(dio);

  return Services(businessService: businessService);
}

Repositories repositories(Services services) {
  final businessRepository = BusinessRepository(services.businessService);
  return Repositories(businessRepository: businessRepository);
}

ViewModels viewModels(Repositories repositories) {
  final businessViewModel = BusinessViewModel(repository: repositories.businessRepository);
  return ViewModels(businessViewModel: businessViewModel);
}

Future<Container> container() async {
  await dotenv.load(fileName: ".env");
  final config = Config.instance(dotenv.env);
  final collection = await appCollection(config.collection);
  final servicesObject = services(config.client);
  final repositoriesObject = repositories(servicesObject);
  final viewModelsObject = viewModels(repositoriesObject);

  return Container(
    collection: collection,
    services: servicesObject,
    repositories: repositoriesObject,
    viewModels: viewModelsObject,
  );
}