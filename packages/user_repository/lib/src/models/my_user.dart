import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

class MyUser extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? biography;
  final String? birthday;

  const MyUser({
    required this.id,
    required this.email,
    required this.name,
    required this.biography,
    required this.birthday,
  });

  static const empty =
      MyUser(id: '', email: '', name: '', biography: '', birthday: '');

  MyUser copyWith(
      {String? id,
      String? email,
      String? name,
      String? picture,
      String? birthday}) {
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      biography: picture ?? this.biography,
      birthday: birthday ?? this.birthday,
    );
  }

  bool get isEmpty => this == MyUser.empty;

  bool get isNotEmpty => this != MyUser.empty;

  MyUserEntity toEntity() {
    return MyUserEntity(
        id: id,
        email: email,
        name: name,
        biography: biography,
        birthday: birthday);
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
        id: entity.id,
        email: entity.email,
        name: entity.name,
        biography: entity.biography,
        birthday: entity.birthday);
  }

  @override
  List<Object?> get props => [id, email, name, biography, birthday];
}
