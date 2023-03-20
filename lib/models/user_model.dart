class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    {
      return UserModel(
        id: json['id'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        avatar: json['avatar'],
      );
    }
  }
}

List<UserModel> listDummy = [
  UserModel(
    id: '1',
    email: 'email',
    firstName: 'firstName',
    lastName: 'lastName',
    avatar: 'https://reqres.in/img/faces/1-image.jpg',
  ),
    UserModel(
    id: '2',
    email: 'email',
    firstName: 'firstName',
    lastName: 'lastName',
    avatar: 'https://reqres.in/img/faces/1-image.jpg',
  ),
    UserModel(
    id: '3',
    email: 'email',
    firstName: 'firstName',
    lastName: 'lastName',
    avatar: 'https://reqres.in/img/faces/1-image.jpg',
  ),
    UserModel(
    id: '4',
    email: 'email',
    firstName: 'firstName',
    lastName: 'lastName',
    avatar: 'https://reqres.in/img/faces/1-image.jpg',
  ),
    UserModel(
    id: '5',
    email: 'email',
    firstName: 'firstName',
    lastName: 'lastName',
    avatar: 'https://reqres.in/img/faces/1-image.jpg',
  ),
];
