import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tit/app/data/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  UserModel({
    required String accessToken,
    required String displayName,
    required String email,
    required String photoUrl,
    required String id,
    bool? active = false,
  }) : super(
            accessToken: accessToken,
            displayName: displayName,
            email: email,
            id: id,
            photoUrl: photoUrl,
            active: active??false);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    Map<String, dynamic>? json = snapshot.data();
    return UserModel.fromJson(json!);
  }

  Map<String, dynamic> toFireStore() => _$UserModelToJson(this);

  static UserModel convertEntityToUserModel(UserEntity userEntity) {
    return UserModel(
      accessToken: userEntity.accessToken ?? "",
      displayName: userEntity.displayName ?? "",
      email: userEntity.email ?? "",
      photoUrl: userEntity.photoUrl ?? "",
      id: userEntity.id ?? "",
    );
  }
}
