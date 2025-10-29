import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../providers/dio_provider.dart';

final emailOtpServiceProvider = Provider<EmailOtpService>((ref) => EmailOtpService(ref.read(dioProvider)));

class EmailOtpService {
  final Dio _dio;
  EmailOtpService(this._dio);

  Future<bool> sendOtp(String email) async {
    try {
      await _dio.post('/auth/email-otp/send', data: {'email': email});
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> verifyOtp(String email, String code) async {
    try {
      final res = await _dio.post('/auth/email-otp/verify', data: {'email': email, 'code': code});
      return (res.data?['verified'] == true) || (res.statusCode == 200);
    } catch (_) {
      return false;
    }
  }
}


