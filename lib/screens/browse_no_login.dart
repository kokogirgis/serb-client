import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:serb/components/SERBInputDecorationUnderlineDark.dart';
import 'package:serb/components/SERBList.dart';
import 'package:serb/components/SERBTab.dart';
import 'package:serb/components/composets/login_from.dart';
import 'package:serb/misc/constants.dart';
import 'package:serb/samples/offerSamples.dart';
import 'package:serb/screens/login_screen.dart';
import '../misc/LogoDark.dart';

class BrowseNoLogin extends StatefulWidget {
  @override
  _BrowseNoLoginState createState() => _BrowseNoLoginState();
}

class _BrowseNoLoginState extends State<BrowseNoLogin> {
  Widget firstTab, explore;

  String firstTabTitle = "Newest";
  List<String> filterOptions = <String>[
    "New to old",
    "old to new",
    "low to high price",
    "high to low price",
    "high to low review"
  ];
  String filterBy;
  final pageViewController = PageController(
    initialPage: 0,
  );
  int _index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filterBy = filterOptions[0];
  }

  @override
  Widget build(BuildContext context) {
    firstTab = getAListOfCards(context, listOfOffers);
    explore = getAListOfCards(context, exploreList);
    var pageView = PageView(
      controller: pageViewController,
      children: [firstTab, explore],
      onPageChanged: (index) {
        _index = index;
        setState(() {});
      },
    );
    return Material(
      child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(40.0)),
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [LIGHT_BLUE, GREEN])),
                child: SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                  child: Align(
                                alignment: Alignment.topLeft,
                                child: LogoDark(),
                              )),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  },
                                  child:
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.account_circle, color: WHITE),
                                      ))
                            ],
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextField(
                            style: TextStyle(color: WHITE),
                            decoration: SERBInputDecorationUnderline(),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      _index = 0;
                                      pageViewController.jumpToPage(0);
                                      setState(() {});
                                    },
                                    child: SERBTab(
                                        title: firstTabTitle,
                                        selected: _index == 0,
                                      textColor: GREEN,
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    _index = 1;
                                    pageViewController.jumpToPage(1);
                                    setState(() {});
                                  },
                                  child: SERBTab(
                                    title: "explore",
                                    selected: _index == 1,
                                    textColor: GREEN,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                ),
              ),
              Expanded(
                child: pageView,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(8.0, 8.0, 32.0, 8.0),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(40.0)),
                      color: DARK_BLUE),
                  child: Row(
                    children: <Widget>[
                      Text("Filter: ",
                          style: TextStyle(
                              color: WHITE, fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 4.0,
                      ),
                      Expanded(
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: DARK_BLUE
                          ),
                          child: DropdownButton(
                            value: filterBy,
                            icon: Icon(
                              Icons.arrow_downward,
                              color: WHITE,
                            ),
                            iconSize: 16,
                            isExpanded: true,
                            onChanged: (value) {
                              setState(() {
                                filterBy = value;
                                //TODO: a query of new sorting and fetching a new list
                              });
                            },
                            items: filterOptions
                                .map<DropdownMenuItem<String>>((String e) {
                              return DropdownMenuItem(
                                  value: e,
                                  child: Container(
                                      child: Text(e)));
                            }).toList(),
                            underline: Container(
                              height: 2,
                              color: WHITE,
                            ),
                            style: TextStyle(color: WHITE),
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          )),
    );
  }
}

