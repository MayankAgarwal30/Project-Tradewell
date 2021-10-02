import 'package:driver/Locale/locales.dart';
import 'package:driver/Themes/colors.dart';
import 'package:driver/beanmodel/todayrestorder.dart';
import 'package:flutter/material.dart';

class OrderInfoDetailsPharma extends StatefulWidget {
  @override
  _OrderInfoPharmaState createState() => _OrderInfoPharmaState();
}

class _OrderInfoPharmaState extends State<OrderInfoDetailsPharma> {
  List<TodayRestaurantOrderDetails> orderDeatisSub;
  dynamic remprice;
  dynamic paymentMethod;
  dynamic paymentstatus;
  dynamic currency;
  List<AddonList> addons;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    final Map<String, Object> dataObject =
        ModalRoute.of(context).settings.arguments;
    setState(() {
      remprice = dataObject['remprice'];
      paymentstatus = dataObject['paymentstatus'];
      currency = dataObject['currency'];
      paymentMethod = dataObject['paymentMethod'];
      orderDeatisSub = dataObject['itemDetails'] as List;
      addons = dataObject['addons'] as List;
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
        locale.productDetail,
          style: TextStyle(color: kMainTextColor),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 4.0),
        color: kCardBackgroundColor,
        height: MediaQuery.of(context).size.height,
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10, bottom: 10.0),
                child: Text(locale.product)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    itemCount: orderDeatisSub.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(
                            orderDeatisSub[index].product_name,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0),
                          ),
                          subtitle: Text(
                            '${orderDeatisSub[index].quantity}${orderDeatisSub[index].unit} x ${orderDeatisSub[index].qty}',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(fontSize: 13.3),
                          ),
                          trailing: Text(
                            '${currency} ${orderDeatisSub[index].price}',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(fontSize: 13.3),
                          ),
                        ),
                      );
                    },
                  ),
                  Visibility(
                    visible:
                        (addons != null && addons.length > 0) ? true : false,
                    child: Padding(
                        padding:
                            EdgeInsets.only(left: 10.0, top: 10, bottom: 10.0),
                        child: Text(locale.addons)),
                  ),
                  Visibility(
                    visible:
                        (addons != null && addons.length > 0) ? true : false,
                    child: ListView.builder(
                      itemCount: addons.length,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          color: Colors.white,
                          child: ListTile(
                            title: Text(
                              '${addons[index].product_name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0),
                            ),
                            subtitle: Text(
                              '${addons[index].addon_name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontSize: 13.3),
                            ),
                            trailing: Text(
                              '${currency} ${addons[index].addon_price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontSize: 13.3),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50.0,
                color: kMainColor,
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        (paymentMethod == "COD")
                            ? locale.cashOnDelivery
                            : locale.paymentStatus,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: kWhiteColor),
                      ),
                      Text(
                        (paymentMethod == "COD")
                            ? '${currency} ${remprice}'
                            : '${paymentstatus}',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: kWhiteColor),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
