import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'custom_navigation_viewmodel.g.dart';

class CustomNavigationState {
  CustomNavigationState({this.currentIndex = 0});
  final int currentIndex;

  CustomNavigationState copyWith({int? currentIndex}) {
    return CustomNavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

@riverpod
class CustomNavigationViewmodel extends _$CustomNavigationViewmodel {
  @override
  CustomNavigationState build() {
    return CustomNavigationState();
  }

  void changeIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }
}
