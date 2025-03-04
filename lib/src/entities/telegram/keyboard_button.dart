import 'dart:convert';

import '../../../telegram_entities.dart';
import '../internal/helpers/util.dart';

/// This object represents one button of the reply keyboard.
/// For simple text buttons String can be used instead of this object to specify
/// text of the button.
/// Optional fields web_app, request_contact, request_location, and request_poll
/// are mutually exclusive.
class KeyboardButton {
  /// Text of the button. If none of the optional fields are used,
  /// it will be sent as a message when the button is pressed
  String text;

  /// Optional.
  /// If True, the user's phone number will be sent as a contact when the button
  /// is pressed. Available in private chats only.
  bool? requestContact;

  /// Optional.
  /// If True, the user's current location will be sent when the button is
  /// pressed. Available in private chats only.
  bool? requestLocation;

  /// Optional.
  /// If specified, the user will be asked to create a poll and send it to the
  /// bot when the button is pressed. Available in private chats only.
  KeyboardButtonPollType? requestPoll;

  /// Optional.
  /// If specified, the described Web App will be launched when the button is
  /// pressed.
  /// The Web App will be able to send a “web_app_data” service message.
  /// Available in private chats only.
  WebAppInfo? webApp;

  KeyboardButton._({
    required this.text,
    this.requestContact,
    this.requestLocation,
    this.requestPoll,
    this.webApp,
  });

  /// RequestContact constructor
  KeyboardButton.requestContact(this.text, {this.requestContact});

  /// RequestLocation constructor
  KeyboardButton.requestLocation(this.text, {this.requestLocation});

  /// RequestPoll constructor
  KeyboardButton.requestPoll(this.text, this.requestPoll);

  /// WebApp constructor
  KeyboardButton.requestWebApp(this.text, this.webApp);

  /// Creates a object from a json
  static KeyboardButton fromJson(Map<String, dynamic> json) {
    return KeyboardButton._(
      text: json['text']!,
      requestContact: json['request_contact'],
      requestLocation: json['request_location'],
      requestPoll: callIfNotNull(
        KeyboardButtonPollType.fromJson,
        json['request_poll'],
      ),
      webApp: callIfNotNull(
        WebAppInfo.fromJson,
        json['web_app'],
      ),
    );
  }

  /// Creates a list of object from a json array
  static List<KeyboardButton> listFromJsonArray(List<dynamic> json) {
    return List.generate(
      json.length,
      (i) => KeyboardButton.fromJson(json[i]),
    );
  }

  /// Creates a list of list of object from a json array
  static List<List<KeyboardButton>> listOfListsFromJsonArray(
      List<List<dynamic>> json) {
    return List.generate(
      json.length,
      (e) => List.generate(
        json[e].length,
        (i) => KeyboardButton.fromJson(json[e][i]),
      ),
    );
  }

  /// Creates a json from the object
  Map toJson() {
    return {
      'text': text,
      'request_contact': requestContact,
      'request_location': requestLocation,
      'request_poll': requestPoll,
      'web_app': webApp,
    }..removeWhere((_, v) => v == null);
  }

  @override
  String toString() => json.encode(this);
}
