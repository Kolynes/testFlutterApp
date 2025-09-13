import 'package:dio/dio.dart';
import 'package:test_flutter/dio.dart';
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

Services services() {
  final dio = Dio(baseOptions);
  final businessService = BusinessService(dio);

  return Services(businessService: businessService);
}

Repositories repositories() {
  final servicesObject = services();
  final businessRepository = BusinessRepository(servicesObject.businessService);
  return Repositories(businessRepository: businessRepository);
}

ViewModels viewModels() {
  final repositoriesObject = repositories();
  final businessViewModel = BusinessViewModel(repository: repositoriesObject.businessRepository);
  return ViewModels(businessViewModel: businessViewModel);
}