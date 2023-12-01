class User {
  // Tạo thuộc tính cho đối tượng
  int id = 0 ;
  String  name = 'default' ;


  User(this.id, [this.name = 'ccc']);
  //User({this.id = 1,this.name = 'money'});

 // User.name (this.id, this.name);

  // User (int id, String name){
  //   this.id = id;
  //   this.name = name;
  // }

// Tạo constructor
//  User(this.id, this.name);

@override
  String toString() {
    return '$id - $name';
  }

}