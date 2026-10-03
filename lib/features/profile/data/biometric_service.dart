import 'package:local_auth/local_auth.dart';

enum BiometricResult { authenticated, rejected, unavailable, error }

class BiometricService {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<BiometricResult> authenticate() async {
    try {
      if (!await _localAuthentication.canCheckBiometrics) {
        return BiometricResult.unavailable;
      }

      final didAuthenticate = await _localAuthentication.authenticate(
        localizedReason: 'Authenticate with your fingerprint to open the profile',
        biometricOnly: true,
      );
      return didAuthenticate
          ? BiometricResult.authenticated
          : BiometricResult.rejected;
    } on LocalAuthException catch (exception) {
      switch (exception.code) {
        case LocalAuthExceptionCode.noBiometricHardware:
          return BiometricResult.unavailable;
        case LocalAuthExceptionCode.userCanceled:
        case LocalAuthExceptionCode.systemCanceled:
          return BiometricResult.rejected;
        default:
          return BiometricResult.error;
      }
    }
  }
}
