import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> st = ['1','2','3'];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backwardsCompatibility: false,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Color(0xfff58220)),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text("Loan Against Mutual Fund",
              style: TextStyle(
                fontFamily: 'GothamRounded',
                color: Color(0xff043b72),
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              )),
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              child: Column(
                children: [
                  Container(
                    // margin: EdgeInsets.only(top: 30),
                    width: 396,
                    height: 55,
                    decoration: new BoxDecoration(color: Color(0xfff58220)),
                    child: Center(
                      child: Text("Mutual Funds are required as a collateral",
                          style: TextStyle(
                            fontFamily: 'GothamRounded',
                            color: Color(0xffffffff),
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          )),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: 330,
                    // height: 300,
                    decoration: new BoxDecoration(color: Color(0xffffffff)),
                    child: Text(
                        "You can now avail of paperless and instant liquidity against your mutual funds through our Insta Loan Against Mutual Funds facility. This facility can be availed by marking a lien on the mutual funds managed by asset management companies registered with Computer Age Management Solutions Private Limited (“CAMS”), in a few simple clicks.\n",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontFamily: 'GothamRounded',
                          color: Color(0xff48535b),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        )),
                  ),
                ],
              ),
            ),
            TabBar(
              unselectedLabelColor: Colors.black,
              labelColor: Colors.red,
              tabs: [
                Tab(
                  //icon: Icon(Icons.people),
                  text: "Procedure",
                ),
                Tab(
                  //icon: Icon(Icons.person),
                  text: "Feature",
                ),
                Tab(
                  //icon: Icon(Icons.person),
                  text: "Requirement",
                )
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  //Text('1. LOgin and choose <br>2. Click on submit'),
                  //Text('1. run <br>2. chk'),
                  //Text('1. sahdlasd <br>2. cgsdfsdg')],
                  Container(
                    width: 150,
                    child: Text(//st[0]
                      "111111111111111111            222222222222",
                    ),
                  ),
                  Container(
                    width: 150,
                    child: Text(
                      "LOgin and choose 2. Click on submit",
                    ),
                  ),
                  Container(
                    width: 150,
                    child: Text(
                      "This text is very very        shakdjhakshdkahskd",
                    ),
                  )
                ],
                controller: _tabController,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {},
                child: Text('Add products'),
              ),
            )
          ],
        ),
      ),
      //----
    );
  }
}
