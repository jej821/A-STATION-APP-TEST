import 'package:flutter/material.dart';
import 'package:pro_charger_app/models/menu_item.dart';
import 'package:pro_charger_app/views/login.dart';
import 'package:pro_charger_app/main.dart';
import 'package:pro_charger_app/views/management_payment.dart';
import 'package:pro_charger_app/views/details_usage.dart';
import 'package:pro_charger_app/views/management_my_info.dart';
import 'package:pro_charger_app/views/client_center.dart';
import 'package:pro_charger_app/views/maps.dart';
import 'package:pro_charger_app/views/qr_code.dart';
import 'package:pro_charger_app/views/http_test.dart';
import 'package:pro_charger_app/views/send_sms.dart';
import 'package:pro_charger_app/views/maps_naver.dart';

class MainMenu extends StatefulWidget {
  @override
  MainMenuState createState() {
    return MainMenuState();
  }
}

class MainMenuState extends State<MainMenu> {
  Widget _appBarTitle;
  Color _appBarBackgroundColor;
  MenuItem _selectedMenuItem;
  List<MenuItem> _menuItems;
  List<Widget> _menuOptionWidgets = [];

  @override
  initState() {
    super.initState();

    _menuItems = createMenuItems();
    _selectedMenuItem = _menuItems.first;
    _appBarTitle = new Text(_menuItems.first.title);
    _appBarBackgroundColor = _menuItems.first.color;
  }

  _getMenuItemWidget(MenuItem menuItem) {
    return menuItem.func();
  }

  _onSelectItem(MenuItem menuItem) {
    setState(() {
      _selectedMenuItem = menuItem;
      _appBarTitle = new Text(menuItem.title);
      _appBarBackgroundColor = menuItem.color;
    });
    Navigator.of(context).pop(); // close side menu
  }

  @override
  Widget build(BuildContext context) {
    _menuOptionWidgets = [];

    for (var menuItem in _menuItems) {
      _menuOptionWidgets.add(new Container(
          decoration: new BoxDecoration(
              color: menuItem == _selectedMenuItem
                  ? Colors.grey[200]
                  : Colors.white),
          child: new ListTile(
              leading: new Image.asset(menuItem.icon, width: 30),
              onTap: () => _onSelectItem(menuItem),
              title: Text(
                menuItem.title,
                style: new TextStyle(
                    fontSize: menuItem == _selectedMenuItem
                        ? 17
                        : 15,
                    color: menuItem.color,
                    fontWeight: menuItem == _selectedMenuItem
                        ? FontWeight.bold
                        : FontWeight.w300),
              ),
          )
      )
      );

      _menuOptionWidgets.add(
        new SizedBox(
          child: new Center(
            child: new Container(
              margin: new EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
              height: 0.3,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return new Scaffold(
        appBar: new AppBar(
        title: _appBarTitle,
        backgroundColor: _appBarBackgroundColor,
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon:new Icon(Icons.qr_code),
            tooltip: 'hi',
            onPressed: ()=>
            {
              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return QRCode();
                  }
              )
              )
            }
    )
        ],
      ),
      drawer: new Drawer(
        child: Column(
          children: <Widget>[
            Expanded(child: ListView(
              children: <Widget>[
                // UserAccountsDrawerHeader(),
              new Container(
                child: new Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.logout),
                          onPressed: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (BuildContext context) => ProChargerApp())
                            );
                          }
                          ),
                      Text('User 님',
                          style: TextStyle(fontSize: 20)
                      ),
                    ]
                ),
                margin: new EdgeInsetsDirectional.only(top: 20.0),
                color: Colors.white,
                constraints: BoxConstraints(maxHeight: 90.0, minHeight: 90.0),
              ),
                new SizedBox(
                  child: new Center(
                    child: new Container(
                      margin:
                      new EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
                      height: 0.3,
                      color: Colors.grey,
                    ),
                  ),
                ),
                new Container(
                  color: Colors.white,
                  child: new Column(children: _menuOptionWidgets),
                )
             ],
            ),
            ),
            Container(
              // This align moves the children to the bottom
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    // This container holds all the children that will be aligned
                    // on the bottom and should not scroll with the above ListView
                    child: Container(
                      color: Colors.white,
                      alignment: Alignment.bottomCenter,
                      child:  new Image.asset('assets/images/home.png', width: 40),
                      margin: new EdgeInsetsDirectional.only(bottom: 20.0),
                      constraints: BoxConstraints(maxHeight: 50.0, minHeight: 50.0),
                    )
                )
            )
          ],
        ),
      ),
      body: _getMenuItemWidget(_selectedMenuItem),
    );
  }

  List<MenuItem> createMenuItems() {
    final menuItems = [
      new MenuItem(
         // "지도", 'assets/images/maps.png', Colors.black, () => new Maps()),
          "지도", 'assets/images/maps.png', Colors.black, () => new NaverMapsApp()),
      new MenuItem(
          "내정보 관리", 'assets/images/my_info.png', Colors.black, () => new ManagementMyInfo()),
      new MenuItem(
          "결제관리", 'assets/images/payment.png', Colors.black, () => new ManagementPayment()),
      new MenuItem(
          "이용내역", 'assets/images/usage.png', Colors.black, () => new DetailsUsage()),
      new MenuItem(
          "고객센터", 'assets/images/client_center.png', Colors.black, () => new ClientCenter()),
      new MenuItem(
          "Http test", 'assets/images/web.png', Colors.black, () => new HttpTest()),
      new MenuItem(
          "SMS test", 'assets/images/message.png', Colors.black, () => new MyApp()),
    ];
    return menuItems;
  }
}