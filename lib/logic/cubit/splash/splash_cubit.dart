import 'package:bloc/bloc.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashLoading());

  void intialUserIdFromPrefs() async {
    var userId = await userSharedPrefs();
    bool isSplashed = await splahSharedPrefs();

    if ((userId == "" || userId == "0") && !isSplashed) {
      await Future.delayed(const Duration(seconds: 3));
      setSplashSharedPrefs();
      print("SplashIsGuest");
      emit(SplashIsGuest());
    } else {
      await Future.delayed(const Duration(seconds: 3));
      GlobalWidget.userId = userId;
      print("SplashIsUser");
      emit(SplashIsUser(userId: GlobalWidget.userId));
    }
  }

  Future<String> userSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = "0";

    id = (prefs.getString('id') ?? "0");
    print('sharedPrefs : $id');
    return id;
  }

  Future<bool> splahSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSplashed = false;

    isSplashed = (prefs.getBool('splash') ?? false);
    print('splashSharedPrefs : $isSplashed');
    return isSplashed;
  }

  void setSplashSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("splash", true);
  }
}
