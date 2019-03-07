import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import './redux/Actions.dart';
import './redux/Reducers.dart';
import './CounterPage2.dart';



class CounterPage extends StatelessWidget {
  final Widget child;
  final Store<AppState> store;
  CounterPage({Key key, this.child, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: (Store<AppState> store) => store.state,
      builder: (context, AppState appState) {
        return new Scaffold(
            appBar: AppBar(
              title: new Text('CounterPage'),
            ),
            body: new Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: new Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  new Card(
                    child: Column(
                      children: <Widget>[
                        new Text('NickName:${appState.userPage.nickName}'),
                        new Text('UserName:${appState.userPage.username}')
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Expanded(
                    flex: 1,
                    child: new Container(
                      alignment: Alignment.center,
                      child: Text('Counter:${appState.counterPage.count}'),
                    ),
                  )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.navigate_next),
              onPressed: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return CounterPage2(store: store);
                }));
              },
            ),
          );
        
      },
    );
  }
}
