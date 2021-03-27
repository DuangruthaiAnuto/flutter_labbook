import 'package:flutter/material.dart';
import 'package:flash/flash.dart';

Future showConfirmDialog(BuildContext context, String titleText,
    String contentText, Function okHandle, Function cancelHandle) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titleText),
          content: Text(contentText),
          actions: [
            new FlatButton(
              child: new Text("OK"),
              onPressed: okHandle,
            ),
            new FlatButton(
              child: new Text("CANCEL"),
              onPressed: cancelHandle,
            )
          ],
        );
      });
}

Future showFlashDialog(
    BuildContext context, String flashTitle, String flashText) {
  return showFlash(
      context: context,
      duration: Duration(seconds: 3),
      builder: (context, controller) {
        return Flash.bar(
          position: FlashPosition.bottom,
          backgroundGradient:
              LinearGradient(colors: [Colors.black, Colors.blueGrey]),
          enableDrag: true,
          horizontalDismissDirection: HorizontalDismissDirection.startToEnd,
          margin: EdgeInsets.all(8),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          controller: controller,
          child: FlashBar(
            message: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Icon(
                      Icons.check_circle,
                      size: 18,
                      color: Colors.greenAccent,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      flashTitle,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    flashText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ]),
          ),
        );
      });
}
