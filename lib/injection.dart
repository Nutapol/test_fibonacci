import 'package:test_app/get_it-7.6.4/lib/get_it.dart';
import 'package:test_app/main/bloc/main_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupInjection() async {
  getIt.registerLazySingleton(
    () => MainCubit(),
  );
  //Register Other Cubit
  // getIt.registerFactory<MyOtherService>(() => MyOtherService());
}
