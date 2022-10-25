
class AddPostModel {
  String? name;
  late String uId;
  String? postImage;
  String? dateTime;
  String? image;
  String? postText;

  AddPostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.dateTime,
    this.postImage,
    required this.postText
  });

  AddPostModel.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    postImage = json['postImage'];
    postText = json['postText'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'name':name,
      'uId':uId,
      'image':image,
      'postText': postText,
      'postImage' : postImage ?? '',
      'dateTime' : dateTime
    };
  }
}