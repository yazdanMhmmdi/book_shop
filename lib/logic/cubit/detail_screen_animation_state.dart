part of 'detail_screen_animation_cubit.dart';

abstract class DetailScreenAnimationState extends Equatable {
  const DetailScreenAnimationState();

  @override
  List<Object> get props => [];
}

class DetailScreenAnimationInitial extends DetailScreenAnimationState {}

class DetailScreenAnimationStatus extends DetailScreenAnimationState {
  var maxBorderRadius = 50.0;
  var borderRadius = 50.0;
  var percent = 1.0;
  double draggableSize = 0.75;

  DetailScreenAnimationStatus(
      {required this.maxBorderRadius,
      required this.borderRadius,
      required this.draggableSize,
      required this.percent});

  @override
  List<Object> get props => [
        this.maxBorderRadius,
        this.borderRadius,
        this.borderRadius,
        this.draggableSize,
        this.percent
      ];
}
