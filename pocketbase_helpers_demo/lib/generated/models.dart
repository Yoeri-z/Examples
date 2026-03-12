// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:pocketbase/pocketbase.dart';
import 'package:pocketbase_helpers/pocketbase_helpers.dart';

/// Model for the users collection.
class User implements PocketBaseRecord {
  @override
  final String id;
  final String email;
  final bool emailVisibility;
  final bool verified;
  final String? name;
  final String? avatar;
  final DateTime created;
  final DateTime updated;

  User({
    required this.id,
    required this.email,
    required this.emailVisibility,
    required this.verified,
    this.name,
    this.avatar,
    required this.created,
    required this.updated,
  });

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      email: map['email'] as String,
      emailVisibility: map['emailVisibility'] as bool,
      verified: map['verified'] as bool,
      name: map['name'] as String?,
      avatar: map['avatar'] as String?,
      created: DateTime.parse(map['created'] as String),
      updated: DateTime.parse(map['updated'] as String),
    );
  }

  @override
  Map<String, dynamic> toMap() => {
    'id': id,
    'email': email,
    'emailVisibility': emailVisibility,
    'verified': verified,
    'name': name,
    'avatar': avatar,
    'created': created.toIso8601String(),
    'updated': updated.toIso8601String(),
  };

  User copyWith({
    String? id,
    String? email,
    bool? emailVisibility,
    bool? verified,
    String? name,
    String? avatar,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      emailVisibility: emailVisibility ?? this.emailVisibility,
      verified: verified ?? this.verified,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      created: created,
      updated: updated,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          emailVisibility == other.emailVisibility &&
          verified == other.verified &&
          name == other.name &&
          avatar == other.avatar &&
          created == other.created &&
          updated == other.updated;

  @override
  int get hashCode => Object.hashAll([
    id,
    email,
    emailVisibility,
    verified,
    name,
    avatar,
    created,
    updated,
  ]);
}

/// Helper for the users collection.
abstract final class Users {
  ///Get the [CollectionHelper] for the users collection
  static CollectionHelper<User> api([PocketBase? pocketbaseInstance]) =>
      CollectionHelper(
        pocketBaseInstance: pocketbaseInstance,
        collection: 'users',
        mapper: User.fromMap,
      );

  ///Get the [AuthHelper] for the users collection
  static AuthHelper<User> auth([PocketBase? pocketbaseInstance]) => AuthHelper(
    pocketBaseInstance: pocketbaseInstance,
    collection: 'users',
    mapper: User.fromMap,
  );
}

/// Model for the notes collection.
class Note implements PocketBaseRecord {
  @override
  final String id;
  final String title;
  final String? content;
  final DateTime created;
  final DateTime updated;

  Note({
    required this.id,
    required this.title,
    this.content,
    required this.created,
    required this.updated,
  });

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String?,
      created: DateTime.parse(map['created'] as String),
      updated: DateTime.parse(map['updated'] as String),
    );
  }

  @override
  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'content': content,
    'created': created.toIso8601String(),
    'updated': updated.toIso8601String(),
  };

  Note copyWith({String? id, String? title, String? content}) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      created: created,
      updated: updated,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Note &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          content == other.content &&
          created == other.created &&
          updated == other.updated;

  @override
  int get hashCode => Object.hashAll([id, title, content, created, updated]);
}

/// Helper for the notes collection.
abstract final class Notes {
  ///Get the [CollectionHelper] for the notes collection
  static CollectionHelper<Note> api([PocketBase? pocketbaseInstance]) =>
      CollectionHelper(
        pocketBaseInstance: pocketbaseInstance,
        collection: 'notes',
        mapper: Note.fromMap,
      );
}
