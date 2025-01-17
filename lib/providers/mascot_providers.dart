import 'package:rive_app/helpers/rive_helper.dart';
import 'package:rive_app/models/enums.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'mascot_providers.g.dart';

@riverpod
class SelectedMascotHat extends _$SelectedMascotHat {
  @override
  MascotHatOptions build() {
    return MascotHatOptions.none;
  }

  void updateHat(MascotHatOptions hat) {
    state = hat;
  }
}

@riverpod
class SelectedMascotName extends _$SelectedMascotName {
  @override
  String build() {
    return RiveHelper.defaultName;
  }

  void updateName(String name) {
    state = name;
  }
}

@riverpod
class SelectedMascotAction extends _$SelectedMascotAction {
  @override
  MascotActions build() {
    return MascotActions.altintro;
  }

  void updateAction(MascotActions action) {
    state = action;
  }
}