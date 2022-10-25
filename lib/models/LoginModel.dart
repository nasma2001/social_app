
class LoginModel {
  String? name;
  late String email;
  String? phone;
  late String uId;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;

  LoginModel({
    required this.email,
    this.name,
    this.phone,
    required this.uId,
    this.image = 'https://img.freepik.com/free-photo/photo-thoughtful-handsome-adult-european-man-holds-chin-looks-pensively-away-tries-solve-problem_273609-45891.jpg?w=740&t=st=1662188943~exp=1662189543~hmac=c059040103eb7b2cd7f034fdc63351d0c1a7c8eee80ecfef30c11f0ea314dd51',
    this.cover = 'https://img.freepik.com/free-photo/old-black-background-grunge-texture-dark-wallpaper-blackboard-chalkboard-room-wall_1258-28312.jpg?w=900&t=st=1662188664~exp=1662189264~hmac=5504b2165cd9e8a5de40323d6a15ce78741aa7b1b6c6000166e32c018663f101',
    this.bio = '',
    this.isEmailVerified,
  });

  LoginModel.fromJson(Map<String, dynamic> json)
  {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'image':image,
      'cover':cover,
      'bio':bio,
      'isEmailVerified':isEmailVerified,
    };
  }
}