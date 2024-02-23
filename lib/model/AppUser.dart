class AppUser {
  String? userId;
  String? email;
  String? name;
  String? contactNumber;

  AppUser({this.userId, this.email, this.name, this.contactNumber});

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        userId: json["userId"],
        email: json['email'],
        name: json['name'],
        contactNumber: json['contactNumber'],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "name": name,
        if (contactNumber != null && contactNumber!.isNotEmpty) ...{
          "contactNumber": contactNumber,
        },
      };

  @override
  bool operator ==(Object other) => identical(this, other) || other is AppUser && runtimeType == other.runtimeType && userId == other.userId;

  @override
  int get hashCode => userId.hashCode;
}
