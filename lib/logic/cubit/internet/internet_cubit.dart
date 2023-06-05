import 'package:bloc/bloc.dart';
import '../../../networking/network_info.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:equatable/equatable.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  DataConnectionChecker connectionChecker;
  NetworkInfoImpl? networkInfo;

  InternetCubit({ required this.connectionChecker})
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
