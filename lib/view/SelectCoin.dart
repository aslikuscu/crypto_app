import 'dart:convert';

import 'package:crypto_app/model/chartModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SelectCoin extends StatefulWidget {
  var selectItem;
  SelectCoin({super.key, this.selectItem});

  @override
  State<SelectCoin> createState() => _SelectCoinState();
}

class _SelectCoinState extends State<SelectCoin> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: myHeight,
          width: myWidth,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: myWidth * 0.05, vertical: myHeight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: myHeight * 0.08,
                          child: Image.network(widget.selectItem.image),
                        ),
                        SizedBox(
                          width: myWidth * 0.04,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.selectItem.id,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.selectItem.symbol,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$' + widget.selectItem.currentPrice.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        Text(
                          widget.selectItem.marketCapChangePercentage24H
                                  .toString() +
                              '%',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: widget.selectItem
                                          .marketCapChangePercentage24H >=
                                      0
                                  ? Colors.green
                                  : Colors.red),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: myWidth * 0.05, vertical: myHeight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'low',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: myHeight * 0.01,
                        ),
                        Text(
                          '\$' + widget.selectItem.low24H.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'high',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        Text(
                          '\$' + widget.selectItem.high24H.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'vol',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        Text(
                          '\$' + widget.selectItem.totalVolume.toString() + 'M',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: myHeight * 0.4,
                width: myWidth,
                color: Colors.amber,
              )
            ],
          ),
        ),
      ),
    );
  }

  List<ChartModel>? itemChart;
  Future<void> getChart() async {
    String url = 'https://api.coingecko.com/api/v3/coins/';
    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": " application/json"
    });
    if (response.statusCode == 200) {
      Iterable x = json.decode(response.body);
      List<ChartModel> modelList =
          x.map((e) => ChartModel.fromJson(e)).toList();
      setState(() {
        itemChart = modelList;
      });
    } else {
      print(response.statusCode);
    }
  }
}
