import 'package:flutter/material.dart';

class TestMe extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductManagerState();
  }
}

class MainM {
  String name;
  List<SubMainM> subname = [];
}

class SubMainM {
  String name;
}

class ProductManagerState extends State<TestMe> {
  List<MainM> mainmanu;
  @override
  void initState() {
    mainmanu = [];
    MainM main1 = MainM();
    main1.name = 'First';
    SubMainM sub = SubMainM();
    sub.name = 'sub 1';
    SubMainM sub1 = SubMainM();
    sub1.name = 'sub 2';
    main1.subname.add(sub);
    main1.subname.add(sub1);
    mainmanu.add(main1);

    MainM main2 = MainM();
    main2.name = 'Sec';
    SubMainM sub3 = SubMainM();
    sub3.name = 'sub 3';
    SubMainM sub4 = SubMainM();
    sub4.name = 'sub 4';
    main2.subname.add(sub3);
    main2.subname.add(sub4);
    mainmanu.add(main2);
    super.initState();
  }

  int _activeMeterIndex;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mainmanu.length,
      itemBuilder: (BuildContext context, int i) {
        return Card(
          child: ExpansionPanelList(
            expansionCallback: (int index, bool status) {
              setState(() {
                _activeMeterIndex = _activeMeterIndex == i ? null : i;
              });
            },
            children: [
              ExpansionPanel(
                isExpanded: _activeMeterIndex == i,
                headerBuilder: (BuildContext context, bool isExpanded) =>
                    Container(
                  padding: const EdgeInsets.only(left: 15.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    mainmanu[i].name,
                  ),
                ),
                body: Column(
                  children: mainmanu[i].subname.map((e) {
                    return Text(e.name);
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
