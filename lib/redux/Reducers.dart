import './Actions.dart';

class CounterPageState extends Action{
  int count = 0;
  dynamic action;
  CounterPageState({count}){
    this.count =count??0;
  }
}

class UserPageState{
  String username;
  String password;
  
  String nickName;
  dynamic action;
  UserPageState({this.username,this.password});
}
class Action {
  final dynamic type;
  final dynamic payload;
  Action({this.type,this.payload});
}


class AppState{
  CounterPageState counterPage;
  UserPageState userPage;
  AppState({this.counterPage,this.userPage});
 
}

AppState mainReducer(AppState state,dynamic action,){
  if(action.type==CounterActions.Add){
     state.counterPage.count+=1;
  }
  if(action.type==CounterActions.Minus){
    state.counterPage.count-=1;
  }
  if(action.type==CounterActions.SetCount){
    state.counterPage.count = 1;
  }
  if(action.type==UserActions.Login){
    state.userPage = action.payload;
  }
  if(action.type==UserActions.ClearInfo){
    state.userPage = new UserPageState();
  }
  return state;
}