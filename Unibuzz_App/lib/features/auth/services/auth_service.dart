import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Sign up with Email, Password, and all user details
  Future<void> signUp({
    required String email,
    required String password,
    required Map<String, dynamic> userData,
  }) async {
    try {
      // 1. Sign up in Supabase Auth
      final AuthResponse response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: userData, // Store metadata (optional, but good for triggers)
      );

      final String? userId = response.user?.id;

      if (userId != null) {
        // 2. Insert into public.users table
        // We ensure the 'id' matches the auth user id
        final Map<String, dynamic> publicProfile = {
          'id': userId,
          'email_verified': false,
          'created_at': DateTime.now().toIso8601String(),
          ...userData, // Spread the rest of the fields
        };

        try {
           // Use upsert to handle cases where a trigger might have already created the row
           await _supabase.from('users').upsert(publicProfile);
        } catch (dbError) {
          debugPrint('DB Insert/Upsert Warning: $dbError');
        }
      }
    } catch (e) {
      debugPrint('Signup Error: $e');
      rethrow;
    }
  }

  // Verify OTP
  Future<void> verifyOtp({
    required String email,
    required String token,
  }) async {
    try {
      await _supabase.auth.verifyOTP(
        type: OtpType.signup,
        token: token,
        email: email,
      );
    } catch (e) {
      debugPrint('Verify Error: $e');
      rethrow;
    }
  }

  // Login
  // Note: PRN is not standard for Auth. We are asking for PRN in UI.
  // We need to either map PRN to email or ask for Email.
  // For this implementation, I will treat the input as Email for the actual auth call.
  // The UI should clarify "PRN (if mapped) or Email".
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      debugPrint('Login Error: $e');
      rethrow;
    }
  }
  
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
