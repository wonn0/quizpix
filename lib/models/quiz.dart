class Quiz {
  final String url;
  final String user;
  final String username;
  final String? image;
  final String title;
  final bool isShared;

  const Quiz(this.url, this.user, this.username, this.image, this.title,
      this.isShared);

  Quiz.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        user = json['user'],
        username = json['username'],
        image = json['image'],
        title = json['title'],
        isShared = json['is_shared'];

  Map<String, dynamic> toJson() => {
        'url': url,
        'user': user,
        'username': username,
        'image': image,
        'title': title,
        'is_shared': isShared,
      };

  @override
  String toString() {
    return '''
      Quiz {
        url: $url,
        user: $user,
        username: $username,
        image: $image,
        title: $title,
        isShared: $isShared,
      }
    ''';
  }
}
