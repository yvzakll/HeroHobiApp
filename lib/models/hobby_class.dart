class Hobi {
  String id;
  String isim;

  Hobi({required this.id, required this.isim});

  Map<String, dynamic> toJson() => {
        'id': id,
        'isim': isim,
      };

  factory Hobi.fromJson(Map<String, dynamic> json) => Hobi(
        id: json['id'],
        isim: json['isim'],
      );
}
