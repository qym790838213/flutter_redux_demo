import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import './redux/Actions.dart';
import './redux/Reducers.dart';



class CounterPage2 extends StatelessWidget {
  final Widget child;
  final Store<AppState> store;
  CounterPage2({Key key, this.child, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: (Store<AppState> store) => store.state.counterPage,
      builder: (context, CounterPageState counterPage) {
        return  new Scaffold(
              appBar: AppBar(
                title: new Text('CounterPage2'),
              ),
              body: new Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Text('Counter is Now :${counterPage.count}'),
                  ],
                ),
              ),
              floatingActionButton: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FlatButton(
                      child:new Text(
                        '+',
                        style: TextStyle(
                          fontSize: 30
                        ),
                      ),
                      onPressed: () {
                        store.dispatch(Action(type: CounterActions.Add));
                      }),
                  FlatButton(
                      child: new Text(
                        '-',
                        style: TextStyle(
                          fontSize: 30
                        ),
                      ),
                      onPressed: () {
                        store.dispatch(Action(type: CounterActions.Minus));
                      })
                ],
              ));
        
      },
    );
  }
}
