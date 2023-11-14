
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    _notificationsPlugin.initialize(initializationSettings);
  }

  static void display(RemoteMessage message) async {

    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/1000;

      final NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "EasyPass",
          "EasyPass channel",
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true
        )
        );


      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data["route"],
      );
    }catch (e) {
      print(e);
    }
  }
}
/// Message route arguments.
class MessageArguments {
  /// The RemoteMessage
  final RemoteMessage message;

  /// Whether this message caused the application to open.
  final bool openedApplication;

  // ignore: public_member_api_docs
  MessageArguments(this.message, this.openedApplication);
}

/// Displays information about a [RemoteMessage].
class MessageView extends StatelessWidget {
  /// A single data row.
  Widget row(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title: '),
          Expanded(child: Text(value ?? 'N/A')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MessageArguments args =
        ModalRoute.of(context)!.settings.arguments! as MessageArguments;
    RemoteMessage message = args.message;
    RemoteNotification? notification = message.notification;

    return Scaffold(
      appBar: AppBar(
        title: Text(message.messageId ?? 'N/A'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            row('Triggered application open',
                args.openedApplication.toString()),
            row('Message ID', message.messageId),
            row('Sender ID', message.senderId),
            row('Category', message.category),
            row('Collapse Key', message.collapseKey),
            row('Content Available', message.contentAvailable.toString()),
            row('Data', message.data.toString()),
            row('From', message.from),
            row('Message ID', message.messageId),
            row('Sent Time', message.sentTime?.toString()),
            row('Thread ID', message.threadId),
            row('Time to Live (TTL)', message.ttl?.toString()),
            if (notification != null) ...[
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Remote Notification',
                      style: TextStyle(fontSize: 18),
                    ),
                    row(
                      'Title',
                      notification.title,
                    ),
                    row(
                      'Body',
                      notification.body,
                    ),
                    if (notification.android != null) ...[
                      const SizedBox(height: 16),
                      const Text(
                        'Android Properties',
                        style: TextStyle(fontSize: 18),
                      ),
                      row(
                        'Channel ID',
                        notification.android!.channelId,
                      ),
                      row(
                        'Click Action',
                        notification.android!.clickAction,
                      ),
                      row(
                        'Color',
                        notification.android!.color,
                      ),
                      row(
                        'Count',
                        notification.android!.count?.toString(),
                      ),
                      row(
                        'Image URL',
                        notification.android!.imageUrl,
                      ),
                      row(
                        'Link',
                        notification.android!.link,
                      ),
                      row(
                        'Priority',
                        notification.android!.priority.toString(),
                      ),
                      row(
                        'Small Icon',
                        notification.android!.smallIcon,
                      ),
                      row(
                        'Sound',
                        notification.android!.sound,
                      ),
                      row(
                        'Ticker',
                        notification.android!.ticker,
                      ),
                      row(
                        'Visibility',
                        notification.android!.visibility.toString(),
                      ),
                    ],
                    if (notification.apple != null) ...[
                      const Text(
                        'Apple Properties',
                        style: TextStyle(fontSize: 18),
                      ),
                      row(
                        'Subtitle',
                        notification.apple!.subtitle,
                      ),
                      row(
                        'Badge',
                        notification.apple!.badge,
                      ),
                      row(
                        'Sound',
                        notification.apple!.sound?.name,
                      ),
                    ]
                  ],
                ),
              )
            ]
          ],
        ),
      )),
    );
  }
}



/// Requests & displays the current user permissions for this device.
class Permissions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Permissions();
}

class _Permissions extends State<Permissions> {
  bool _requested = false;
  bool _fetching = false;
  late NotificationSettings _settings;

  Future<void> requestPermissions() async {
    setState(() {
      _fetching = true;
    });

    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );

    setState(() {
      _requested = true;
      _fetching = false;
      _settings = settings;
    });
  }

  Future<void> checkPermissions() async {
    setState(() {
      _fetching = true;
    });

    NotificationSettings settings =
        await FirebaseMessaging.instance.getNotificationSettings();

    setState(() {
      _requested = true;
      _fetching = false;
      _settings = settings;
    });
  }

  Widget row(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$title:', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_fetching) {
      return const CircularProgressIndicator();
    }

    if (!_requested) {
      return ElevatedButton(
          onPressed: requestPermissions,
          child: const Text('Request Permissions'));
    }

    return Column(children: [
      row('Authorization Status', statusMap[_settings.authorizationStatus]!),
      if (defaultTargetPlatform == TargetPlatform.iOS) ...[
        row('Alert', settingsMap[_settings.alert]!),
        row('Announcement', settingsMap[_settings.announcement]!),
        row('Badge', settingsMap[_settings.badge]!),
        row('Car Play', settingsMap[_settings.carPlay]!),
        row('Lock Screen', settingsMap[_settings.lockScreen]!),
        row('Notification Center', settingsMap[_settings.notificationCenter]!),
        row('Show Previews', previewMap[_settings.showPreviews]!),
        row('Sound', settingsMap[_settings.sound]!),
      ],
      ElevatedButton(
          onPressed: checkPermissions, child: const Text('Reload Permissions')),
    ]);
  }
}

/// Maps a [AuthorizationStatus] to a string value.
const statusMap = {
  AuthorizationStatus.authorized: 'Authorized',
  AuthorizationStatus.denied: 'Denied',
  AuthorizationStatus.notDetermined: 'Not Determined',
  AuthorizationStatus.provisional: 'Provisional',
};

/// Maps a [AppleNotificationSetting] to a string value.
const settingsMap = {
  AppleNotificationSetting.disabled: 'Disabled',
  AppleNotificationSetting.enabled: 'Enabled',
  AppleNotificationSetting.notSupported: 'Not Supported',
};

/// Maps a [AppleShowPreviewSetting] to a string value.
const previewMap = {
  AppleShowPreviewSetting.always: 'Always',
  AppleShowPreviewSetting.never: 'Never',
  AppleShowPreviewSetting.notSupported: 'Not Supported',
  AppleShowPreviewSetting.whenAuthenticated: 'Only When Authenticated',
};