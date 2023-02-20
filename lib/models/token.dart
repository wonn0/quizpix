class Token {
  final String access;
  final String refresh;

  Token(this.access, this.refresh);

  Token.fromJson(Map<String, dynamic> json)
      : access = json['access'],
        refresh = json['refresh'];

  Map<String, dynamic> toJson() => {
        'access': access,
        'refresh': refresh,
      };
}
