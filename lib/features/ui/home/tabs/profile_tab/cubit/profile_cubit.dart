import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/profile_data.dart';
import '../repository/profile_repository.dart';

class ProfileCubit extends Cubit<ProfileData> {
  final ProfileRepository _repository;

  ProfileCubit(this._repository) : super(ProfileData.initial);

  Future<void> load() async {
    try {
      emit(await _repository.getProfile());
    } catch (e) {
      debugPrint('LOAD PROFILE ERROR: $e');
    }
  }

  Future<void> update({
    required String name,
    required String phone,
    required int avatarIndex,
  }) async {
    await _repository.updateProfile(
      name: name,
      phone: phone,
      avatarIndex: avatarIndex,
    );
    emit(ProfileData(name: name, phone: phone, avatarIndex: avatarIndex));
  }

  void reset() => emit(ProfileData.initial);
}
