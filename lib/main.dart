import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import './redux/Reducers.dart';
import './redux/Actions.dart';
import './CounterPage.dart';
import 'dart:async';

void main() {
  Store<AppState> store = new Store<AppState>(mainReducer,
      initialState: new AppState(
          userPage: new UserPageState(), 
          counterPage: new CounterPageState()));
  runApp(new MyAppPage(store: store));
}

class MyAppPage extends StatelessWidget {
  final Widget child;
  final Store<AppState> store;
  final UserPageState userState = new UserPageState();
  MyAppPage({Key key, this.store, this.child}) : super(key: key);

  final GlobalKey<FormState> _loginFormKey = new GlobalKey();

  void onFormSaved(context) async {
   
    if (userState.username.isEmpty || userState.password.isEmpty) {
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                content: new Text('输入不能为空'),
                actions: <Widget>[
                  new FlatButton(
                    child: Text('确定'),
                    onPressed: () {
                      Navigator.pop(context);
                      store.dispatch(Action(
                        type: UserActions.ClearInfo,
                      ));
                    },
                  )
                ],
              ));
      return;
    }
    if (userState.username != 'username' || userState.password != '123456') {
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                content: new Text('账号密码有误'),
                actions: <Widget>[
                  new FlatButton(
                    child: Text('确定'),
                    onPressed: () {
                      Navigator.pop(context);
                      store.dispatch(Action(type: UserActions.ClearInfo));
                    },
                  )
                ],
              ));
      return;
    }
    showDialog(
        context: context,
        builder: (_) {
          return new AlertDialog(
            content: new Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Color.fromARGB(100, 255, 255, 255),
              ),
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(),
                  new Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Text('登陆中...')
                ],
              ),
            ),
          );
        });
    new Future.delayed(new Duration(seconds: 2), () {
      Navigator.pop(context);
      userState.nickName = 'Mike';
      store.dispatch(Action(type: UserActions.Login, payload: userState));
    }).then((_){
      Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (BuildContext context){
            return CounterPage(store:store);
          }
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        title: 'Redux demo',
        theme: new ThemeData(primarySwatch: Colors.blue),
        home: new StoreConnector(
          converter: (Store<AppState> store){
            return store.state.userPage;
          },
          builder: (context, userPage) {
            return new Scaffold(
              appBar: new AppBar(
                title: new Text('UserPage Login'),
              ),
              body: new SafeArea(
                child: new SingleChildScrollView(
                    child: new Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: new BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.red,
                          Colors.blue,
                          Colors.green
                        ])),
                        child: new Container(
                          child: new Form(
                            key: _loginFormKey,
                            child: new Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                ),
                                new Image.asset(
                                  'assets/login_logo.png',
                                  width: 250,
                                  height: 191,
                                ),
                                new Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                ),
                                new Card(
                                  child: new Container(
                                    width: 300,
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    child: new Column(
                                      children: <Widget>[
                                        new TextFormField(
                                          initialValue:
                                              userPage.username ?? 'user',
                                          decoration: new InputDecoration(
                                              icon: new Icon(Icons.email,
                                                  color: Colors.black),
                                              hintText: 'Username',
                                              border: InputBorder.none),
                                          style: new TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                          onSaved: (value) {
                                            userState.username = value;
                                          },
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                        ),
                                        new TextFormField(
                                          initialValue:
                                              userPage.password ?? '123456',
                                          decoration: new InputDecoration(
                                              icon: new Icon(
                                                Icons.lock,
                                                color: Colors.black,
                                              ),
                                              hintText: 'Password',
                                              border: InputBorder.none),
                                          style: new TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                          onSaved: (value) {
                                            userState.password = value;
                                          },
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 20),
                                          child: new Container(
                                            child: new FlatButton(
                                              color: Colors.blue,
                                              onPressed: () {
                                                _loginFormKey.currentState
                                                    .save();
                                                onFormSaved(context);
                                              },
                                              child: new Text(
                                                'Login',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))),
              ),
            );
          },
        ),
      ),
    );
  }
}
