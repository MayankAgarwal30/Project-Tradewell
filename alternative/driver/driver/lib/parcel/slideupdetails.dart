import 'package:driver/Locale/locales.dart';
import 'package:driver/Themes/colors.dart';
import 'package:driver/parcel/parcelbean/orderdetailpageparcel.dart';
import 'package:flutter/material.dart';

class OrderInfoContainerParcel extends StatefulWidget {
  final TodayOrderParcel orderDeatisSub;
  final dynamic remprice;
  final dynamic paymentMethod;
  final dynamic paymentstatus;
  final dynamic currency;

  OrderInfoContainerParcel(this.orderDeatisSub, this.remprice,
      this.paymentMethod, this.paymentstatus, this.currency);

  @override
  _OrderInfoContainerParcelState createState() =>
      _OrderInfoContainerParcelState();
}

class _OrderInfoContainerParcelState extends State<OrderInfoContainerParcel> {
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
            Container(
              color: Colors.white,
              child: ListTile(
                title: Text(
                  widget.orderDeatisSub.parcel_id,
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 15.0),
                ),
                subtitle: Text(
                  'Parcel Weight :- ${widget.orderDeatisSub.weight} KG \nDimession :- ${widget.orderDeatisSub.length} x ${widget.orderDeatisSub.width} x ${widget.orderDeatisSub.height}',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontSize: 13.3),
                ),
                trailing: Text(
                  '${widget.currency} ${(double.parse('${double.parse('${widget.orderDeatisSub.distance}').toStringAsFixed(2)}') > 1) ? (double.parse('${widget.orderDeatisSub.charges}') * double.parse('${double.parse('${widget.orderDeatisSub.distance}').toStringAsFixed(2)}')) : double.parse('${widget.orderDeatisSub.charges}')}',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontSize: 13.3),
                ),
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
                      (widget.paymentMethod == "COD")
                          ? locale.cashOnDelivery
                          :locale.paymentStatus,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: kWhiteColor),
                    ),
                    Text(
                      (widget.paymentMethod == "COD")
                          ? '${widget.currency} ${(double.parse('${double.parse('${widget.orderDeatisSub.distance}').toStringAsFixed(2)}') > 1) ? (double.parse('${widget.orderDeatisSub.charges}') * double.parse('${double.parse('${widget.orderDeatisSub.distance}').toStringAsFixed(2)}')) : double.parse('${widget.orderDeatisSub.charges}')}'
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
