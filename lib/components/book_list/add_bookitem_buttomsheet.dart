import 'package:flutter/material.dart';
import 'add_cart_button.dart';

class AddBookItemButtomSheet extends StatefulWidget {
  final int bookId;
  final String title;
  final int price;
  final String thumbnailUrl;
  final int qty;
  final bool isUpdate;

  AddBookItemButtomSheet(this.bookId, this.title, this.price, this.thumbnailUrl,
      this.qty, this.isUpdate);

  @override
  _AddBookItemButtomSheetState createState() => _AddBookItemButtomSheetState();
}

class _AddBookItemButtomSheetState extends State<AddBookItemButtomSheet> {
  BuildContext scaffoldContext;
  int _qty;

  void initState() {
    super.initState();
    _qty = widget.qty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: 10,
              ),
            ),
            Container(
              //height: 30,
              width: double.infinity,
              child: Text(
                '${widget.title}',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: Text(
                'Price: \$${(widget.price)}',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_qty > 1) {
                          _qty = _qty - 1;
                        }
                      });
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.green,
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: FittedBox(
                          child: Text(
                            '-',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 17,
                  ),
                  Text(
                    '$_qty',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 17,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _qty = _qty + 1;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      radius: 25,
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: FittedBox(
                          child: Text(
                            '+',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: Text(
                'Total: \$${(widget.price * _qty)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              child: AddCartButton(widget.bookId, widget.title, widget.price,
                  widget.thumbnailUrl, _qty, widget.isUpdate),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              child: FlatButton(
                  height: 45,
                  color: Colors.deepOrangeAccent,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
            ),
            Expanded(
              child: SizedBox(
                height: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
