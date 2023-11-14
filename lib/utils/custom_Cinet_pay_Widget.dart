library cinetpay;

import 'dart:io';
import 'package:eventpro/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CinetPayCheckout extends StatefulWidget {
  final String? title;
  final Map<String, dynamic>? configData;
  final Map<String, dynamic>? paymentData;
  final Function(Map<String, dynamic>)? waitResponse;
  final Function(Map<String, dynamic>)? onError;

  const CinetPayCheckout(
      {@required this.title,
      @required this.configData,
      @required this.paymentData,
      @required this.waitResponse,
      @required this.onError});

  @override
  CinetPayCheckoutState createState() => CinetPayCheckoutState();
}

class CinetPayCheckoutState extends State<CinetPayCheckout> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        sharedCookiesEnabled: true,
        // applePayAPIEnabled: true,
      ));

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();

    if (Platform.isAndroid) {
      AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title ?? "Payment Checkout",style: mediumLargeTextStyle,),
        centerTitle: true,
        leading: BackButton(color: primaryColor),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          child: InAppWebView(
            key: webViewKey,
            initialData: InAppWebViewInitialData(data: """
                  <!DOCTYPE html>
                    <html>
                    
                    <head>
                        <meta name="viewport" content="width=device-width, initial-scale=1">
                        <script src="https://cdn.cinetpay.com/seamless/main.js"></script>
                        <script>
                            function checkout() {
                                window.addEventListener("flutterInAppWebViewPlatformReady", function(event) {
                                    window.flutter_inappwebview.callHandler('elementToSend')
                                        .then(function(result) {
                        
                                        var configData = result.configData;
                                        var paymentData = result.paymentData;
                                        
                                        CinetPay.setConfig(configData);

                                        CinetPay.getCheckout(paymentData);
                                        
                                        CinetPay.waitResponse(function(data) {
                                            wait('finished', data);
                                        });
                                        
                                        CinetPay.onError(function(data) {
                                            error('error', data);
                                        });
    
                                    });
                                });
                            }
                            
                            function wait(title, data) {
                                window.flutter_inappwebview.callHandler(title, data).then(function(result) {});
                            }
                            
                            function error(title, data) {
                                window.flutter_inappwebview.callHandler(title, data).then(function(result) {});
                            }
                        </script>
                    </head>
                    
                    <body>
                        </head>
                    
                        <body onload="checkout()">
                        </body>
                    
                    </html>
                  """),
            initialOptions: options,
            androidOnPermissionRequest: (controller, origin, resources) async {
              return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT);
            },
            onWebViewCreated: (InAppWebViewController controller) {
              controller.addJavaScriptHandler(
                  handlerName: 'elementToSend',
                  callback: (args) {
                    Map<String, dynamic> configData = widget.configData!;
                    configData['type'] = "MOBILE";

                    final Map<String, dynamic> data = {
                      'configData': configData,
                      'paymentData': widget.paymentData
                    };

                    print("Send payment data to get CinetPay Checkout");

                    return data;
                  });

              controller.addJavaScriptHandler(
                  handlerName: 'finished',
                  callback: (data) async {
                    print("CinetPay Checkout send payment response");
                    return widget.waitResponse!(data[0]);
                  });

              controller.addJavaScriptHandler(
                  handlerName: 'error',
                  callback: (data) async {
                    print("An error occurred");
                    return widget.onError!(data[0]);
                  });
            },
            onLoadError: (InAppWebViewController controller, Uri? url, int code,
                String message) {
              print("An error occurred : " +
                  code.toString() +
                  " - " +
                  message.toString());
            },
            onConsoleMessage:
                (InAppWebViewController controller, ConsoleMessage message) {
              print("console : ${message.message.toString()}");
            },
          ),
        ),
      ),
    );
  }
}
