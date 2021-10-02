import 'package:driver/Locale/locales.dart';
import 'package:driver/Themes/colors.dart';
import 'package:driver/beanmodel/todayrestorder.dart';
import 'package:flutter/material.dart';

class OrderInfoContainerRest extends StatefulWidget {
  final List<TodayRestaurantOrderDetails> orderDeatisSub;
  final dynamic remprice;
  final dynamic paymentMethod;
  final dynamic paymentstatus;
  final dynamic currency;
  final List<AddonList> addons;

  OrderInfoContainerRest(this.orderDeatisSub, this.remprice, this.paymentMethod,
      this.paymentstatus, this.currency, this.addons);

  @override
  _OrderInfoContainerRestState createState() => _OrderInfoContainerRestState();
}

class _OrderInfoContainerRestState extends State<OrderInfoContainerRest> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.only(left: 4.0),
      color: kCardBackgroundColor,
      height: MediaQuery.of(context).size.width - 48,
      child: SingleChildScrollView(
        primary: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10, bottom: 10.0),
                child: Text(locale.product)),
            ListView.builder(
              itemCount: widget.orderDeatisSub.length,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.white,
                  child: ListTile(
                    title: Text(
                      widget.orderDeatisSub[index].product_name,
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 15.0),
                    ),
                    subtitle: Text(
                      '${widget.orderDeatisSub[index].quantity}${widget.orderDeatisSub[index].unit} x ${widget.orderDeatisSub[index].qty}',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontSize: 13.3),
                    ),
                    trailing: Text(
                      '${widget.currency} ${widget.orderDeatisSub[index].price}',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontSize: 13.3),
                    ),
                  ),
                );
              },
            ),
            Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10, bottom: 10.0),
                child: Text(locale.addons)),
            Visibility(
              visible: (widget.addons != null && widget.addons.length > 0)
                  ? true
                  : false,
              child: ListView.builder(
                itemCount: widget.addons.length,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        '${widget.addons[index].product_name}',
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 15.0),
                      ),
                      subtitle: Text(
                        '${widget.addons[index].addon_name}',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(fontSize: 13.3),
                      ),
                      trailing: Text(
                        '${widget.currency} ${widget.addons[index].addon_price}',
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
            Container(
              height: 50.0,
              color: kMainColor,
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      (widget.paymentMethod == locale.cod)
                          ? locale.cashOnDelivery
                          : locale.paymentStatus,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: kWhiteColor),
                    ),
                    Text(
                      (widget.paymentMethod == locale.cod)
                          ? '${widget.currency} ${widget.remprice}'
                          : '${widget.paymentstatus}',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: kWhiteColor),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
