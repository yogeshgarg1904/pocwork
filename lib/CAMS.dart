import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:crypto/crypto.dart';
//import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart' as encrypt11;
import 'package:dio/dio.dart';

import 'checkbox/kyc_page.dart';

class MyEncrption {
  String key = 'TkVJTEhobWFj';
  String iv = 'globalaesvectors';
  //String key = 'aesEncryptionKey';
  //String iv = 'aesEncryptionIV!';
  String encrypt(String plainText) {
    final key1 = encrypt11.Key.fromUtf8(key);
    //final key1 = encrypt11.Key.fromLength(32);
    final iv1 = encrypt11.IV.fromUtf8(iv);

    print('IV: ' + iv1.bytes.toString());
    print('Key: ' + key1.bytes.toString());
    var keyhash = sha256.convert(key1.bytes);
    print(keyhash.bytes);
    String hashString = '';
    for (var x in keyhash.bytes) {
      final hexString = x.toRadixString(16); // 7e4
      hashString += hexString.padLeft(2, '0');
    }
    print(hashString.substring(0, 32));
    print(hashString.substring(0, 32).length.toString());
    print(utf8.encode(hashString.substring(0, 32)));

    var finalKey = encrypt11.Key.fromUtf8(hashString.substring(0, 32));

    final encrypter = encrypt11.Encrypter(
        encrypt11.AES(finalKey, mode: encrypt11.AESMode.cbc, padding: 'PKCS7'));
    print('Dart Output…!!!');

    final encrypted = encrypter.encrypt(plainText, iv: iv1);
    print('Encrypted: ' + encrypted.bytes.toString());
    print('Base64: ' + encrypted.base64);
    //return encrypted.base64;
    return encrypted.base64;
  }

  String decrypt(encrypt11.Encrypted encrypted) {
    final key1 = encrypt11.Key.fromUtf8(key);
    final iv1 = encrypt11.IV.fromUtf8(iv);
    final encrypter = encrypt11.Encrypter(encrypt11.AES(key1));
    final decrypted = encrypter.decrypt(encrypted, iv: iv1);
    print('Decrypted: ' + decrypted);
    return decrypted;
  }

  String signatureKey(String dataIn, signature) {
    var encodedKey =
        utf8.encode('TEFNRi1UTUlSQUVobWFj'); // signature=encryption key
    var hmacSha256 = new Hmac(sha256, encodedKey); // HMAC-SHA256 with key
    var bytesDataIn = utf8.encode(
        'LAMF-TMIRAE::DVgaEWDoZzEM5tx1F5p/v6djJ8AjaeC3BJB6NMehkwg=::20210901101010'); // encode the data to Unicode.
    var digest = hmacSha256.convert(bytesDataIn); // encrypt target data
    String singedValue = digest.toString();
    print('singedValue' + singedValue);
    return singedValue;
  }
}

class MyAppCAMS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(body: WebViewLoad()
            //body: MyMyApp()
            ));
  }
}

class WebViewLoad extends StatefulWidget {
  WebViewLoadUI createState() => WebViewLoadUI();
}

class WebViewLoadUI extends State<WebViewLoad> {
  MyEncrption enc = MyEncrption();

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  WebViewController _controllerNew;

  var name1Controller = TextEditingController();
  //InAppWebViewController webView;

  String strData = '{"loginemail" :"a_shameembanu@camsonline.com",' +
      '"netbankingemail": "a_shameembanu@camsonline.com",' +
      '"clientid": "LAMF-TMIRAE",' +
      '"clientname": "MIRAE ASSET FINANCIAL SERVICES (INDIA) PVT. LTD",' +
      '"pan": "BFAPS2661R",' +
      '"bankschemetype": "debt",' +
      '"requestip": "10.0.0.0",' +
      '"bankrefno": "10001",' +
      '"bankname": "icici bank name",' +
      '"branchname" : "ITC", ' +
      '"address1" : "NO 10",' +
      '"address2" : "add2",' +
      '"address3" : "add3",' +
      '"city" : "chennai",' +
      '"state" : "TN", ' +
      '"country" : "india", ' +
      '"pincode" : "627414", ' +
      '"phoneoff" : "12345", ' +
      '"phoneres" : "6789", ' +
      '"faxno" : "0246", ' +
      '"faxres" : "1357", ' +
      '"addinfo1" : "", ' +
      '"addinfo2" : "", ' +
      '"addinfo3" : "", ' +
      '"addinfo4" : "", ' +
      '"addinfo5" : "", ' +
      '"mobile" : "9441260123", ' +
      '"requesterid" : "101", ' +
      '"ipaddress" : "192.168.21.1", ' +
      '"requestresponse" : "", ' +
      '"sessionid" : "13215464", ' +
      '"executiondate" : "20210901101010", ' +
      '"signature" : "580a65bc0dc1b3897514c824ad66160998578db528ebf8d114b37428c418895f", ' +
      '"requestername" : "xxxxxx", ' +
      '"deviceid" : "cbkisHASOIH", ' +
      '"osid" : "ads32", ' +
      '"url" : "",' +
      '"redirecturl": "http://13.233.118.55:9191/Webform1.aspx",'
          '"markid" : "mark12",' +
      '"verifyid" : "verify12",' +
      '"approveid" : "appro12"}';

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
        appBar: AppBar(title: Text('WebView in Flutter')),
        body: SafeArea(
            child: Column(
          children: <Widget>[
            FlatButton(
              child:
                  Text("Take Picture", style: TextStyle(color: Colors.white)),
              color: Colors.green,
              onPressed: () {
                setState(() {
                  enc.signatureKey('','');
                  name1Controller.text = enc.encrypt(strData) + '--last--';
                });
              },
            ),
            Expanded(
              child: TextField(
                controller: name1Controller,
                maxLines: 100000,
              ),
            ),
          ],
        )));*/
    /*return WebView(
       initialUrl: 'https://flutter.dev',
       javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
     );*/

    /*return Scaffold(
        appBar: AppBar(
          title: const Text('InAppWebView Example'),
        ),
        body: Container(
            child: Column(children: <Widget>[
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                      url: Uri.parse("https://google.com/")
                    ),
                //initialUrl: "https://flutter.dev/",
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                        //debuggingEnabled: true,
                        )),
                onWebViewCreated: (InAppWebViewController controller) {
                  //controller.loadUrl(urlRequest: '');
                  //controller.postUrl(
                      //url: Uri.parse(
                        //  "https://flutter.dev"),
                      //postData: utf8.encode(enc.encrypt(strData)));
                  webView = controller;
                },
              ),
            ),
          ),
        ])),
    );*/
    /*return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView example'),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        //actions: <Widget>[
         // NavigationControls(_controller.future),
         // SampleMenu(_controller.future),
        //],
      ),
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: 'https://google.com',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print("WebView is loading (progress : $progress%)");
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains('youtube.com')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        );
      }),
      floatingActionButton: favoriteButton(),
    );*/

    /*return Scaffold(
      appBar: AppBar(title: Text('Help')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              child: WebView(
                initialUrl: 'abc',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controllerNew = webViewController;
                  _loadHtmlFromString();
                },
              ),
            ),
          ],
        ),
      ),
    );*/
    bool _loadedPage = false;

    // final String postUrl="'https://jsonplaceholder.typicode.com/posts'";
    //http://13.233.118.55:9191/Webform2.aspx
    final String postUrl =
        "'https://mycamsuat.camsonline.com/lamfapi/pgLienmarking.aspx'";
    final String postParam = "{lieninput: 'test'}";
    final String requestMethod = "'post'";
    var dataEnc = enc.encrypt(strData);
    final String jsFunc = "function post(path, params, method='post') {" +
        "const form = document.createElement('form');" +
        "form.method = method;" +
        "form.action = path;" +
        "for (const key in params) {" +
        "if (params.hasOwnProperty(key)) {" +
        "const hiddenField = document.createElement('input');" +
        "hiddenField.type = 'hidden';" +
        "hiddenField.name = key;" +
        //"hiddenField.value = params[key];"+
        //"hiddenField.value = '99cM0EMPxr0kXf+WLK2vLj9jy5rxgR2Qi25gOWX99CUlths5CMmnASyJM0B1ki84XUXyOQhW77rvWfMMYwUH1GmtUQODW67myw4YL5+1IrVvoL1fVQ31Leb6shmyO+m1j5l/tgKwIEvtZr9EacoBwpusbReFuPaYt5uG51Y9xHm5VIGrHIcXHJ9hXXrQG0/h4AMZRW4nrISfZdMOzfSEpTVMdx/53cj0qsxeuY5RS/37fL+n/Zdzkh8iVj+8ZJAN9lqAtoO9VzUNkzA8F+YK/OzQTEgWPI+RBZJizL2mL7L0KxTSE2h/1cRWo8fMa6TnVDxbtgz2HbGU86fmM9lWMdNYa0gNilOWmv/vWVy8kPK0m9WC5PIo2B8s/HdXWgVB+9QoKKEtXIhLLjUdIU7EPU85OfeVWEzAnhy/Gus9rEhUYvJrolRt9ksoEwk52C5E4GWA2JUW0RY2oivsbI0ZykGGzV4Iqs7fumjFJt5hUTwGbgPd7IqVD0MwC5L/eP7jc28fzZK8U1nijL1D8lxOV9sMVWTRAhF2pK+0zoXd60QPl6Hr4H4A/Y82JgAMrVP/Ia/P3yQJkBIsB7llk8SYtY6adFxuWu+RJSF4cm28xf0XW9AwUe90yZ/ygnb3m2DNZvtHkZaXoRLWTCt0WzU3q05koyxp79fd1P2hQJvyGHwPGCWSvZwfFcBfWv0VQjWmHPDKDOSYBR869Se7SkoKCdOeEonpGJmN4Rf4Lg5cmp/zzlUhbo21X3pmKlb1rUUw+pZ8URUNWMrQDicpEixTtcH6UB/LEWUUAs0uSdKGdQmeHRmHjqASlWvsoFFsG6s0bWltGjLm+B20K0x8y/VOgygV+SXIX6VXXbG6/h2e9JqTsMX1mvG/azkpjGA0FngZQufHbQjyB/ApdE/11FPHwW7QByFWQG43oroSjmR9FUkUmr5/pb2Hq3PDbomnFgfQ4RdQwIsXmNG/2vPoP4lS60JPxTHHGEwq6DDIxX/0Yv6ZQwkW6fsu6PnMwHi5fAW7eObZBvIlwXcTrxpa31x4Bdo74z98d0zgB1pwwCP9pAQOU812+ix5kyjetzGVZIjCJo12X6gHTuxWhUkHrnWMZID2fY8ia6vzMqTLwcpiYgVBCnYYoc688g6Oajhykl3SmU2YUXnTeE+AsNxqUAs4wk+72Qrz+m31KcjIEy6UDHlysR9a2bc//sohzwo3LfSG87MmlFt2r829HhFl4MdXmR0Kl1Bo8l2D9pG1Q0BEbG7lyXRTWTonu2yyO71/vMo7JZgkZNLqnhzRs3YaGJ6bOsy6JSTLdBFG5MahcgnwsPzNs0NzO+w8+h1XBR8c9j7qiv4k9Q8jj2Dloa/q+RqcRLtIIKfdYaEhop16HWwG37Y2oTtjL+JKRmxYo39qnplL9TdoFxeGxWb/3C86pUfF5g==';"+
        "hiddenField.value = '$dataEnc';" +
        "form.appendChild(hiddenField);}}document.body.appendChild(form);form.submit();}" +
        "post($postUrl, $postParam, method=$requestMethod)";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('hello'),
      ),
      body: Builder(builder: (BuildContext context) {
        return new Stack(
          children: <Widget>[
            new WebView(
              //initialUrl: 'abc',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                _controllerNew = controller;
                _controllerNew.evaluateJavascript(jsFunc);
              },
              navigationDelegate: (NavigationRequest request) {

                print('inside blocking navigation to $request}');

                if (request.url.contains('13.233.118.55:9191/Webform1')) {
                  print('blocking navigation to $request}');
                  
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VerticalExample()),
                    );
                  
                  return NavigationDecision.prevent;
                }
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
                //return NavigationDecision.prevent;
              },
              //onPageFinished: (url){
              // print('Page finished loading: $url');

              // _controllerNew.evaluateJavascript(jsFunc);

              /*setState(() {
                      _loadedPage = true;
                    });*/
              //},
            ),
            /*_loadedPage == false
                    ? new Center(
                        child: new CircularProgressIndicator(
                            backgroundColor: Colors.green),
                      )
                    : new Container(),*/
          ],
        );
      }),
    );
  }

  /*_loadHtmlFromString() async {
    var dio = Dio();
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['lieninput'] = enc.encrypt(strData);
    try {
      FormData formData = new FormData.fromMap(map);
      var response = await dio.post('http://13.233.118.55:8083/madmin/utility/cams', data: formData);
      //return response.data;
      print('object');
      _controllerNew.loadUrl(Uri.dataFromString(response.data,
              mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
          .toString());
    } catch (e) {
      print(e);
    }
  }*/
  /*JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              onPressed: () async {
                final String url = (await controller.data.currentUrl());
                // ignore: deprecated_member_use
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Favorited $url')),
                );
              },
              child: const Icon(Icons.favorite),
            );
          }
          return Container();
        });
  }*/

}
