// run => fvm flutter pub run build_runner build --delete-conflicting-outputs
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'servicelocator.config.dart'; // الملف اللي هيطلع من الـ build_runner

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // ده الاسم اللي الـ generator هيستخدمه
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() {
  // 1. بنسجل الـ باكدجات الخارجية يدوياً الأول
  getIt.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());

  // 2. بننده على الـ init كـ extension عشان تسجل باقي الكلاسات التلقائية (الـ داتا سورس، الريبو، الـ UseCases)
  getIt.init(); 
}