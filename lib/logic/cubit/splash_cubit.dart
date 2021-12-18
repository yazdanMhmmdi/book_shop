import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashLoading());

  void intialUserIdFromPrefs() async {
    if (await sharedPrefs() == "") {
      await Future.delayed(const Duration(seconds: 3));

      print("SplashIsGuest");
      emit(SplashIsGuest());
    } else {
      await Future.delayed(const Duration(seconds: 3));

      print("SplashIsUser");
      emit(SplashIsUser(userId: await sharedPrefs()));
    }
  }

  Future<String> sharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = "";

    id = (prefs.getString('id') ?? "");
    print('sharedPrefs : $id');
    return id;
  }
}
