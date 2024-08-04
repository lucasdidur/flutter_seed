import 'package:flutter/foundation.dart';

import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:flutter/material.dart';

import 'package:injectable/injectable.dart';

import '../../../app/injection/get_it.dart';
import '../../../shared/services/navigation_service.dart';
import '../models/user.dart';
import 'authentication_service.dart';

@LazySingleton()
class UserService {
  ValueNotifier<User?> user = ValueNotifier(null);

  void setUser(User val) {
    user.value = val;
  }

  SupabaseClient get _supabase => Supabase.instance.client;

  Future<void> createUser() async {
    try {
      final user = _supabase.auth.currentUser;

      if (user == null) {
        return;
      }

      User newUser = User(
        id: user.id,
        email: user.email,
        createdAt: DateTime.now(),
      );

      await _supabase.from('users').upsert(newUser.toJson(), onConflict: 'id');
    } catch (e) {
      debugPrint('Error creating user: $e');
      rethrow;
    }
    return;
  }

  Future<User?> getUser() async {
    try {
      final Map<String, dynamic> user =
          await _supabase.from('users').select().eq('id', _supabase.auth.currentUser!.id).single();

      User loadedUser = User.fromJson(user);
      debugPrint('loadedUser: $loadedUser');
      setUser(loadedUser);
      return loadedUser;
    } catch (e) {
      debugPrint('Error getting user: $e');
      await sl<AuthenticationService>().signOut();
      sl<NavigationService>().replaceNamed('/sign-in');
      return null;
    }
  }

  Future<void> deleteUser(User user) async {
    _supabase.from('users').delete().eq('id', user.id!);
  }

  Future<void> updateUser(User user) {
    debugPrint('Updating user: ${user.toJson()}');
    return _supabase.from('users').update(user.toJson()).eq('id', user.id!);
  }

  Future<void> updateLastLogin() async {
    try {
      await _supabase.from('users').update({
        'last_login': DateTime.now().toIso8601String(),
      }).eq('id', _supabase.auth.currentUser!.id);
    } catch (e) {
      debugPrint('Error updating last login: $e');
    }
  }

  Future<void> updateUserProperty(String key, value) async {
    if (sl<AuthenticationService>().id == null) return;

    _supabase.from('users').update({
      key: value,
    }).eq('id', _supabase.auth.currentUser!.id);
  }
}
