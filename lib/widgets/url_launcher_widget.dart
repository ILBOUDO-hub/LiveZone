/*
 * *
 *  * Created by Vishal Patolia on 9/30/21, 3:42 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  * Sdreatech Solutions Pvt. Ltd.
 *  * Last modified 9/30/21, 3:42 PM
 *
 */


class URLLauncherUtils {
  URLLauncherUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    // if (await canLaunch(googleUrl)) {
    //   await launch(googleUrl);
    // } else {
    //   throw 'Could not open the map.';
    // }
  }

  static Future<void> openCaller(String number) async {
    String url = 'tel:$number';
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not open the dialer.';
    // }
  }
}
