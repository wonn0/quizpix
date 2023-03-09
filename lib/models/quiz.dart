class Quiz {
  final String url;
  final String user;
  final String? image;
  final String title;

  const Quiz(this.url, this.user, this.image, this.title);

  Quiz.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        user = json['user'],
        image = json['image'],
        title = json['title'];

  Map<String, dynamic> toJson() => {
        'url': url,
        'user': user,
        'image': image,
        'title': title,
      };
}
