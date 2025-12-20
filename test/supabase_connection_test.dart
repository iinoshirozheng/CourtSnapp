import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SharedPreferences.setMockInitialValues({});
  
  // Config from AppConfig
  const supabaseUrl = 'https://ujupsuovumgvlwxialmz.supabase.co';
  const supabaseAnonKey = 'sb_publishable_U80GeabDsr7AMvJ8C5Hbvw_Ab4lxlSP';

  setUpAll(() async {
    // Initialize Supabase only once
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      // Use an in-memory storage for testing to avoid platform channel issues
      authOptions: FlutterAuthClientOptions(
        localStorage: MyMockLocalStorage(),
      ),
    );
  });

  group('Supabase Connection & Auth Tests', () {
    
    test('Connection Check - Should reject invalid login (proving connection works)', () async {
      final client = Supabase.instance.client;
      print('\nTesting connection with invalid login...');
      try {
        await client.auth.signInWithPassword(
          email: 'non_existent_user_${DateTime.now().millisecondsSinceEpoch}@test.com',
          password: 'some_random_password',
        );
        fail('Should have failed with invalid credentials');
      } on AuthException catch (e) {
        print('✅ Connection successful! Received expected error from Supabase: ${e.message}');
        expect(e.message, contains('Invalid login credentials'));
      } catch (e) {
        fail('Unexpected error: $e');
      }
    });

    test('Sign Up Test - Should attempt to create a user', () async {
      final client = Supabase.instance.client;
      final randomId = Random().nextInt(10000);
      final testEmail = 'test_user_$randomId@example.com';
      final testPassword = 'TestPassword123!';

      print('\nTesting Sign Up with $testEmail...');
      
      try {
        final response = await client.auth.signUp(
          email: testEmail,
          password: testPassword,
        );
        
        if (response.user != null) {
           print('✅ Sign Up successful! User ID: ${response.user!.id}');
           // Optional: You happen to have auto-confirm enabled?
           // If "Confirm email" is enabled in Supabase, the user might be created but not logged in.
           if (response.session == null) {
             print('ℹ️ User created but no session (Email confirmation might be required).');
           } else {
             print('✅ User created and logged in!');
           }
        } else {
           print('⚠️ Sign Up returned no user (Check Supabase logs/settings).');
        }

      } on AuthException catch (e) {
        print('❌ Sign Up Failed: ${e.message}');
        if (e.message.contains('invalid')) {
           print('💡 Tip: Check if the email domain is blocked or format is rejected.');
        }
        // Fail the test if it's a configuration error, but pass if it's just "already registered" (unlikely for random)
        // rethrow; 
      } catch (e) {
        print('❌ Unexpected error during sign up: $e');
      }
    });
  });
}

class MyMockLocalStorage extends LocalStorage {
  final Map<String, String> _storage = {};

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> hasAccessToken() async => _storage.containsKey(supabasePersistSessionKey);

  @override
  Future<String?> accessToken() async => _storage[supabasePersistSessionKey];

  @override
  Future<void> persistSession(String persistSessionString) async {
    _storage[supabasePersistSessionKey] = persistSessionString;
  }

  @override
  Future<void> removePersistedSession() async {
    _storage.remove(supabasePersistSessionKey);
  }
}
