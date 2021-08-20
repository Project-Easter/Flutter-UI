import 'package:books_app/constants/error.dart';
import 'package:books_app/utils/backend/auth_requests.dart';
import 'package:books_app/utils/backend/mail_request.dart';
import 'package:books_app/utils/backend/user_data_requests.dart';
import 'package:books_app/utils/helpers.dart';
import 'package:http/http.dart';

class BackendService {
  Future<String> loginWithSocialMedia(String idToken) async {
    final Response response = await AuthRequests.loginWithSocialMedia(idToken);
    final dynamic body = await getBodyFromResponse(response);

    print('Piotr login wale ka Body is $body');
    if (response.statusCode == 200) {
      String t = body['token'] as String;
      print('Piotr login wale ka 200 respone  is $t');
      return body['token'] as String;
    }

    final int errorId = body['error']['id'] as int;
    print('The error ID of loginWithSocialMedia made bu Piotr is $errorId');

    switch (errorId) {
      case Error.INVALID_ACCOUNT_TYPE:
        {
          throw Exception(
              'Provided email is associated with a regular account. Log in with email and password instead.');
        }
      default:
        {
          throw Exception('An unknown error occured. Please try again later');
        }
    }
  }

  Future confirmEmail(String email, String code) async {
    final Response response = await UserRequests.confirmEmail(email, code);

    if (response.statusCode == 204) return;

    final dynamic body = getBodyFromResponse(response);
    final int errorId = body['error']['id'] as int;

    switch (errorId) {
      case Error.INVALID_CONFIRMATION_CODE:
        {
          throw Exception('Provided confirmation code is invalid.');
        }
      case Error.EXPIRED_CONFIRMATION_CODE:
        {
          throw Exception(
              'Provided confirmation code has been expired. Click here to get a new one.');
        }
      default:
        {
          throw Exception('An unknown error occured. Please try again later');
        }
    }
  }

  Future<void> resetPassword(String email, String password, String code) async {
    final Response response =
        await UserRequests.resetPassword(email, password, code);
    if (response.statusCode == 204) return;

    final dynamic body = await getBodyFromResponse(response);
    final int errorId = body['error']['id'] as int;

    switch (errorId) {
      case Error.INVALID_CONFIRMATION_CODE:
        {
          throw Exception('Provided confirmation code is invalid');
        }
      case Error.EXPIRED_CONFIRMATION_CODE:
        {
          throw Exception(
              'Provided confirmation code has been expired. Click here to get a new one.');
        }
      default:
        {
          throw Exception('An unknown error occured. Please try again later');
        }
    }
  }

  Future<void> register(String email, String password) async {
    final Response response = await AuthRequests.register(email, password);

    if (response.statusCode == 201) return;

    final dynamic body = await getBodyFromResponse(response);
    print(body.toString() + ' is the register response body');
    if (body['error']['id'] != null) {
      final dynamic errorId = body['error']['id'];

      switch (errorId as int) {
        case Error.DUPLICATE_EMAIL:
          {
            throw Exception('Email already exists.');
          }
        default:
          {
            throw Exception('An unknown error occured. Please try again later');
          }
      }
    }
  }

  Future forgotPassword(String email) async {
    final Response response = await MailRequest.forgotPassword(email);
    if (response.statusCode == 204) return;

    final dynamic body = await getBodyFromResponse(response);
    final int errorId = body['error']['id'] as int;

    switch (errorId) {
      case Error.EMAIL_NOT_FOUND:
        {
          throw Exception('Provided email does not exist');
        }
      case Error.INVALID_ACCOUNT_TYPE:
        {
          throw Exception(
              'Provided email is associated with the account created using Google or Facebook');
        }
      case Error.UNCONFIRMED_ACCOUNT:
        {
          throw Exception('Your account is not confirmed yet.');
        }
      default:
        {
          throw Exception('An unknown error occured. Please try again later');
        }
    }
  }

  Future<String> login(String email, String password) async {
    final Response response = await AuthRequests.login(email, password);
    final dynamic body = getBodyFromResponse(response);
    print(body + 'is the body');

    if (response.statusCode == 200) return body['token'] as String;

    final dynamic errorId = body['error']['id'];

    switch (errorId as int) {
      case Error.INVALID_ACCOUNT_TYPE:
        {
          throw Exception(
              'You have created an account using Google or Facebook. Log in with one of them instead.');
        }
      case Error.INVALID_CREDENTIALS:
        {
          throw Exception(
              'Invalid Credentials. Check your input and try again.');
        }
      case Error.UNCONFIRMED_ACCOUNT:
        {
          throw Exception(
              'Your account is not confirmed yet. Click here to confirm it');
        }
      default:
        {
          throw Exception('An unknown error occured. Please try again later');
        }
    }
  }
}
