class Post2 {

int _userId;
int _id;
String _title;

Post2(this._userId, this._id, this._title);

int get userId => _userId;

set userId(int userId){
     _userId = userId;
}

int get id => _id;

set id(int id){
  _id = id;
}

String get title => _title;

set title(String title){
  _title = title;
}

}
