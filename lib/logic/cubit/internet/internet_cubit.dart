import 'package:bloc/bloc.dart';
import 'package:book_shop/networking/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:equatable/equatable.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  DataConnectionChecker connectionChecker;
  NetworkInfoImpl? networkInfo;

  InternetCubit({required this.connectivity, required this.connectionChecker})
      : super(InternetLoading()) {
    networkInfo = NetworkInfoImpl(connectionChecker);
    networkInfo!.isConnected.listen((networkStatus) {
      if (networkStatus) {
        emitInternetConnected();
      } else {
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected() {
    emit(InternetConnected());
  }

  void emitInternetDisconnected() {
    emit(InternetDisconnected());
  }

  @override
  Future<void> close() {
    networkInfo!.dispose();
    return super.close();
  }
}
