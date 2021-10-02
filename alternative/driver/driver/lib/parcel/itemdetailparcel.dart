import 'package:driver/Locale/locales.dart';
import 'package:driver/Themes/colors.dart';
import 'package:driver/parcel/parcelbean/orderdetailpageparcel.dart';
import 'package:flutter/material.dart';

class ItemDetailsParcel extends StatelessWidget {
  dynamic cart_id;
  TodayOrderParcel orderDeatisSub;
  dynamic currency;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    final Map<String, Object> dataObject =
        ModalRoute.of(context).settings.arguments;
    cart_id = '${dataObject['cart_id']}';
    orderDeatisSub = dataObject['itemDetails'];
    currency = dataObject['currency'];

    return Scaffold(
      backgroundColor: kCardBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: AppBar(
            backgroundColor: kWhiteColor,
            automaticallyImplyLeading: true,
            title: Text(locale.orderItemDetail+""+cart_id ,
                //'Order Item Detail\'s - #${cart_id}',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.w500)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                color: kWhiteColor,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text(
                                '${orderDeatisSub.parcel_id}',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: kMainTextColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text(
                                '${orderDeatisSub.parcel_description}',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: kMainTextColor,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Text(
                              'Parcel Weight :- ${orderDeatisSub.weight} KG \nDimession :- ${orderDeatisSub.length} x ${orderDeatisSub.width} x ${orderDeatisSub.height}',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: kMainTextColor,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
