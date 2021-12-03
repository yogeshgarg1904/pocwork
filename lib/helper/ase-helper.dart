import 'dart:convert';

import 'package:encrypt/encrypt.dart';

class MyEncrption {
  String key = 'aesEncryptionKey';
  String iv = 'aesEncryptionIV!';
  Encrypted encrypt(String plainText) {
    final key1 = Key.fromUtf8(key);
    final iv1 = IV.fromUtf8(iv);
    final encrypter = Encrypter(AES(key1,mode: AESMode.cbc,padding: 'PKCS7'));
    print('Dart Output…!!!');
    print('IV: ' + iv1.bytes.toString());
    print('Key: ' + key1.bytes.toString());
    final encrypted = encrypter.encrypt(plainText, iv: iv1);
    print('Encrypted: ' + encrypted.bytes.toString());
    print('Base64: ' + encrypted.base64);
    return encrypted;
  }
  String decrypt(Encrypted encrypted){
final key1 = Key.fromUtf8(key);
final iv1 = IV.fromUtf8(iv);
final encrypter = Encrypter(AES(key1));
final decrypted = encrypter.decrypt(encrypted, iv: iv1);
print('Decrypted: '+ decrypted);
return decrypted;
}
}

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);


Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    Welcome({
        this.success,
        this.message,
        this.errorCode,
        this.errorTitle,
        this.responseCode,
        this.responseMsg,
        this.finalMap,
    });

    bool success;
    dynamic message;
    dynamic errorCode;
    dynamic errorTitle;
    int responseCode;
    String responseMsg;
    FinalMap finalMap;

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        success: json["success"],
        message: json["message"],
        errorCode: json["errorCode"],
        errorTitle: json["errorTitle"],
        responseCode: json["responseCode"],
        responseMsg: json["responseMsg"],
        finalMap: FinalMap.fromJson(json["finalMap"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "errorCode": errorCode,
        "errorTitle": errorTitle,
        "responseCode": responseCode,
        "responseMsg": responseMsg,
        "finalMap": finalMap.toJson(),
    };
}

class FinalMap {
    FinalMap({
        this.guestMenu,
    });

    List<Menu> guestMenu;

    factory FinalMap.fromJson(Map<String, dynamic> json) => FinalMap(
        guestMenu: List<Menu>.from(json["GuestMenu"].map((x) => Menu.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "GuestMenu": List<dynamic>.from(guestMenu.map((x) => x.toJson())),
    };
}

class Menu {
    Menu({
        this.id,
        this.name,
        this.subMenu,
    });

    int id;
    String name;
    List<Menu> subMenu;

    factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"],
        name: json["name"],
        subMenu: json["subMenu"] == null ? null : List<Menu>.from(json["subMenu"].map((x) => Menu.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "subMenu": subMenu == null ? null : List<dynamic>.from(subMenu.map((x) => x.toJson())),
    };
}
