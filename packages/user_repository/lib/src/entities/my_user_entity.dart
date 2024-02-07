import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? biography;
  final String? birthday;

  const MyUserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.biography,
    required this.birthday,
  });

  Map<String, Object?> toDocument() {
    return {
      "id": id,
      "email": email,
      "name": name,
      "biography": biography,
      "birthday": birthday,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      id: doc['id'] as String,
      email: doc['email'] as String,
      name: doc['name'] as String,
      biography: doc['biography'] as String?,
      birthday: doc['birthday'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, email, name, biography, birthday];

  @override
  String toString() {
    return '''UserEntity: {
      id: $id
      email: $email
      name: $name
      biography: $biography
      birthday: $birthday
    }''';
  }
}
